module Jekyll
  class TagPageGenerator < Generator
    safe true

    def generate(site)
      tags = site.documents.flat_map { |post| post.data['tags'] || [] }.to_set
      tags.each do |tag|
        site.pages << TagPage.new(site, site.source, tag)
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, tag)
      @site = site
      @base = base
      @dir  = File.join('topics', tag)
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'topic.html')
      self.data['tag'] = tag
      self.data['title'] = "Topics / " + tag.capitalize
    end
  end
end