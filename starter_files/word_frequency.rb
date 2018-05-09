class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
    @filename = filename
  end

  def frequency(word)
      string = File.read @filename
      file_downcase = string.downcase
      file_nopunct = file_downcase.gsub(/[^a-z\s]/ , ' ')
      ary = file_nopunct.split(' ')
      filtered_ary = ary.delete_if { |a| STOP_WORDS.include?(a)}
      num = filtered_ary.count(word)
  end

  def frequencies
    string = File.read @filename
    file_downcase = string.downcase
    file_nopunct = file_downcase.gsub(/[^a-z\s]/ , ' ')
    ary = file_nopunct.split(' ')
    filtered_ary = ary.delete_if { |a| STOP_WORDS.include?(a)}
    no_repeats = filtered_ary.uniq
    freq_results = no_repeats.map do |x|
                    numb = frequency(x)
                    [x, numb]
                  end
    freq_results.to_h
  end

  def top_words(number)
    hash = frequencies
    array = hash.to_a
    sorted = array.sort_by { |k, v| [-v, k] }
    (0..(number - 1)).map { |i| sorted[i] }
  end

  def print_report
    top_words(5) 
  end
end

if __FILE__ == $PROGRAM_NAME
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
