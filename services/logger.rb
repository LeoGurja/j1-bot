class Logger
  private_class_method :new

  NOT_CHANGED_FILE = 'logs/not_changed.log'
  SUCCESS_FILE = 'logs/success.log'

  def self.success original, translation
    write "#{original}:\n\t#{translation}", SUCCESS_FILE
  end

  def self.error text
    write text, NOT_CHANGED_FILE
  end

  private
  def self.write text, filename
    File.open(filename, 'a') do |file|
      file.write "#{text}\n"
    end
  end
end