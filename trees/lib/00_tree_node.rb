require 'byebug'

class PolyTreeNode
    attr_reader :value, :parent
    attr_accessor :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        return if node.nil? && parent.nil?
        if @parent.nil?
            @parent = node
            node.children << self
        else
            if node.nil?
                @parent.children.delete(self)
                @parent = nil 
            elsif node.children.include?(self)
                return
            else
                @parent.children.delete(self)
                @parent = node
                node.children << self 
            end
        end
    end

    def add_child(node)
        return if @children.include?(node)
        node.parent = self
    end

    def remove_child(node)
        if @children.include?(node)
            node.parent = nil
        else
            raise RuntimeError.new "child not found"
        end 
    end

    def dfs(target)
        #return node if node == target
        #for each child of node
        #   result = dfs(child, target)
        #   return result unless result is nil
        #return nil
        return self if self.value == target
        @children.each do |child|
            result = child.dfs(target)
            return result unless result.nil?
        end
        return nil
    end

    def bfs(target)
        #initialize queue
        #push self into queue
        #until queue.empty? 
        #   ele = queue.shift
        #   return ele if ele.value == target
        #   queue.push(ele.children)
        #end
        #return nil
        queue = [self]
        until queue.empty? 
            ele = queue.shift
            return ele if ele.value == target
            ele.children.each { |child| queue.push(child) }
        end
        nil
    end


    def inspect
        #"<PolyTreeNode:#{self.object_id}, val:#{@value}, children:#{@children}>"
        "<PolyTreeNode:#{@value}>"
    end
    
end

# a = PolyTreeNode.new('A')
# b = PolyTreeNode.new('B')
# c = PolyTreeNode.new('C')
# b.parent = a
# c.parent = a
# a.dfs('C')