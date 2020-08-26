DROP TABLE IF EXISTS LumeDB.dbo.PersonAuth; 
DROP TABLE IF EXISTS LumeDB.dbo.FeedbackImageContent; 
DROP TABLE IF EXISTS LumeDB.dbo.Feedback; 
DROP TABLE IF EXISTS LumeDB.dbo.PersonFriendList;
DROP TABLE IF EXISTS LumeDB.dbo.PersonToEvent;
DROP TABLE IF EXISTS LumeDB.dbo.PersonToChat;
DROP TABLE IF EXISTS LumeDB.dbo.PersonToBadge;
DROP TABLE IF EXISTS LumeDB.dbo.EventImageContent;
DROP TABLE IF EXISTS LumeDB.dbo.EventSwipeHistory;
DROP TABLE IF EXISTS LumeDB.dbo.PersonSwipeHistory;
DROP TABLE IF EXISTS LumeDB.dbo.EventTypeToEvent;
DROP TABLE IF EXISTS LumeDB.dbo.Event;
DROP TABLE IF EXISTS LumeDB.dbo.EventType;
DROP TABLE IF EXISTS LumeDB.dbo.EventStatus;
DROP TABLE IF EXISTS LumeDB.dbo.ChatImageContent;
DROP TABLE IF EXISTS LumeDB.dbo.ChatMessage;
DROP TABLE IF EXISTS LumeDB.dbo.Person;
DROP TABLE IF EXISTS LumeDB.dbo.Chat;
DROP TABLE IF EXISTS LumeDB.dbo.PersonImageContent;
DROP TABLE IF EXISTS LumeDB.dbo.ParticipantStatus;
DROP TABLE IF EXISTS LumeDB.dbo.City;
DROP TABLE IF EXISTS LumeDB.dbo.Badge;

CREATE TABLE LumeDB.dbo.PersonAuth (
	PersonAuthId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	PersonUid uniqueidentifier NOT NULL UNIQUE,
	AccessKey nvarchar(50) NULL,
	RefreshKey nvarchar(50) NULL,
	ExpirationTime datetime2(7) NULL,
	TemporaryCode nvarchar(6) NULL,
	PhoneNumber nvarchar(20) NOT NULL UNIQUE,
	CONSTRAINT PK_PersonAuthId PRIMARY KEY CLUSTERED (PersonAuthId)
);

CREATE TABLE LumeDB.dbo.Badge (
	BadgeId bigint IDENTITY(0,1) NOT NULL UNIQUE,
	BadgeImageUid uniqueidentifier NOT NULL UNIQUE,
	Name nvarchar(200) NULL,
	CONSTRAINT PK_BadgeId PRIMARY KEY CLUSTERED (BadgeId)
);

CREATE TABLE LumeDB.dbo.PersonImageContent (
	PersonImageContentId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	PersonImageContentUid uniqueidentifier NOT NULL UNIQUE,
	CONSTRAINT PK_PersonImageContentId PRIMARY KEY CLUSTERED (PersonImageContentId)
);

CREATE TABLE LumeDB.dbo.City (
	CityId bigint IDENTITY(0,1) NOT NULL UNIQUE,
	CityName nvarchar(200) NOT NULL UNIQUE,
	CONSTRAINT PK_CityId PRIMARY KEY CLUSTERED (CityId)
);

CREATE TABLE LumeDB.dbo.Person (
	PersonId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	PersonUid uniqueidentifier NOT NULL UNIQUE,
	Name nvarchar(200) NULL,
	Description nvarchar(800) NULL,
	Login nvarchar(400) NULL,
	Age tinyint NULL,
	PersonImageContentId bigint NULL,
	CityId bigint NULL,
	Token nvarchar(400) NULL,
	CONSTRAINT FK_Person_PersonImageContent FOREIGN KEY (PersonImageContentId) REFERENCES LumeDB.dbo.PersonImageContent (PersonImageContentId),
	CONSTRAINT FK_Person_City FOREIGN KEY (CityId) REFERENCES LumeDB.dbo.City (CityId),
	CONSTRAINT PK_PersonId PRIMARY KEY CLUSTERED (PersonId)
);

CREATE TABLE LumeDB.dbo.EventType (
	EventTypeId bigint IDENTITY(0,1) NOT NULL UNIQUE,
	EventTypeName nvarchar(100) NOT NULL UNIQUE,
	CONSTRAINT PK_EventTypeId PRIMARY KEY CLUSTERED (EventTypeId)
);

