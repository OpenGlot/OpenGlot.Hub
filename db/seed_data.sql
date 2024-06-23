
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


INSERT INTO "Languages" ("Name", "Code", "Description") VALUES
('Chinese', 'zh', 'Chinese Language'),
('Korean', 'ko', 'Korean Language'),
('English', 'en', 'English Language'),
('Japanese', 'ja', 'Japanese Language'),
('Russian', 'ru', 'Russian Language'),
('Spanish', 'es', 'Spanish Language'),
('French', 'fr', 'French Language'),
('German', 'de', 'German Language'),
('Italian', 'it', 'Italian Language'),
('Arabic', 'ar', 'Arabic Language');

-- Insert test data into the Course table
DO $$ 
DECLARE 
    row RECORD; 
BEGIN 
    FOR row IN (SELECT "Id" FROM "Languages") LOOP
        INSERT INTO "Courses" ("Title", "Description", "LanguageId") 
        VALUES ('Course 1 for ' || row."Id", 'Description 1', row."Id"),
               ('Course 2 for ' || row."Id", 'Description 2', row."Id");
    END LOOP;
END $$;

-- Insert test data into the Module table
DO $$
DECLARE row RECORD; 
BEGIN
    FOR row IN (SELECT "Id" FROM "Courses") LOOP
        INSERT INTO "Modules" ("Title", "Description", "CourseId") 
        VALUES ('Module 1 for ' || row."Id", 'Module Description 1', row."Id"),
               ('Module 2 for ' || row."Id", 'Module Description 2', row."Id");
    END LOOP;
END $$;

-- Insert test data into the Lesson table
DO $$
DECLARE row RECORD; 
BEGIN
    FOR row IN (SELECT "Id" FROM "Modules") LOOP
        INSERT INTO "Lessons" ("Title", "ContentType", "CreatedAt", "ModuleId") 
        VALUES ('Lesson 1 for ' || row."Id", 3, NOW(), row."Id"),
               ('Lesson 2 for ' || row."Id", 3, NOW(), row."Id");
    END LOOP;
END $$;

-- Insert test data into the Image table
INSERT INTO "Images" ("UrlKey", "Description", "UploadedAt") VALUES
('image_1.jpg', 'Image Description 1', NOW()),
('image_2.jpg', 'Image Description 2', NOW()),
('image_3.jpg', 'Image Description 3', NOW()),
('image_4.jpg', 'Image Description 4', NOW()),
('image_5.jpg', 'Image Description 5', NOW()),
('image_6.jpg', 'Image Description 6', NOW()),
('image_7.jpg', 'Image Description 7', NOW()),
('image_8.jpg', 'Image Description 8', NOW()),
('image_9.jpg', 'Image Description 9', NOW()),
('image_10.jpg', 'Image Description 10', NOW());

-- Insert test data into the Audio table
INSERT INTO "Audios" ("UrlKey", "Transcript", "EnglishTranslation", "LanguageId", "UploadedAt") VALUES
('audio_1.mp3', 'Transcript 1', 'Translation 1', (SELECT "Id" FROM "Languages" WHERE "Name"='Chinese'), NOW()),
('audio_2.mp3', 'Transcript 2', 'Translation 2', (SELECT "Id" FROM "Languages" WHERE "Name"='Korean'), NOW()),
('audio_3.mp3', 'Transcript 3', 'Translation 3', (SELECT "Id" FROM "Languages" WHERE "Name"='English'), NOW()),
('audio_4.mp3', 'Transcript 4', 'Translation 4', (SELECT "Id" FROM "Languages" WHERE "Name"='Japanese'), NOW()),
('audio_5.mp3', 'Transcript 5', 'Translation 5', (SELECT "Id" FROM "Languages" WHERE "Name"='Russian'), NOW()),
('audio_6.mp3', 'Transcript 6', 'Translation 6', (SELECT "Id" FROM "Languages" WHERE "Name"='Spanish'), NOW()),
('audio_7.mp3', 'Transcript 7', 'Translation 7', (SELECT "Id" FROM "Languages" WHERE "Name"='French'), NOW()),
('audio_8.mp3', 'Transcript 8', 'Translation 8', (SELECT "Id" FROM "Languages" WHERE "Name"='German'), NOW()),
('audio_9.mp3', 'Transcript 9', 'Translation 9', (SELECT "Id" FROM "Languages" WHERE "Name"='Italian'), NOW()),
('audio_10.mp3', 'Transcript 10', 'Translation 10', (SELECT "Id" FROM "Languages" WHERE "Name"='Arabic'), NOW());

