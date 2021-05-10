class ResultsCountSerializer

    def initialize(count)
        @count = count 
    end

    def to_serialized_json
        @count.as_json
    end
end