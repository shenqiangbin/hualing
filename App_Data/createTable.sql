CREATE TABLE GlobalConfig
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    keyName		VARCHAR(100)	NOT NULL UNIQUE,
    valuePc		NTEXT,
    valueMobi		NTEXT
)

CREATE TABLE Admin
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    username		VARCHAR(20)	NOT NULL UNIQUE,
    pwd			VARCHAR(32),
    realname		NVARCHAR(50),
    nickname		NVARCHAR(50),
    accessRule		NTEXT,
    commonLinks		NTEXT,
    notes		NTEXT,
    inbuilt		BIT		DEFAULT(0),
    curLoginIp		VARCHAR(15),
    curLoginTime	DATETIME,
    lastLoginIp		VARCHAR(15),
    lastLoginTime	DATETIME,
    enabled		BIT		DEFAULT(1),
    creator		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE Area
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(50)	NOT NULL,
    fatherId		INT		DEFAULT(0),
    xpath		NTEXT,
    iLevel		INT		DEFAULT(1),
    iSort		INT,
    isOpen		BIT		DEFAULT(1),
    hasChild		BIT		DEFAULT(0),
    code		VARCHAR(50),
    isHot		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(1)
)

CREATE TABLE SystemMenu
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(50)	NOT NULL,
    fatherId		INT		DEFAULT(0),
    xpath		NTEXT,
    iLevel		INT		DEFAULT(1),
    iSort		INT,
    isOpen		BIT		DEFAULT(1),
    hasChild		BIT		DEFAULT(0),
    url			NTEXT,
    addPageUrl		NTEXT,
    ruleCode		NTEXT,
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE SiteMenu
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    groupId		INT		NOT NULL,
    title		NVARCHAR(50)	NOT NULL,
    fatherId		INT		DEFAULT(0),
    xpath		NTEXT,
    iLevel		INT		DEFAULT(1),
    maxLevel		INT		DEFAULT(0),
    iSort		INT,
    isOpen		BIT		DEFAULT(1),
    hasChild		BIT		DEFAULT(0),
    url			NTEXT,
    target		NTEXT,
    relation		VARCHAR(50),
    relationId		INT		DEFAULT(0),
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE OnePage
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(200)	NOT NULL,
    mode		INT		DEFAULT(0),
    pageTitle		NTEXT,
    keywords		NTEXT,
    descn		NTEXT,
    rawUrl		NTEXT,
    urlAlias		VARCHAR(50),
    url			NTEXT,
    content		NTEXT,
    initContent		NTEXT,
    fatherId		INT		DEFAULT(0),
    iSort		INT,
    inbuilt		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE PageSection
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(200)	NOT NULL,
    content		NTEXT,
    initContent		NTEXT,
    createTime		DATETIME
)

CREATE TABLE Category
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    groupId		INT		DEFAULT(0),
    title		NVARCHAR(50)	NOT NULL,
    pageTitle		NTEXT,
    keywords		NTEXT,
    descn		NTEXT,
    urlRoute		NTEXT,
    rawUrl		NTEXT,
    subUrlRoute		NTEXT,
    subRawUrl		NTEXT,
    urlAlias		VARCHAR(50),
    url			NTEXT,
    fatherId		INT		DEFAULT(0),
    xpath		NTEXT,
    iLevel		INT		DEFAULT(1),
    maxLevel		INT		DEFAULT(0),
    iSort		INT,
    isOpen		BIT		DEFAULT(1),
    hasChild		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE Article
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(200)	NOT NULL,
    categoryId		INT,
    areaId		INT,
    color		VARCHAR(20),
    keywords		NTEXT,
    descn		NTEXT,
    pic			NTEXT,
    files               NTEXT,  --
    author		NTEXT,
    source		NTEXT,
    content		NTEXT,
    iSort		INT		DEFAULT(1),
    pv			INT		DEFAULT(0),
    isHead		BIT		DEFAULT(0),
    isTop		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(1),
    pubdate		DATETIME,
    searchIndex		INT		DEFAULT(0),
    creator		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE Product
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		VARCHAR(200)	NOT NULL,
    titlename		VARCHAR(200),
    categoryId		INT,
    keywords		NTEXT,
    descn		NTEXT,
    pic			NTEXT,
    pictures		NTEXT,
    price1		MONEY,
    price2		MONEY,
    point		INT,      --
    stock		INT		DEFAULT(0),
    summary    NTEXT,    --概述
    application		NTEXT,    --参数
    feature		NTEXT,   --功能  
    content		NTEXT,     --概述 
    iSort		INT		DEFAULT(0),
    pv			INT		DEFAULT(0),
    isTop		BIT		DEFAULT(0),   --
    enabled		BIT		DEFAULT(0),
    pubdate		DATETIME,
    creator		INT		DEFAULT(0),
    ishot               BIT		DEFAULT(0),   --热
    createTime		DATETIME
)

