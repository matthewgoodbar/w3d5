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

    
end