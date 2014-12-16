module DropboxUpload
  module RawLink
    def raw_file_link(url)
      return nil unless url

      generate_raw_link(url)
    end

    def download_link(url)
      agent = Mechanize.new
      agent.redirect_ok = false
      page = agent.get url

      page.header.fetch("location")
    end

    def generate_raw_link(url)
      download_link(url).split('?').first + "?raw=1"
    end
  end
end
