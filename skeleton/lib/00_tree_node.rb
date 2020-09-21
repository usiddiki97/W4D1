rootrequire "byebug"
class PolyTreeNode


    attr_reader :parent, :value, :children
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(set_parent)
        self.parent.children.delete(self) unless self.parent.nil?
        @parent = set_parent
        set_parent.children << self unless set_parent.nil?
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "is not a child" unless self.children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            search = child.dfs(target_value)
            unless search.nil?
                return search
            end
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty?
            node = queue.shift
            return node if node.value == target_value
            queue += node.children
        end
        nil
    end

    def inspect
        @value
    end
end