CREATE TABLE MemberCard
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    cardNo		VARCHAR(100)	NOT NULL UNIQUE,
    pwd			VARCHAR(20)	NOT NULL,
    memberId		INT		DEFAULT(0),
    username		VARCHAR(100),
    cityId		INT		DEFAULT(0),
    realname		NVARCHAR(100),
    identityCard	VARCHAR(30),
    plateNumber		NVARCHAR(30),
    vehicleBrand	NTEXT,
    loadPeople		NTEXT,
    mobi		VARCHAR(20),
    email		VARCHAR(100),
    address		NTEXT,
    sold		BIT		DEFAULT(0),
    buyer		INT		DEFAULT(0),
    enabled		BIT		DEFAULT(0),
    activeTime		DATETIME,
    createTime		DATETIME
)

CREATE TABLE Song
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		VARCHAR(200)	NOT NULL,   --姓名
    sex		INT		DEFAULT(0),  --性别
    birtime		VARCHAR(200),  --出生日期
    addr		VARCHAR(200),  --籍贯
    salary			NTEXT,     --薪资要求
    tel		NTEXT,     --电话
    email		NTEXT,    --email
    address		NTEXT,  --通讯地址
    edu		NTEXT,    --教育经历
    works		NTEXT,  --工作经历
    evaluation		NTEXT,  --自我评价
    pv			INT		DEFAULT(0),
    iSort		INT		DEFAULT(0),
    isTop		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE Course
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    way		VARCHAR(200)	NOT NULL,   --方式
    issue		VARCHAR(200),  --期号
    opentime		DATETIME,  --开课时间
    city			NTEXT,     --城市
    tel		             NTEXT,     --  咨询QQ
    pv			INT		DEFAULT(0), --开班情况 0 已满 1-紧张  2-咨询
    iSort		INT		DEFAULT(0),
    isTop		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE Project
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		VARCHAR(200)	NOT NULL,
    categoryId		INT,
    areaId		INT,
    keywords		NTEXT,
    descn		NTEXT,
    pic			NTEXT,
    pictures		NTEXT,
    topPic		NTEXT,
    topic		INT		DEFAULT(0),
    iLevel		INT		DEFAULT(0),
    eventDate		DATETIME,
    eventTheme		NTEXT,
    ticket		NTEXT,
    single		NTEXT,
    people		NTEXT,
    together		NTEXT,
    tel			NTEXT,
    address		NTEXT,
    iSort		INT		DEFAULT(0),
    pv			INT		DEFAULT(0),
    isTop		BIT		DEFAULT(0),
    isHot		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(0),
    pubdate		DATETIME,
    searchIndex		INT		DEFAULT(0),
    creator		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE ProjectContent
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    proId		INT		NOT NULL,
    optionId		INT		NOT NULL,
    content		NTEXT
)

CREATE TABLE Orders
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    trackId		VARCHAR(50)	NOT NULL UNIQUE,
    memberId		INT		NOT NULL,
    realname		NVARCHAR(100),
    tel			VARCHAR(100),
    provinceId		INT		DEFAULT(0),
    cityId		INT		DEFAULT(0),
    districtId		INT		DEFAULT(0),
    address		NTEXT,
    zipcode		VARCHAR(6),
    payWay		INT,
    sendTime		INT,
    userNotes		NTEXT,
    sysNotes		NTEXT,
    price		MONEY,
    status		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE OrderDetail
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    orderId		INT		NOT NULL,
    proId		INT		NOT NULL,
    price		MONEY,
    num			INT,
    notes		NTEXT
)

CREATE TABLE Comment
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    relation		VARCHAR(50),
    relationId		INT		DEFAULT(0),
    nickname		NVARCHAR(50),
    content		NTEXT,
    point		INT		DEFAULT(0),
    agree		INT		DEFAULT(0),
    oppose		INT		DEFAULT(0),
    ipv4		NTEXT,
    enabled		BIT		DEFAULT(1),
    creator		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE AdGroup
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(200)	NOT NULL,
    width		INT		DEFAULT(0),
    height		INT		DEFAULT(0),
    display		INT		DEFAULT(1),
    inbuilt		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE AdFixed
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(200)	NOT NULL,
    groupId		INT		NOT NULL,
    thumb		NTEXT,
    pic			NTEXT,
    width		INT		DEFAULT(0),
    height		INT		DEFAULT(0),
    url			NTEXT,
    notes		NTEXT,
    iSort		INT		DEFAULT(0),
    enabled		BIT		DEFAULT(1),
    creator		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE AdFloating
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(200)	NOT NULL,
    pic			NTEXT,
    url			NTEXT,
    notes		NTEXT,
    location		INT,
    marginTop		INT		DEFAULT(0),
    marginBottom	INT		DEFAULT(0),
    marginLeft		INT		DEFAULT(0),
    marginRight		INT		DEFAULT(0),
    enabled		BIT		DEFAULT(1),
    creator		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE Member
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    username		VARCHAR(100)	NOT NULL UNIQUE,  --意向课程
    pwd			VARCHAR(32)	NOT NULL,    --‘’‘
    realname		NVARCHAR(100),   --姓名
    nickname		NVARCHAR(100),    --单位
    sex			NVARCHAR(10),   --性别
    birthday		DATETIME,   
    mobi		VARCHAR(100),    --手机
    tel			VARCHAR(100),    --职务
    email		VARCHAR(100),   --email
    pic			NTEXT,    --年龄
    provinceId		INT		DEFAULT(0),   --地区
    cityId		INT		DEFAULT(0),   
    districtId		INT		DEFAULT(0),    
    address		NTEXT,          --备注
    zipcode		VARCHAR(6),
    qq			NTEXT,
    agentArea		INT		DEFAULT(0),
    agentCreateTime	DATETIME,
    curLoginIp		VARCHAR(15),
    curLoginTime	DATETIME,
    lastLoginIp		VARCHAR(15),
    lastLoginTime	DATETIME,
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE MemberRelation
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    memberId		INT		NOT NULL,
    friendId		INT		NOT NULL,
    enabled		BIT		DEFAULT(1),
    lastEditTime	DATETIME
)

