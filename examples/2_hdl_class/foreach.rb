require_relative '../../tdl.rb'
TdlBuild.test_foreach(File.join(__dir__,"tmp")) do 

    logic[32][32]   - 'data'

    always_comb do 
        FOREACH(data) do |i|
            IF i == 0 do
                data[i] <= 0.A 
            end 
            ELSE do 
                FOREACH data[i] do |ii|
                    data[i][ii] <= 1.A 
                end
            end
        end
    end

end