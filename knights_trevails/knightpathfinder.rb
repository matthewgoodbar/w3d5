require_relative './polytreenode.rb'

class KnightPathFinder
    def initialize(initial_pos)
        @root_node = PolyTreeNode.new(initial_pos)
    end
end