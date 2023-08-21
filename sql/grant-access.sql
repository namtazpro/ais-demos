-- Add a user, specifying the name in AD. When a user is added, it gets login access.
CREATE USER [ENT-APP-NAME] FROM external provider
-- grant access to that user to execute stored proc
 grant execute on object::GetProducts to [ENT-APP-NAME] 