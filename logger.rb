class Logger
    def initialize file_name
        @file_name = 'logs/' + file_name
    end

    def info text
        write "[#{Time.now}] INFO: \n\t#{text}"
    end

    def error text, message
        write "[#{Time.now}] ERROR: #{message}\n\t#{text}"
    end

    def warning text, message
        write "[#{Time.now}] WARNING: #{message}\n\t#{text}"
    end
    
    private
    def write text
        File::open(@file_name, 'a') do |file|
            file.write text + "\n"
        end
    end
end