module IntegerArrayToString
    def asString
        return self.join(",")
    end
end

module StringToIntegerArray
    def asArray
        return self.split(",").map(&:to_i)
    end
end
