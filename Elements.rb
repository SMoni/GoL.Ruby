module Elements

    def getNumberOfElements()
        self.partial_inject(1) do |accumulator, entry|
            accumulator * entry
        end
    end
    
    def partial_inject(initial_value)
        
        inject([initial_value, [initial_value]]) do |(accumulated, output), element|
            new_value = yield(accumulated, element)
            [new_value, output << new_value]
        end[1]
        
    end
end

