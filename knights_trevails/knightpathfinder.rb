require_relative './polytreenode.rb'
require 'set'
require 'byebug'

class KnightPathFinder
    attr_reader :root_node
    attr_accessor :considered_positions

    def initialize(initial_pos)
        if KnightPathFinder.within_board(initial_pos)
            @root_node = PolyTreeNode.new(initial_pos)
        else
            raise RuntimeError.new "Not a valid starting position"
        end
        @considered_positions = Set.new
        @considered_positions.add(initial_pos)
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
        valids.reject! {|pos| @considered_positions.include?(pos) }
        @considered_positions += valids
        return valids

    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty? 
            current_node = queue.shift
            positions = new_move_positions(current_node.value)
            positions.map! { |pos| PolyTreeNode.new(pos) }
            positions.each { |pos| pos.parent = current_node}
            positions.each { |pos| queue.push(pos) }
        end
    end

    def find_path(end_pos)
        end_node = dfs(@root_node, end_pos)
        return trace_path_back(end_node)
    end

    def dfs(node, target)
        return node if node.value == target
        
        node.children.each do |child|
            result = dfs(child, target)
            return result unless result.nil? 
        end
        nil
    end

    def trace_path_back(node)
        path = [node.value]
        return path if node.parent.nil? 

        return trace_path_back(node.parent) + path
    end

end

# debugger
# k = KnightPathFinder.new([0,0])
# k.build_move_tree