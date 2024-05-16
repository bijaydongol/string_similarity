RSpec.describe StringSimilarity::DamerauLevenshtein do
  context 'when case sensitivity is enabled' do
    it 'calculates the similarity between two strings' do
      demaru = StringSimilarity::DamerauLevenshtein.new("MARTHA", "MARHTA")
      expect(demaru.demaru_similarity).to eq(83.33)
    end

    it 'calculates the similarity between two different strings' do
      demaru = StringSimilarity::DamerauLevenshtein.new("DWAYNE", "DUANE")
      expect(demaru.demaru_similarity).to eq(66.67)
    end
  end

  context 'when case sensitivity is disabled' do
    it 'calculates the similarity between two strings' do
      demaru = StringSimilarity::DamerauLevenshtein.new("MARTHA", "marhta", false)
      expect(demaru.demaru_similarity).to eq(83.33)
    end

    it 'calculates the similarity between two different strings' do
      demaru = StringSimilarity::DamerauLevenshtein.new("DwAyNe", "duane", false)
      expect(demaru.demaru_similarity).to eq(66.67)
    end
  end
end