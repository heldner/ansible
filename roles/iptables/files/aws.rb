#!/usr/bin/env ruby

require 'optparse'
require 'ostruct'
require 'net/http'
require 'json'
require 'ipset'

module AWS

  class Client

    AWS_API_URL = 'https://ip-ranges.amazonaws.com/ip-ranges.json'
    IPSET_LIST = ENV['IPSET_LIST'] || 'aws_access'

    def initialize(opts)
      if opts.verbose
        @loglevel = 'DEBUG'
      end
      case opts.service
      when "route53"
        @service = 'ROUTE53_HEALTHCHECKS'
      when "cloudfront"
        @service = 'CLOUDFRONT'
      else
        puts "Unknown service type. See help"
        exit(1)
      end

    end

    def request
      uri = URI("#{AWS_API_URL}")
      req = Net::HTTP::Get.new(uri)
      res = Net::HTTP.start(uri.hostname, uri.port,
                           :use_ssl => uri.scheme == 'https') do |http|
        http.request(req)
      end
      #puts "#{res.body}"
      return res.body
    rescue Exception => e
      raise "Request failed: #{e.message} #{e.backtrace}"
    end

    def show_probes
      probes = JSON::parse(request)['prefixes']
      $log.debug "Probes: #{JSON::pretty_generate(probes)}"
      ips = []
      probes.map do |probe|
        if probe['service'] == @service
          ips.push(probe['ip_prefix'])
        end
      end
      $log.debug "Selected ips: #{JSON::pretty_generate(ips)}"
      return ips
    end

    def update_ipset
      Ipset::IpsetRuler.new(@loglevel).update_ipset_list(IPSET_LIST,show_probes)
    end

  end # class Client


  class OptParser

    def self.parse(args)
      options = OpenStruct.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [options]"

        opts.separator ""
        opts.separator "Options:"

        opts.on("-v", "--verbose", "Debug output") do
          options.verbose = true
        end

        opts.on("--service SERVICE", "AWS service type https://docs.aws.amazon.com/general/latest/gr/aws-ip-ranges.html") do |s|
          options.service = s
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end  #OptionParser.new
      opt_parser.parse!(args)
      options
    end  # parse()

  end  # class NginxConfOptionParser

end # module AWS

if __FILE__ == $0
  options = AWS::OptParser.parse(ARGV)
  p = AWS::Client.new(options)
  p.update_ipset
end
