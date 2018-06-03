local phys = ent:GetPhysicsObject()
phys:EnableMotion( not phys:IsMotionEnabled() )
