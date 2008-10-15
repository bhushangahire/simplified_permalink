class String

  def normalize
    ActiveSupport::Multibyte::Handlers::UTF8Handler.normalize(self,:d).split(//u).reject { |e| e.length > 1 }.join
  end

  def to_url
    self.normalize.gsub(/\W+/, ' ').strip.gsub(/\ +/, '-').downcase
  end

end