CREATE TABLE LumeDB.dbo.EventStatus (
	EventStatusId bigint IDENTITY(0,1) NOT NULL UNIQUE,
	EventStatusName nvarchar(100) NOT NULL UNIQUE,
	CONSTRAINT PK_EventStatusId PRIMARY KEY CLUSTERED (EventStatusId)
);

CREATE TABLE LumeDB.dbo.ParticipantStatus (
	ParticipantStatusId bigint IDENTITY(0,1) NOT NULL UNIQUE,
	ParticipantStatusName nvarchar(100) NOT NULL UNIQUE,
	CONSTRAINT PK_ParticipantStatusId PRIMARY KEY CLUSTERED (ParticipantStatusId)
);

CREATE TABLE LumeDB.dbo.Chat (
	ChatId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	ChatUid uniqueidentifier NOT NULL UNIQUE,
	IsGroupChat bit NOT NULL DEFAULT 0,
	CONSTRAINT PK_ChatId PRIMARY KEY CLUSTERED (ChatId)
);

CREATE TABLE LumeDB.dbo.Event (
	EventId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	EventUid uniqueidentifier NOT NULL UNIQUE,
	Name nvarchar(200) NULL,
	MinAge tinyint NULL,
	MaxAge tinyint NULL,
	XCoordinate float NULL,
	YCoordinate float NULL,
	Description nvarchar(800) NULL,
	StartTime datetime2(7) NULL,
	EndTime datetime2(7) NULL,
	IsOpenForInvitations bit NOT NULL DEFAULT 0,
	IsOnline bit NOT NULL DEFAULT 0,
	EventStatusId bigint NULL,
	AdministratorId bigint NULL,
	ChatId bigint null,
	CityId bigint null,
	CONSTRAINT FK_Event_EventStatus FOREIGN KEY (EventStatusId) REFERENCES LumeDB.dbo.EventStatus (EventStatusId),
	CONSTRAINT FK_Event_Person FOREIGN KEY (AdministratorId) REFERENCES LumeDB.dbo.Person (PersonId),
	CONSTRAINT FK_Event_Chat FOREIGN KEY (ChatId) REFERENCES LumeDB.dbo.Chat (ChatId),
	CONSTRAINT FK_Event_City FOREIGN KEY (CityId) REFERENCES LumeDB.dbo.City (CityId),
	CONSTRAINT PK_EventId PRIMARY KEY CLUSTERED (EventId)
);

CREATE TABLE LumeDB.dbo.EventTypeToEvent (
	EventTypeId bigint,
  	EventId bigint,
  	CONSTRAINT PK_EventType_Event PRIMARY KEY (EventTypeId, EventId),
  	CONSTRAINT FK_EventType_EventTypeToEvent FOREIGN KEY (EventTypeId) REFERENCES LumeDB.dbo.EventType (EventTypeId),
  	CONSTRAINT FK_Event_EventTypeToEvent FOREIGN KEY (EventId) REFERENCES LumeDB.dbo.Event (EventId)
);

CREATE TABLE LumeDB.dbo.PersonSwipeHistory (
	PersonId bigint,
	EventId bigint,
	CONSTRAINT PK_PersonSwipeHistory_Person_Event PRIMARY KEY (PersonId, EventId),
  	CONSTRAINT FK_Person_PersonSwipeHistory FOREIGN KEY (PersonId) REFERENCES LumeDB.dbo.Person (PersonId),
  	CONSTRAINT FK_Event_PersonSwipeHistory FOREIGN KEY (EventId) REFERENCES LumeDB.dbo.Event (EventId)
);

CREATE TABLE LumeDB.dbo.EventSwipeHistory (
	EventId bigint,
	PersonId bigint,
	CONSTRAINT PK_EventSwipeHistory_Event_Person PRIMARY KEY (EventId, PersonId),
  	CONSTRAINT FK_Event_EventSwipeHistory FOREIGN KEY (EventId) REFERENCES LumeDB.dbo.Event (EventId),
  	CONSTRAINT FK_Person_EventSwipeHistory FOREIGN KEY (PersonId) REFERENCES LumeDB.dbo.Person (PersonId)
);

