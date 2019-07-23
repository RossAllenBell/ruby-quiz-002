def main
  people = get_data
  people = people.shuffle
  people = people.sort_by.with_index do |person, index|
    [people.select{|p| p.family_name == person.family_name}.count, index]
  end.reverse

  possible_recipients = people.dup.reverse

  santas_to_recipients = {}
  people.each do |santa|
    assignment = possible_recipients.detect do |recipient|
      santa.family_name != recipient.family_name
    end
    santas_to_recipients[santa] = assignment
    possible_recipients.delete(assignment)
  end

  santas_to_recipients.each do |santa, recipient|
    if santa.family_name == recipient.family_name
      puts "WARNING - SAME FAMILY ASSIGNMENT"
    end
    puts "#{santa.full_name} => #{recipient.full_name}, #{recipient.email}"
  end
end

def get_data
  lines = []
  while line = gets do
      lines << line
  end
  lines = lines.map(&:strip).select do |line|
    line.size > 0
  end

  return lines.map do |line|
    line.split(/\s+/)
  end.map do |first_name, family_name, email|
    Person.new(first_name: first_name, family_name: family_name, email: email)
  end
end

class Person
  attr_accessor :first_name, :family_name, :email

  def initialize(first_name:, family_name:, email:)
    self.first_name = first_name
    self.family_name = family_name
    self.email = email
  end

  def full_name
    [first_name, family_name].join(' ')
  end
end

main