-- Insert test data into the Question table
DO $$
DECLARE row RECORD; 
BEGIN
    FOR row IN (SELECT "Id" FROM "Lessons" LIMIT 10) LOOP
        INSERT INTO "Questions" ("Text", "QuestionType", "Answer", "LessonId", "AudioId", "ImageId") 
        VALUES ('Question 1 for ' || row."Id", 6, 'Answer 1', row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_1.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_1.jpg')),
               ('Question 2 for ' || row."Id", 6, 'Answer 2', row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_2.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_2.jpg')),
               ('Question 3 for ' || row."Id", 6, 'Answer 3', row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_3.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_3.jpg')),
               ('Question 4 for ' || row."Id", 6, 'Answer 4', row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_4.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_4.jpg')),
               ('Question 5 for ' || row."Id", 6, 'Answer 5', row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_5.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_5.jpg')),
               ('Question 6 for ' || row."Id", 6, 'Answer 6', row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_6.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_6.jpg')),
               ('Question 7 for ' || row."Id", 6, 'Answer 7', row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_7.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_7.jpg')),
               ('Question 8 for ' || row."Id", 6, 'Answer 8', row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_8.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_8.jpg')),
               ('Question 9 for ' || row."Id", 6, 'Answer 9', row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_9.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_9.jpg')),
               ('Question 10 for ' || row."Id", 6, 'Answer 10', row."Id",(SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_10.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_10.jpg'));
    END LOOP;
END $$;


-- Insert test data into the Option table
DO $$
DECLARE row RECORD; 
BEGIN
    FOR row IN (SELECT "Id" FROM "Questions") LOOP
        INSERT INTO "Options" ("Text", "AudioId", "ImageId", "QuestionId") 
        VALUES ('Option 1 for ' || row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_1.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_1.jpg'), row."Id"),
               ('Option 2 for ' || row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_2.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_2.jpg'), row."Id"),
               ('Option 3 for ' || row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_3.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_3.jpg'), row."Id"),
               ('Option 4 for ' || row."Id", (SELECT "Id" FROM "Audios" WHERE "UrlKey"='audio_4.mp3'), (SELECT "Id" FROM "Images" WHERE "UrlKey"='image_4.jpg'), row."Id");
    END LOOP;
END $$;

-- Drop the temporary table if it already exists
DROP TABLE IF EXISTS temp_users;

-- Create a temporary table with GUID and email
CREATE TEMPORARY TABLE temp_users (
    id uuid,
    email text
);

DELETE FROM temp_users;

-- Insert 2 rows of data into the temporary table
INSERT INTO temp_users (id, email) VALUES 
('f4d82458-40e1-7008-40e2-cd45634a3da8', 'e@gmail.com'),
('4438e4d8-0051-706a-e62e-caf930ebf153', '7@gmail.com');


-- Variables for GUID and email for UserProfiles
DO $$
DECLARE
    user_record RECORD;
    i int := 1;
BEGIN
    FOR user_record IN (SELECT * FROM temp_users) LOOP
        INSERT INTO "UserProfiles" ("UserId", "Username", "Email", "NativeLanguage", "TargetLanguage", "TargetLanguageLevel", "DateOfBirth", "TimeZone", "UserRole") 
        VALUES (user_record.id, 'user' || i, user_record.email, 'English', 'Spanish', 'Beginner', '2000-01-01', 'UTC', 0);

        -- Add test data into the Badge table
        INSERT INTO "Badges" ("UserId", "BadgeName", "AwardedAt") 
        VALUES (user_record.id, 'Badge ' || i, NOW());

        -- Add test data into the Flashcard table
        INSERT INTO "Flashcards" ("UserId", "Front", "Back", "CreatedAt") 
        VALUES (user_record.id, 'Front ' || i, 'Back ' || i, NOW());

        -- Add test data into the Progress table
        INSERT INTO "Progresses" ("UserId", "CourseId", "ModuleId", "CompletionPercentage", "LastUpdated") 
        VALUES (user_record.id, 
                (SELECT "Id" FROM "Courses" LIMIT 1 OFFSET i-1), 
                (SELECT "Id" FROM "Modules" LIMIT 1 OFFSET i-1),
                i*10, 
                NOW());
        
        i := i + 1;
    END LOOP;
END $$;