CREATE TABLE LumeDB.dbo.EventImageContent (
	EventImageContentId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	EventImageContentUid uniqueidentifier NOT NULL UNIQUE,
	IsPrimary bit NOT NULL DEFAULT 0,
	EventId bigint null,
	CONSTRAINT PK_EventImageContentId PRIMARY KEY CLUSTERED (EventImageContentId),
	CONSTRAINT FK_EventImageContent_Event FOREIGN KEY (EventId) REFERENCES LumeDB.dbo.Event (EventId),
);

CREATE TABLE LumeDB.dbo.ChatMessage (
	ChatMessageId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	ChatMessageUid uniqueidentifier NOT NULL UNIQUE,
	Content nvarchar(4000) NULL,
	MessageTime datetime2(7) NULL,
	ChatId bigint NULL,
	AuthorId bigint NULL,
	CONSTRAINT FK_ChatMessage_Chat FOREIGN KEY (ChatId) REFERENCES LumeDB.dbo.Chat (ChatId),
	CONSTRAINT FK_ChatMessage_Person FOREIGN KEY (AuthorId) REFERENCES LumeDB.dbo.Person (PersonId),
	CONSTRAINT PK_ChatMessageId PRIMARY KEY CLUSTERED (ChatMessageId)
);

CREATE TABLE LumeDB.dbo.ChatImageContent (
	ChatImageContentId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	ChatImageContentUid uniqueidentifier NOT NULL UNIQUE,
	ChatMessageId bigint NULL,
	CONSTRAINT PK_ChatImageContentId PRIMARY KEY CLUSTERED (ChatImageContentId),
	CONSTRAINT FK_ChatImageContent_ChatMessage FOREIGN KEY (ChatMessageId) REFERENCES LumeDB.dbo.ChatMessage (ChatMessageId)
);

CREATE TABLE LumeDB.dbo.PersonToEvent (
	PersonId bigint,
  	EventId bigint,
	ParticipantStatusId bigint NULL,
	LastReadChatMessageId bigint NULL,
  	CONSTRAINT PK_Person_Event PRIMARY KEY (PersonId, EventId),
  	CONSTRAINT FK_Person_PersonToEvent FOREIGN KEY (PersonId) REFERENCES LumeDB.dbo.Person (PersonId),
  	CONSTRAINT FK_Event_PersonToEvent FOREIGN KEY (EventId) REFERENCES LumeDB.dbo.Event (EventId),
  	CONSTRAINT FK_ParticipantStatus_PersonToEvent FOREIGN KEY (ParticipantStatusId) REFERENCES LumeDB.dbo.ParticipantStatus (ParticipantStatusId)
);

CREATE TABLE LumeDB.dbo.PersonToChat (
	FirstPersonId bigint,
	SecondPersonId bigint,
  	ChatId bigint,
	LastReadChatMessageId bigint NULL,
  	CONSTRAINT PK_Person_Chat PRIMARY KEY (FirstPersonId, SecondPersonId, ChatId),
  	CONSTRAINT FK_FirstPerson_PersonToChat FOREIGN KEY (FirstPersonId) REFERENCES LumeDB.dbo.Person (PersonId),
  	CONSTRAINT FK_SecondPerson_PersonToChat FOREIGN KEY (SecondPersonId) REFERENCES LumeDB.dbo.Person (PersonId),
  	CONSTRAINT FK_Chat_PersonToChat FOREIGN KEY (ChatId) REFERENCES LumeDB.dbo.Chat (ChatId)
);

CREATE TABLE LumeDB.dbo.PersonFriendList (
	PersonId bigint,
  	FriendId bigint,
	IsApproved bit NOT NULL DEFAULT 0,
  	CONSTRAINT PK_Person_Friend PRIMARY KEY (PersonId, FriendId),
  	CONSTRAINT FK_Person_PersonFriendList FOREIGN KEY (PersonId) REFERENCES LumeDB.dbo.Person (PersonId),
  	CONSTRAINT FK_Friend_PersonFriendList FOREIGN KEY (FriendId) REFERENCES LumeDB.dbo.Person (PersonId)
);