CREATE TABLE Message
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(200),
    content		NTEXT,
    sender		INT		DEFAULT(0),
    receiver		INT		DEFAULT(0),
    isRead		BIT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE MsgTemp
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(200)	NOT NULL,
    mode		INT		DEFAULT(0),
    subject		NVARCHAR(200),
    content		NTEXT,
    notes		NTEXT,
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE Options
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(100)	NOT NULL,
    fatherId		INT		DEFAULT(0),
    xpath		NTEXT,
    iLevel		INT		DEFAULT(1),
    iSort		INT,
    isOpen		BIT		DEFAULT(1),
    hasChild		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE Filespec
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(200)	NOT NULL,
    code		VARCHAR(20)	NOT NULL UNIQUE,
    fileFormat		NTEXT,
    fileExt		NTEXT,
    filesize		INT		DEFAULT(0),
    savePath		NTEXT,
    nameFormat		NTEXT,
    wmSwitch		INT		DEFAULT(0),
    wmAlign		INT		DEFAULT(9),
    wmTransparent	INT		DEFAULT(100),
    wmText		NTEXT,
    wmTextSize		INT		DEFAULT(30),
    wmTextColor		NTEXT,
    wmTextFont		NTEXT,
    wmImage		NTEXT,
    thumbnail		NTEXT
)

CREATE TABLE MediaLib
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    fileType		INT,
    filePath		NTEXT,
    fileSize		INT		DEFAULT(0),
    notes		NTEXT,
    adminId		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE SearchIndex
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NTEXT,
    pic			NTEXT,
    url			NTEXT,
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE ForumMenu
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    title		NVARCHAR(50)	NOT NULL,
    pageTitle		NTEXT,
    keywords		NTEXT,
    descn		NTEXT,
    pic			NTEXT,
    urlAlias		VARCHAR(50),
    url			NTEXT,
    fatherId		INT		DEFAULT(0),
    xpath		NTEXT,
    iLevel		INT		DEFAULT(1),
    iSort		INT,
    isOpen		BIT		DEFAULT(1),
    hasChild		BIT		DEFAULT(0),
    moderators		NTEXT,
    lastPostId		INT		DEFAULT(0),
    todayThread		INT		DEFAULT(0),
    todayPost		INT		DEFAULT(0),
    totalThread		INT		DEFAULT(0),
    totalPost		INT		DEFAULT(0),
    isReco		BIT		DEFAULT(0),
    enabled		BIT		DEFAULT(1),
    createTime		DATETIME
)

CREATE TABLE ForumThread
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    menuId		INT		NOT NULL,
    title		NVARCHAR(200)	NOT NULL,
    content		NTEXT,
    readCount		INT		DEFAULT(0),
    replyCount		INT		DEFAULT(0),
    isTop		INT		DEFAULT(0), -- 0(正常) 1(版置顶) 2(区置顶) 3(总置顶)
    isBest		BIT		DEFAULT(0),
    isReco		BIT		DEFAULT(0),
    isLock		BIT		DEFAULT(0),
    lastReplyUser	INT		DEFAULT(0),
    lastReplyTime	DATETIME,
    lastEditor		INT		DEFAULT(0),
    lastEditTime	DATETIME,
    creator		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE ForumPostReply
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    threadId		INT		NOT NULL,
    content		NTEXT,
    quotePostId		INT		DEFAULT(0),
    lastEditor		INT		DEFAULT(0),
    lastEditTime	DATETIME,
    enabled		BIT		DEFAULT(1),
    creator		INT		DEFAULT(0),
    createTime		DATETIME
)

CREATE TABLE ForumUserState
(
    pkid		INT		PRIMARY KEY IDENTITY(1,1),
    userId		INT		NOT NULL,
    threadCount		INT		DEFAULT(0),
    postCount		INT		DEFAULT(0),
    bestPostCount	INT		DEFAULT(0),
    forumStar		BIT		DEFAULT(0),
    forumStarSort	INT		DEFAULT(1),
    forumPoint		INT		DEFAULT(0),
    forumMoney		INT		DEFAULT(0)
)




--初始化数据
INSERT Admin(username, pwd, realname, accessRule, notes, inbuilt, enabled, createTime)
SELECT 'admin', 'bfa46baae5ff8944929c37bde35cbaa4', '超级管理员', 'all', '系统内置，拥有全部操作权限', 1, 1, GETDATE()  --密码 123456

