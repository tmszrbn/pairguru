class TitleBracketsValidator < ActiveModel::Validator
  @@brackets = {
    opening: ["{", "[", "("],
    closing: ["}", "]", ")"]
  }

  def validate(record)
    unless brackets_match? record.title
      record.errors.add :title, "Should have matching brackets"
    end
  end

  private

  def brackets_match?(title)
    brackets_to_match = []
    previous_l = ""
    title.split("").each do |l|
      if @@brackets[:closing].include? l
        return false if empty_brackets? previous_l, l
        return false unless bracket_matches? brackets_to_match.pop, l
      elsif @@brackets[:opening].include? l
        brackets_to_match.push l
      end
      previous_l = l
    end
    true if brackets_to_match.empty?
  end

  def bracket_matches?(previous_bracket, current_bracket)
    prev_index_in_opening = @@brackets[:opening].index previous_bracket
    curr_index_in_closing = @@brackets[:closing].index current_bracket
    true if prev_index_in_opening == curr_index_in_closing
  end

  def empty_brackets?(previous_character, current_character)
    prev_in_opening = @@brackets[:opening].include? previous_character
    curr_in_closing = @@brackets[:closing].include? current_character
    true if prev_in_opening && curr_in_closing
  end
end
