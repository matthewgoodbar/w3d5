require_relative './polytreenode.rb'

class KnightPathFinder
    attr_accessor :considered_positions

    def initialize(initial_pos)
        if KnightPathFinder.within_board(initial_pos)
            root_node = PolyTreeNode.new(initial_pos)
        else
            raise RuntimeError.new "Not a valid starting position"
        end
        @considered_positions = [initial_pos]
    end

    def self.valid_moves(pos)
        additions = [[1,2],[-1,2],[1,-2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]]
        res = additions.map {|addition| [addition[0]+pos[0], addition[1]+pos[1]] }
        res.reject! {|position| !KnightPathFinder.within_board(position)}
        return res
    end

    def self.within_board(pos)
        return false if pos.any? {|index| index > 7 || index < 0}
        return true
    end

    def new_move_positions(pos)
        valids = KnightPathFinder.valid_moves(pos)
        @considered_positions += valids
        return valids

    end

    def build_move_tree
        queue = [@root_node]
        considered_positions = Set.new
        considered_positions.add(@root_node)
        until queue.empty? 
            current_node = queue.pop
            positions = new_move_positions(current_node.value)
            positions.map! { |pos| PolyTreeNode.new(pos) }
            positions.reject! { |pos| considered_positions.include?(pos) }
            positions.each { |pos| considered_positions.add(pos) }
            positions.each { |pos| pos.parent = current_node}
            positions.each { |pos| queue.unshift(pos) }
        end
    end
end