CREATE TABLE LumeDB.dbo.PersonToBadge (
	PersonId bigint,
  	BadgeId bigint,
	IsViewed bit NOT NULL DEFAULT 0,
  	CONSTRAINT PK_Person_Badge PRIMARY KEY (PersonId, BadgeId),
  	CONSTRAINT FK_Person_PersonToBadge FOREIGN KEY (PersonId) REFERENCES LumeDB.dbo.Person (PersonId),
  	CONSTRAINT FK_Badge_PersonToBadge FOREIGN KEY (BadgeId) REFERENCES LumeDB.dbo.Badge (BadgeId)
);

CREATE TABLE LumeDB.dbo.Feedback (
	FeedbackId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	PersonId bigint,
	FeedbackUid uniqueidentifier NOT NULL UNIQUE,
	Text nvarchar(MAX) NULL,
	OperatingSystem nvarchar(400) NULL,
	PhoneModel nvarchar(800) NULL,
	ApplicationVersion nvarchar(400) NULL,
	FeedbackTime datetime2(7) NULL,
	CONSTRAINT FK_Feedback_Person FOREIGN KEY (PersonId) REFERENCES LumeDB.dbo.Person (PersonId),
	CONSTRAINT PK_FeedbackId PRIMARY KEY CLUSTERED (FeedbackId)
);

CREATE TABLE LumeDB.dbo.FeedbackImageContent (
	FeedbackImageContentId bigint IDENTITY(1,1) NOT NULL UNIQUE,
	FeedbackImageContentUid uniqueidentifier NOT NULL UNIQUE,
	FeedbackId bigint NULL,
	CONSTRAINT PK_FeedbackImageContentId PRIMARY KEY CLUSTERED (FeedbackImageContentId),
	CONSTRAINT FK_FeedbackImageContent_Feedback FOREIGN KEY (FeedbackId) REFERENCES LumeDB.dbo.Feedback (FeedbackId)
);

INSERT INTO LumeDB.dbo.EventType (EventTypeName)  
VALUES ('Party'),('Culture'),('Sport'),('Nature'),('Communication'),('Game'),('Study'),('Food'),('Concert'),('Travel');

INSERT INTO LumeDB.dbo.EventStatus (EventStatusName)  
VALUES ('Preparing'),('InProgress'),('Ended'),('Canceled');  

INSERT INTO LumeDB.dbo.ParticipantStatus (ParticipantStatusName)
VALUES ('WaitingForApproveFromUser'),('WaitingForApproveFromEvent'),('Active'),('Rejected');  

INSERT INTO LumeDB.dbo.Badge (BadgeImageUid, Name)
VALUES ('9158DEB3-CCAE-4AB8-B1E1-F8E851CDDF40', 'ParticipatedInEvent'),
('BA315E67-BD8C-46E0-926D-CE178A2F74E1', 'CreatedEvent'),
('FF81A639-3E48-47CB-8793-7130C6307690', 'ParticipatedInParty'),
('144A65A7-5750-4569-8CCB-48B20E7BF8C7', 'ParticipatedInCulture'),
('394A7F8C-70A6-40F0-A449-B9D719D0A73C', 'ParticipatedInSport'),
('BC4FFDC6-A163-459D-97B8-2AF218617B73', 'ParticipatedInNature'),
('AA4BB776-BE42-4DEB-9442-91204DDEAB02', 'ParticipatedInCommunication'),
('62D80F76-F1D6-42C7-B88F-A5D1F7C7637C', 'ParticipatedInGame'),
('6C1AD5E2-6032-4ADB-9B6F-6D9EFD9B6831', 'ParticipatedInStudy'),
('60AE2D1F-B135-48E3-91F7-58D66A5E53DE', 'ParticipatedInFood'),
('9CA275AD-611B-4289-81D0-D4B8493BB71B', 'ParticipatedInConcert'),
('B51B6E85-56EB-4C59-A121-828F5077BF94', 'ParticipatedInTravel');  

