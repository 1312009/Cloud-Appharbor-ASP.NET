Create database FOOD
GO
USE [FOOD]
GO
/****** Object:  UserDefinedFunction [dbo].[fChuyenCoDauThanhKhongDau]    Script Date: 12/14/2016 9:57:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fChuyenCoDauThanhKhongDau](@inputVar NVARCHAR(MAX) )
RETURNS NVARCHAR(MAX)
AS
BEGIN    
    IF (@inputVar IS NULL OR @inputVar = '')  RETURN ''
   
    DECLARE @RT NVARCHAR(MAX)
    DECLARE @SIGN_CHARS NCHAR(256)
    DECLARE @UNSIGN_CHARS NCHAR (256)
 
    SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' + NCHAR(272) + NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'
 
    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
   
    SET @COUNTER = 1
    WHILE (@COUNTER <= LEN(@inputVar))
    BEGIN  
        SET @COUNTER1 = 1
        WHILE (@COUNTER1 <= LEN(@SIGN_CHARS) + 1)
        BEGIN
            IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@inputVar,@COUNTER ,1))
            BEGIN          
                IF @COUNTER = 1
                    SET @inputVar = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)-1)      
                ELSE
                    SET @inputVar = SUBSTRING(@inputVar, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@inputVar, @COUNTER+1,LEN(@inputVar)- @COUNTER)
                BREAK
            END
            SET @COUNTER1 = @COUNTER1 +1
        END
        SET @COUNTER = @COUNTER +1
    END
    -- SET @inputVar = replace(@inputVar,' ','-')
    RETURN @inputVar
END
--Load theo loại món ăn

GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 12/14/2016 9:57:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](100) NULL,
	[EMAIL] [nvarchar](100) NULL,
	[PASSWORDHASH] [nvarchar](200) NULL,
	[SALT] [nvarchar](200) NULL,
	[IMAGEACC] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ACCOUNT_ROLE]    Script Date: 12/14/2016 9:57:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACCOUNT_ROLE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDROLE] [int] NULL,
	[IDUSER] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[COMMENT]    Script Date: 12/14/2016 9:57:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[COMMENT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDUSER] [int] NOT NULL,
	[IDFOOD] [int] NOT NULL,
	[CONTENT] [nvarchar](200) NULL,
	[DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EXTERNALACCOUNT]    Script Date: 12/14/2016 9:57:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EXTERNALACCOUNT](
	[IDUSER] [int] NOT NULL,
	[LOGINPROVIDER] [char](100) NULL,
	[PROVIDERKEY] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_EXTERNALACCOUNT] PRIMARY KEY CLUSTERED 
(
	[IDUSER] ASC,
	[PROVIDERKEY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FOOD]    Script Date: 12/14/2016 9:57:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FOOD](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](100) NULL,
	[DECRIPTION] [nvarchar](500) NULL,
	[IDTYPE] [int] NULL,
	[NUMBER] [int] NULL,
	[IMGFOOD] [nvarchar](200) NULL,
	[PRICE] [float] NULL,
	[ISSALE] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FOODORDER]    Script Date: 12/14/2016 9:57:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FOODORDER](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDUSER] [int] NOT NULL,
	[IDFOOD] [int] NOT NULL,
	[STATUSODER] [int] NULL,
	[NUMBER] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LIST_ROLE]    Script Date: 12/14/2016 9:57:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LIST_ROLE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TYPEFOOD]    Script Date: 12/14/2016 9:57:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TYPEFOOD](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](20) NULL,
	[TIMESTART] [time](7) NULL,
	[TIMEEND] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ACCOUNT] ON 

INSERT [dbo].[ACCOUNT] ([ID], [NAME], [EMAIL], [PASSWORDHASH], [SALT], [IMAGEACC]) VALUES (1, N'1312009', N'tuananhpro2981995@gmail.com', N'ZZ6iOG+txr2wwb9OxifN1dzFmMagZtyq9EVq6sLIllU=', N'PxUd6mKxeLFAVYNCW0GZ8g==', N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480963523/default-user-icon-profile_ex6q2v.png')
SET IDENTITY_INSERT [dbo].[ACCOUNT] OFF
SET IDENTITY_INSERT [dbo].[ACCOUNT_ROLE] ON 

INSERT [dbo].[ACCOUNT_ROLE] ([ID], [IDROLE], [IDUSER]) VALUES (1, 2, 1)
SET IDENTITY_INSERT [dbo].[ACCOUNT_ROLE] OFF
SET IDENTITY_INSERT [dbo].[FOOD] ON 

INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (1, N'Hàu vọng nguyệt', N'Là món ăn vừa ngon, vừa bổ,
 với cách trình bày lạ mắt, hơn nữa hàu có hàm lượng chất béo thấp, chất kẽm cao, ăn vào
 sẽ đẹp da, giữ dáng.', 2, 0, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480927282/5484_nj6ph4.jpg', 30000, 0)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (2, N'Gà nướng bưởi xốt giấm', N'Gà nướng bưởi xốt giấm 
là món ăn ngon, giàu vitamin. Ngoài ra bưởi có tác dụng bổ dưỡng cơ thể, phòng và chữa một số bệnh như cao huyết áp, tiểu đường.', 2, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480927281/5472_s96ntq.jpg', 50000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (3, N'Bún giò heo nấu giấm', N'Là món ăn lạ miệng và rất được ưa 
thích ở miền Tây Nam bộ, giúp cân bằng lại sau những ngày bồi bổ đầy đủ dưỡng chất, đảm bảo ăn không ngán ', 1, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480927604/5017_tdodok.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (4, N'Bún ốc', N'Bún ốc là một món ngon cân bằng dưỡng chất,
 hấp dẫn, thích hợp nhất là vừa ăn Tết xong, mọi người cứ no ngang, hậu quả của việc ăn quá nhiều thịt.', 1, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480928085/5016_xh1dzj.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (5, N'Lẩu chua thịt bò', N'Lẩu chua thịt bò là món ăn ngon, 
rất hấp dẫn, trong nồi lẩu sẽ có sắc vàng như màu hoa mai, sắc xanh như màu lộc biếc, thích hợp với không khí ngày Tết.', 3, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480928390/5004_hhltem.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (6, N'Súp nghêu rau củ', N'Món ăn này có xuất xứ từ món súp của các 
nước châu Âu, châu Mỹ nhưng nguyên liệu và gia vị lại rất phù hợp với ẩm thực Việt Nam, có thể dùng làm thay đổi khẩu vị bữa ăn gia đình.', 1, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480928504/5411_ebtssq.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (7, N'Súp sắc màu', N'Một món ăn có nhiều sắc màu sẽ cũng cấp nhiều 
và đa dạng các chất dinh dưỡng, vitamin và khoáng chất, rất tốt cho sức khỏe.', 1, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480928614/5456_hedfq2.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (8, N'Cá chiên hoa cúc', N'Đây là món ăn ngày Tết thật đơn
 giản và ít tốn thời gian chế biến, mang ý nghĩa trường thọ và giàu dinh dưỡng.', 3, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480928712/5448_yy2rj9.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (9, N'Vịt kho nước tương', N'Vịt kho nước tương là món ăn 
vừa ngon vừa có tác dụng cân bằng hàn-nhiệt, mang lại lợi ích cho sức khỏe.', 3, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480928847/5394_rw90hh.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (10, N'Chim cút nhồi cốm hấp', N'Là 1 món ăn ngon bổ dưỡng 
cho sức khỏe với các nguyên liệu', 3, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480928954/5464_f3punz.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (11, N'Nhộng rang lá chanh bắc', N'Mang hương vị đậm đà khi 
được chế biến với hương lá chanh nồng nàn, tạo sự kích thích về khứu giác và vị giác, món ăn này có nét rất riêng biệt, phù hợp với thời 
tiết se lạnh cuối năm.', 3, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480929091/5096_rg4xb7.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (12, N'Giò heo hầm bông atiso', N'Với tiêu chí món ăn ngon, 
bổ, dễ thực hiện của chương trình, món giò heo hầm bông atiso là một sự lựa chọn hoàn hảo cho gia đình vào những dịp cuối tuần, giúp 
nâng cao sức khỏe cho cả người lớn lẫn trẻ em.', 3, 0, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480929186/4964_goevvp.jpg', 30000, 0)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (13, N'Vịt xốt chua ngọt', N'Với vịt quay, vịt luộc hay vịt xào sả ớt... 
là những món quá quen thuộc với chúng ta rồi. Hôm nay chúng tôi giới thiệu một món ngon từ thịt vịt hoàn toàn mới là "vịt xốt chua ngọt" 
các bạn đã thử chưa?', 2, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480929298/4770_gbtnc8.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (14, N'Cơm chiên xốt tương', N'Món ăn từ Nhật nhưng 
lại rất gần gũi với khẩu vị người Việt, mang hương vị độc đáo, thơm ngon', 2, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480929470/5426_syhv7k.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (15, N'Pha Chế Magarita Dưa Mix Bơ Lạ Miệng', N'Lại có thêm 
món đồ uống đặc biệt thơm ngon nữa rồi này.', 2, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480929584/4728_ma7muc.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (16, N'Cật heo xào bí ngòi', N'Đây là món ăn ngon, với cật heo bổ
 dưỡng cho thận có tác dụng bồi bổ cơ thể', 2, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480929878/5479_hfucxh.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (17, N'Giò thủ xào', N'Món giò thủ là món ăn truyền thống rất 
phổ biến của Việt Nam trong những ngày lễ Tết.', 2, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480929988/5390_oa17ux.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (18, N'BÚN BÒ HUẾ', N'Thịt bò xào lá lốt cũng là một món ngon 
không kém món Bò nướng lá lốt. Miếng bò chín mềm vẫn giữ được vị ngọt, lá lốt thơm mùi đặc trưng. Ngoài ra còn có vị beo béo ngọt ngọt 
của kẹo đậu phộng. Món ăn có nguyên liệu đơn giản nhưng rất hấp dẫn đúng không các bạn!', 2, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480930059/5359_tq3lvr.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (19, N'Tôm xào sả cay', N'Tôm xào sả cay là một món ăn ngon,
 sử dụng nguyên liệu sả có tác dụng chữa được nhiều bệnh như đầy bụng, cảm cúm.', 2, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480930139/5400_guk008.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (20, N'Lươn xào lăn', N'Lươn xào lăn là một món ăn rất 
bổ và trị được nhiều bệnh ngon và được rất nhiều người yêu thích.', 3, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480930231/5403_siwlaq.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (21, N'Tôm rang ruốc tôm', N'Tôm rang ruốc tôm là món ngon, 
hấp dẫn phù hợp trong thời tiết se lạnh của những ngày đầu đông này. Món ăn được chế biến khá đơn giản với những nguyên liệu thường 
dùng hàng ngày nhưng thành phẩm lại làm cho bạn hương vị thơm ngon, lạ miệng đến khó quên.', 3, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480930337/4779_aetkir.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (22, N'Bánh tét lá cẩm', N'Bánh tét lá cẩm là món bánh truyền thống 
của người Việt mình nhân dịp Tết Nguyên Đán, ngoài ra còn là đặc sản của nhiều vùng Nam Bộ nữa.', 1, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480931111/5375_onrrvl.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (23, N'Bánh há cảo hoa hồng', N'Là món bánh quen thuộc 
nhưng được trình bày lạ, đẹp mắt, mang hương vị thơm ngon, hấp dẫn.', 1, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480931242/5431_iv5zhp.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (24, N'Gỏi trứng chiên', N'G?i tr?ng chiên có ngu?n g?c 
t? Thái Lan có v? chua d?u ng?t và hoi hoi cay, màu s?c b?t m?t thích h?p d? làm m?i b?a an cu?i tu?n.', 1, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480931342/5459_jvhb6v.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (25, N'Gỏi gà rau răm', N'Món gỏi có vị rất đậm đà 
vừa ăn, chỉ hơi chua nhẹ dễ chịu, có sự cộng hưởng thú vị giữa gà và rau răm.', 3, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480931428/5407_jkjokx.jpg', 30000, 1)
INSERT [dbo].[FOOD] ([ID], [NAME], [DECRIPTION], [IDTYPE], [NUMBER], [IMGFOOD], [PRICE], [ISSALE]) VALUES (26, N'Nộm hoa chuối hải sản', N'Đây là món ăn dân dã rất được ưa thích, là một trong năm loại gỏi của món gỏi ngũ sắc, khá lạ miệng và dễ thực hiện.', 2, 1, N'http://res.cloudinary.com/dqabuxewl/image/upload/v1480931534/5406_xw0gkv.jpg', 30000, 1)
SET IDENTITY_INSERT [dbo].[FOOD] OFF
SET IDENTITY_INSERT [dbo].[FOODORDER] ON 

INSERT [dbo].[FOODORDER] ([ID], [IDUSER], [IDFOOD], [STATUSODER], [NUMBER]) VALUES (1, 1, 1, NULL, 1)
INSERT [dbo].[FOODORDER] ([ID], [IDUSER], [IDFOOD], [STATUSODER], [NUMBER]) VALUES (2, 1, 12, NULL, 1)
SET IDENTITY_INSERT [dbo].[FOODORDER] OFF
SET IDENTITY_INSERT [dbo].[LIST_ROLE] ON 

INSERT [dbo].[LIST_ROLE] ([ID], [NAME]) VALUES (1, N'ADMIN')
INSERT [dbo].[LIST_ROLE] ([ID], [NAME]) VALUES (2, N'CUSTOMER')
SET IDENTITY_INSERT [dbo].[LIST_ROLE] OFF
SET IDENTITY_INSERT [dbo].[TYPEFOOD] ON 

INSERT [dbo].[TYPEFOOD] ([ID], [NAME], [TIMESTART], [TIMEEND]) VALUES (1, N'ĐIỂM TÂM', CAST(N'06:00:00' AS Time), CAST(N'09:00:00' AS Time))
INSERT [dbo].[TYPEFOOD] ([ID], [NAME], [TIMESTART], [TIMEEND]) VALUES (2, N'CƠM TRƯA', CAST(N'10:00:00' AS Time), CAST(N'13:00:00' AS Time))
INSERT [dbo].[TYPEFOOD] ([ID], [NAME], [TIMESTART], [TIMEEND]) VALUES (3, N'CƠM TỐI', CAST(N'16:00:00' AS Time), CAST(N'21:00:00' AS Time))
SET IDENTITY_INSERT [dbo].[TYPEFOOD] OFF

GO
/****** Object:  StoredProcedure [dbo].[usp_LoaiMonAn]    Script Date: 12/14/2016 9:57:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Load danh sách top các món ăn được đặt hàng nhiều nhất trong ngày
CREATE PROCEDURE [dbo].[usp_LoaiMonAn] @TYPE INT
AS
BEGIN
	SELECT F.ID,F.NAME,F.DECRIPTION,F.ISSALE,F.IDTYPE,F.IMGFOOD,F.PRICE,F.NUMBER
	FROM FOOD F JOIN TYPEFOOD T ON F.IDTYPE=T.ID 
	WHERE T.ID=@TYPE
END

GO
/****** Object:  StoredProcedure [dbo].[usp_ThemMonAn]    Script Date: 12/14/2016 9:57:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--THÊM MÓN ĂN
CREATE PROCEDURE [dbo].[usp_ThemMonAn] @name nvarchar(100), @decription nvarchar(500),@issale int,
@idtype int,@img nvarchar(200),@price float,@NUMBER int
as
begin
INSERT INTO FOOD(NAME,DECRIPTION,ISSALE,IDTYPE,IMGFOOD,PRICE,NUMBER) VALUES(@name,@decription,@issale,@idtype,@img,@price,@NUMBER)
end

GO
/****** Object:  StoredProcedure [dbo].[usp_TimKiemMonAn]    Script Date: 12/14/2016 9:57:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--tìm kiếm món ăn
create proc [dbo].[usp_TimKiemMonAn] @TT nvarchar(50),@row int,@count int
as
begin
	SET FMTONLY OFF
	if(@count is null and @row is null )
	begin
		set @row=0
		select @count = count(*)
		from(select distinct ID from FOOD where  dbo.fChuyenCoDauThanhKhongDau(NAME) like N'%'+@TT+'%') a
	end
	CREATE TABLE #TMP (MAMON INT, SOLUONGDATHANG INT)
	INSERT INTO #TMP
	SELECT F.ID AS MAMON, "SOLUONGDATHANG" = 
				CASE
					WHEN SOLUONGDATHANG IS NULL THEN 0
					ELSE SOLUONGDATHANG
				END
	FROM FOOD F LEFT JOIN (SELECT IDFOOD  AS MAMON, COUNT(*) AS SOLUONGDATHANG
								FROM FOODORDER
								GROUP BY IDFOOD) TH ON F.ID = TH.MAMON
	ORDER BY SOLUONGDATHANG DESC
	
	SELECT F.ID,F.NAME,F.DECRIPTION,F.ISSALE,F.IDTYPE,F.IMGFOOD,F.PRICE,F.NUMBER,
		#TMP.SOLUONGDATHANG AS SOLUONGDATHANG
	from FOOD F, #TMP,
				(select ID,row_number() over(order by count(*) desc) as row
				from FOOD where  dbo.fChuyenCoDauThanhKhongDau(NAME) like N'%'+@TT+'%'
				group by ID) m1
	where m1.row>@row and m1.row <=@count+@row and F.ID= m1.ID
	AND #TMP.MAMON = F.ID
	order by #TMP.SOLUONGDATHANG desc
	--DROP TABLE #TMP
end

GO
/****** Object:  StoredProcedure [dbo].[usp_TopMonAnThich]    Script Date: 12/14/2016 9:57:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Load danh sách top các món ăn được đặt hàng nhiều nhất trong ngày
CREATE PROCEDURE [dbo].[usp_TopMonAnThich]
AS
BEGIN
	SELECT F.ID,F.NAME,F.DECRIPTION,F.ISSALE,F.IDTYPE,F.IMGFOOD,F.PRICE,F.NUMBER,COUNT(*) AS COUNT
	FROM FOOD F JOIN FOODORDER L ON F.ID=L.IDFOOD
	GROUP BY F.ID,F.NAME,F.DECRIPTION,F.ISSALE,F.IDTYPE,F.IMGFOOD,F.PRICE,F.NUMBER
	ORDER BY COUNT(*) DESC
END

GO
/****** Object:  StoredProcedure [dbo].[usp_XoaMonAn]    Script Date: 12/14/2016 9:57:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--xóa món ăn
CREATE PROCEDURE [dbo].[usp_XoaMonAn] @id int
as
begin
DELETE FROM FOOD WHERE FOOD.ID=@id
end

GO
EXEC usp_ThemMonAn 'ga','none',1,1,'null',30000,10