class Logger
  private_class_method :new

  NOT_CHANGED_FILE = 'logs/not_changed.log'
  SUCCESS_FILE = 'logs/success.log'
  ALREADY_POSTED_FILE = 'logs/already_posted.log'

  def self.success original, translation
    puts "postado: #{translation}"
    write "#{original}:\n\t#{translation}", SUCCESS_FILE
  end

  def self.error text
    puts "ERRO: #{text}"
    write text, NOT_CHANGED_FILE
  end

  def self.mark_as_posted text
    chcksm = checksum text
    write chcksm, ALREADY_POSTED_FILE
  end

  def self.already_posted? text
    chcksm = checksum text
    File.read(ALREADY_POSTED_FILE).split("\n").each do |line|
      return true if line == chcksm
    end
    false
  end

  def self.clean_already_posted
    puts 'checksums antigas limpas'
    lines = File.read(ALREADY_POSTED_FILE).split("\n")
    new_file = ''
    File.open(ALREADY_POSTED_FILE, 'w') do |file|
      lines.each do |line|
        file.write "#{line}\n" if line.split(" - ").first == Date.today.to_s
      end
    end
  end

  private
  def self.checksum text
    "#{Date.today.to_s} - #{Digest::MD5.hexdigest text}"
  end

  def self.write text, filename
    File.open(filename, 'a') do |file|
      file.write "#{text}\n"
    end
  end
end