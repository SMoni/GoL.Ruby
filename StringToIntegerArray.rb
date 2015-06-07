module StringToIntegerArray
    def asArray
        return self.split(",").map(&:to_i)
    end
end
