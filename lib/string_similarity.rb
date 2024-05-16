# frozen_string_literal: true

require_relative "string_similarity/version"

module StringSimilarity
  class DamerauLevenshtein
    def initialize(string1, string2, case_sensitivity = true)
      @string1 = string1
      @string2 = string2
      @case_sensitivity = case_sensitivity
    end

    def demaru_similarity
      str1 = @case_sensitivity ? @string1 : @string1.downcase 
      str2 = @case_sensitivity ? @string2 : @string2.downcase 
      distances = Array.new(str1.length + 1) { Array.new(str2.length + 1) }

      # Initialize the matrix
      (0..str1.length).each { |i| distances[i][0] = i }
      (0..str2.length).each { |j| distances[0][j] = j }
    
      # Populate the matrix with edit distances
      (1..str1.length).each do |i|
        (1..str2.length).each do |j|
          cost = (str1[i - 1] == str2[j - 1]) ? 0 : 1
          distances[i][j] = [
            distances[i - 1][j] + 1,           # Deletion
            distances[i][j - 1] + 1,           # Insertion
            distances[i - 1][j - 1] + cost,    # Substitution
          ].min
    
          # Check for transposition
          if i > 1 && j > 1 && str1[i - 1] == str2[j - 2] && str1[i - 2] == str2[j - 1]
            distances[i][j] = [distances[i][j], distances[i - 2][j - 2] + cost].min
          end
        end
      end
    
      # Calculate the similarity
      max_length = [str1.length, str2.length].max
      similarity = (1 - (distances[str1.length][str2.length] / max_length.to_f)) * 100
      similarity.round(2)
    end

  end
end
