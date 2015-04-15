function x = condition(cb,cr,H,S)
     x = (cb >= 77 & cb <= 127 & cr >= 133 & cr <= 173 & H > 0 & H <0.2 & S > 0.2 & S<0.7).* 0 + (~(cb >= 77 & cb <= 127 & cr >= 133 & cr <= 173 & H > 0 & H <0.2 & S > 0.2 & S<0.7).* 1);
end
