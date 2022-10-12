# frozen_string_literal: true

RSpec.describe Seam::Todo do
  subject(:todo) { Seam::Todo.new }

  describe ".todo" do
    it "returns todo" do
      expect(todo.todo).to be "TODO"
    end
  end
end