INSERT INTO LumeDB.dbo.City (CityName)
VALUES 
(N'Абакан'),
(N'Азов'),
(N'Александров'),
(N'Алексин'),
(N'Альметьевск'),
(N'Анапа'),
(N'Ангарск'),
(N'Анжеро-Судженск'),
(N'Апатиты'),
(N'Арзамас'),
(N'Армавир'),
(N'Арсеньев'),
(N'Артем'),
(N'Архангельск'),
(N'Асбест'),
(N'Астрахань'),
(N'Ачинск'),
(N'Балаково'),
(N'Балахна'),
(N'Балашиха'),
(N'Балашов'),
(N'Барнаул'),
(N'Батайск'),
(N'Белгород'),
(N'Белебей'),
(N'Белово'),
(N'Белогорск (Амурская область)'),
(N'Белорецк'),
(N'Белореченск'),
(N'Бердск'),
(N'Березники'),
(N'Березовский (Свердловская область)'),
(N'Бийск'),
(N'Биробиджан'),
(N'Благовещенск (Амурская область)'),
(N'Бор'),
(N'Борисоглебск'),
(N'Боровичи'),
(N'Братск'),
(N'Брянск'),
(N'Бугульма'),
(N'Буденновск'),
(N'Бузулук'),
(N'Буйнакск'),
(N'Великие Луки'),
(N'Великий Новгород'),
(N'Верхняя Пышма'),
(N'Видное'),
(N'Владивосток'),
(N'Владикавказ'),
(N'Владимир'),
(N'Волгоград'),
(N'Волгодонск'),
(N'Волжск'),
(N'Волжский'),
(N'Вологда'),
(N'Вольск'),
(N'Воркута'),
(N'Воронеж'),
(N'Воскресенск'),
(N'Воткинск'),
(N'Всеволожск'),
(N'Выборг'),
(N'Выкса'),
(N'Вязьма'),
(N'Гатчина'),
(N'Геленджик'),
(N'Георгиевск'),
(N'Глазов'),
(N'Горно-Алтайск'),
(N'Грозный'),
(N'Губкин'),
(N'Гудермес'),
(N'Гуково'),
(N'Гусь-Хрустальный'),
(N'Дербент'),
(N'Дзержинск'),
(N'Димитровград'),
(N'Дмитров'),
(N'Долгопрудный'),
(N'Домодедово'),
(N'Донской'),
(N'Дубна'),
(N'Евпатория'),
(N'Егорьевск'),
(N'Ейск'),
(N'Екатеринбург'),
(N'Елабуга'),
(N'Елец'),
(N'Ессентуки'),
(N'Железногорск (Красноярский край)'),
(N'Железногорск (Курская область)'),
(N'Жигулевск'),
(N'Жуковский'),
(N'Заречный'),
(N'Зеленогорск'),
(N'Зеленодольск'),
(N'Златоуст'),
(N'Иваново'),
(N'Ивантеевка'),
(N'Ижевск'),
(N'Избербаш'),
(N'Иркутск'),
(N'Искитим'),
(N'Ишим'),
(N'Ишимбай'),
(N'Йошкар-Ола'),
(N'Казань'),
(N'Калининград'),
(N'Калуга'),
(N'Каменск-Уральский'),
(N'Каменск-Шахтинский'),
(N'Камышин'),
(N'Канск'),
(N'Каспийск'),
(N'Кемерово'),
(N'Керчь'),
(N'Кинешма'),
(N'Кириши'),
(N'Киров (Кировская область)'),
(N'Кирово-Чепецк'),
(N'Киселевск'),
(N'Кисловодск'),
(N'Клин'),
(N'Клинцы'),
(N'Ковров'),
(N'Когалым'),
(N'Коломна'),
(N'Комсомольск-на-Амуре'),
(N'Копейск'),
(N'Королев'),
(N'Кострома'),
(N'Котлас'),
(N'Красногорск'),
(N'Краснодар'),
(N'Краснокаменск'),
(N'Краснокамск'),
(N'Краснотурьинск'),
(N'Красноярск'),
(N'Кропоткин'),
(N'Крымск'),
(N'Кстово'),
(N'Кузнецк'),
(N'Кумертау'),
(N'Кунгур'),
(N'Курган'),
(N'Курск'),
(N'Кызыл'),
(N'Лабинск'),
(N'Лениногорск'),
(N'Ленинск-Кузнецкий'),
(N'Лесосибирск'),
(N'Липецк'),
(N'Лиски'),
(N'Лобня'),
(N'Лысьва'),
(N'Лыткарино'),
(N'Люберцы'),
(N'Магадан'),
(N'Магнитогорск'),
(N'Майкоп'),
(N'Махачкала'),
(N'Междуреченск'),
(N'Мелеуз'),
(N'Миасс'),
(N'Минеральные Воды'),
(N'Минусинск'),
(N'Михайловка'),
(N'Михайловск (Ставропольский край)'),
(N'Мичуринск'),
(N'Москва'),
(N'Мурманск'),
(N'Муром'),
(N'Мытищи'),
(N'Набережные Челны'),
(N'Назарово'),
(N'Назрань'),
(N'Нальчик'),
(N'Наро-Фоминск'),
(N'Находка'),
(N'Невинномысск'),
(N'Нерюнгри'),
(N'Нефтекамск'),
(N'Нефтеюганск'),
(N'Нижневартовск'),
(N'Нижнекамск'),
(N'Нижний Новгород'),
(N'Нижний Тагил'),
(N'Новоалтайск'),
(N'Новокузнецк'),
(N'Новокуйбышевск'),
(N'Новомосковск'),
(N'Новороссийск'),
(N'Новосибирск'),
(N'Новотроицк'),
(N'Новоуральск'),
(N'Новочебоксарск'),
(N'Новочеркасск'),
(N'Новошахтинск'),
(N'Новый Уренгой'),
(N'Ногинск'),
(N'Норильск'),
(N'Ноябрьск'),
(N'Нягань'),
(N'Обнинск'),
(N'Одинцово'),
(N'Озерск (Челябинская область)'),
(N'Октябрьский'),
(N'Омск'),
(N'Орел'),
(N'Оренбург'),
(N'Орехово-Зуево'),
(N'Орск'),
(N'Павлово'),
(N'Павловский Посад'),
(N'Пенза'),
(N'Первоуральск'),
(N'Пермь'),
(N'Петрозаводск'),
(N'Петропавловск-Камчатский'),
(N'Подольск'),
(N'Полевской'),
(N'Прокопьевск'),
(N'Прохладный'),
(N'Псков'),
(N'Пушкино'),
(N'Пятигорск'),
(N'Раменское'),
(N'Ревда'),
(N'Реутов'),
(N'Ржев'),
(N'Рославль'),
(N'Россошь'),
(N'Ростов-на-Дону'),
(N'Рубцовск'),
(N'Рыбинск'),
(N'Рязань'),
(N'Салават'),
(N'Сальск'),
(N'Самара'),
(N'Санкт-Петербург'),
(N'Саранск'),
(N'Сарапул'),
(N'Саратов'),
(N'Саров'),
(N'Свободный'),
(N'Севастополь'),
(N'Северодвинск'),
(N'Северск'),
(N'Сергиев Посад'),
(N'Серов'),
(N'Серпухов'),
(N'Сертолово'),
(N'Сибай'),
(N'Симферополь'),
(N'Славянск-на-Кубани'),
(N'Смоленск'),
(N'Соликамск'),
(N'Солнечногорск'),
(N'Сосновый Бор'),
(N'Сочи'),
(N'Ставрополь'),
(N'Старый Оскол'),
(N'Стерлитамак'),
(N'Ступино'),
(N'Сургут'),
(N'Сызрань'),
(N'Сыктывкар'),
(N'Таганрог'),
(N'Тамбов'),
(N'Тверь'),
(N'Тимашевск'),
(N'Тихвин'),
(N'Тихорецк'),
(N'Тобольск'),
(N'Тольятти'),
(N'Томск'),
(N'Троицк'),
(N'Туапсе'),
(N'Туймазы'),
(N'Тула'),
(N'Тюмень'),
(N'Узловая'),
(N'Улан-Удэ'),
(N'Ульяновск'),
(N'Урус-Мартан'),
(N'Усолье-Сибирское'),
(N'Уссурийск'),
(N'Усть-Илимск'),
(N'Уфа'),
(N'Ухта'),
(N'Феодосия'),
(N'Фрязино'),
(N'Хабаровск'),
(N'Ханты-Мансийск'),
(N'Хасавюрт'),
(N'Химки'),
(N'Чайковский'),
(N'Чапаевск'),
(N'Чебоксары'),
(N'Челябинск'),
(N'Черемхово'),
(N'Череповец'),
(N'Черкесск'),
(N'Черногорск'),
(N'Чехов'),
(N'Чистополь'),
(N'Чита'),
(N'Шадринск'),
(N'Шали'),
(N'Шахты'),
(N'Шуя'),
(N'Щекино'),
(N'Щелково'),
(N'Электросталь'),
(N'Элиста'),
(N'Энгельс'),
(N'Южно-Сахалинск'),
(N'Юрга'),
(N'Якутск'),
(N'Ялта'),
(N'Ярославль');