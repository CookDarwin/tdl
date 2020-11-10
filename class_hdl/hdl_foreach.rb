module ClassHDL

    class BlockFOREACH < BlockELSE
        attr_accessor :flag
        def instance(as_type= :cond)
           
            head_str = "foreach(#{cond.to_s}[#{flag}])begin"

            sub_str = []
            opertor_chains.each do |oc|
                unless oc.is_a? BlockIF
                    unless oc.slaver
                        sub_str.push "    #{oc.instance(as_type)};"
                    end
                else 
                    sub_str.push( oc.instance(as_type).gsub(/^./){ |m| "    #{m}"} )
                end
            end

            return "#{head_str}\n#{sub_str.join("\n")}\nend"

        end
    end
end

class SdlModule
    @@__foreach_index_cnt__ = 0
    def FOREACH(cond,&block)
        ClassHDL::AssignDefOpertor.with_normal_opertor do 
            @@__foreach_index_cnt__ += 1
        end
        new_op = ClassHDL::BlockFOREACH.new

        ClassHDL::AssignDefOpertor.with_new_opertor do 
            ClassHDL::AssignDefOpertor.with_new_assign_block(new_op) do |ab|
                if cond.is_a? ClassHDL::OpertorChain
                    cond.slaver = true
                end
                ab.cond = cond
                ab.flag = "i#{@@__foreach_index_cnt__}".to_nq
                block.call(ab.flag)

            end
        end 
        
        ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
        ClassHDL::AssignDefOpertor.with_normal_opertor do 
            @@__foreach_index_cnt__ -= 1
        end
        return new_op
    end
end