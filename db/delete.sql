-- Delete all rows from dependent tables first, followed by the main tables
-- Note: This script assumes that ON DELETE CASCADE is not set on foreign key constraints

-- Disable foreign key checks (specific to PostgreSQL)
SET session_replication_role = replica;

-- Deleting rows from dependent tables

-- StoryChoices must be deleted before InteractiveStorybooks
DELETE FROM "StoryChoices";

-- Questions must be deleted before Lessons
DELETE FROM "Options";

-- Ratings must be deleted before Users and Lessons
DELETE FROM "Ratings";

-- Progresses must be deleted before Users, Courses, and Modules
DELETE FROM "Progresses";

-- Badges must be deleted before Users
DELETE FROM "Badges";

-- Notifications must be deleted before Users
DELETE FROM "Notifications";

-- Flashcards must be deleted before Users
DELETE FROM "Flashcards";

-- UserGeneratedContents must be deleted before Users
DELETE FROM "UserGeneratedContents";

-- Subscriptions must be deleted before Users
DELETE FROM "Subscriptions";

-- Lessons must be deleted before Modules
DELETE FROM "Lessons";

-- Modules must be deleted before Courses
DELETE FROM "Modules";

-- Courses must be deleted before Languages
DELETE FROM "Courses";

-- Audios are a dependency for Questions and Options
DELETE FROM "Audios";

-- Images are a dependency for Questions and Options
DELETE FROM "Images";

-- UserRoles must be deleted before Roles and Users
DELETE FROM "UserProfiles";

-- Main tables deletion
DELETE FROM "__EFMigrationsHistory";
DELETE FROM "InteractiveStorybooks";
DELETE FROM "Languages";
DELETE FROM "Roles";
-- Finally, delete rows from the Users table as it doesn't have dependencies anymore
DELETE FROM "UserProfiles";

-- Re-enable foreign key checks
SET session_replication_role = origin;
