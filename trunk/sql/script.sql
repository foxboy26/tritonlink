USE [tritonlink]
GO
ALTER TABLE [dbo].[undergraduate] DROP CONSTRAINT [FK__undergrad__stude__4CA06362]
GO
ALTER TABLE [dbo].[teach] DROP CONSTRAINT [FK__teach__section_i__5EBF139D]
GO
ALTER TABLE [dbo].[teach] DROP CONSTRAINT [FK__teach__faculty_i__5DCAEF64]
GO
ALTER TABLE [dbo].[student_section] DROP CONSTRAINT [FK__student_s__stude__5BE2A6F2]
GO
ALTER TABLE [dbo].[student_section] DROP CONSTRAINT [FK__student_s__secti__5CD6CB2B]
GO
ALTER TABLE [dbo].[student_program] DROP CONSTRAINT [FK__student_p__degre__17F790F9]
GO
ALTER TABLE [dbo].[student_faculties_project] DROP CONSTRAINT [FK__student_f__stude__6754599E]
GO
ALTER TABLE [dbo].[student_faculties_project] DROP CONSTRAINT [FK__student_f__proje__693CA210]
GO
ALTER TABLE [dbo].[student_faculties_project] DROP CONSTRAINT [FK__student_f__facul__6A30C649]
GO
ALTER TABLE [dbo].[schedule] DROP CONSTRAINT [FK__schedule__facult__60A75C0F]
GO
ALTER TABLE [dbo].[schedule] DROP CONSTRAINT [FK__schedule__course__619B8048]
GO
ALTER TABLE [dbo].[program] DROP CONSTRAINT [FK__program__departm__02FC7413]
GO
ALTER TABLE [dbo].[program] DROP CONSTRAINT [FK__program__degree__02084FDA]
GO
ALTER TABLE [dbo].[probation] DROP CONSTRAINT [FK__probation__stude__4F7CD00D]
GO
ALTER TABLE [dbo].[prerequisite] DROP CONSTRAINT [FK__prerequis__pre_c__5629CD9C]
GO
ALTER TABLE [dbo].[prerequisite] DROP CONSTRAINT [FK__prerequis__cours__5535A963]
GO
ALTER TABLE [dbo].[plans] DROP CONSTRAINT [FK__plans__departmen__7E37BEF6]
GO
ALTER TABLE [dbo].[plans] DROP CONSTRAINT [FK__plans__degree__7D439ABD]
GO
ALTER TABLE [dbo].[plans] DROP CONSTRAINT [FK__plans__course_id__656C112C]
GO
ALTER TABLE [dbo].[meeting] DROP CONSTRAINT [FK__meeting__section__4E88ABD4]
GO
ALTER TABLE [dbo].[graduate] DROP CONSTRAINT [FK__graduate__studen__4BAC3F29]
GO
ALTER TABLE [dbo].[graduate] DROP CONSTRAINT [FK__graduate__studen__3A81B327]
GO
ALTER TABLE [dbo].[graduate] DROP CONSTRAINT [FK__graduate__studen__38996AB5]
GO
ALTER TABLE [dbo].[graduate] DROP CONSTRAINT [FK__graduate__depart__0B91BA14]
GO
ALTER TABLE [dbo].[graduate] DROP CONSTRAINT [FK__graduate__degree__03F0984C]
GO
ALTER TABLE [dbo].[faculty] DROP CONSTRAINT [FK__faculty__departm__1332DBDC]
GO
ALTER TABLE [dbo].[committee] DROP CONSTRAINT [FK__committee__stude__628FA481]
GO
ALTER TABLE [dbo].[committee] DROP CONSTRAINT [FK__committee__facul__6383C8BA]
GO
ALTER TABLE [dbo].[class_section] DROP CONSTRAINT [FK__class_sec__secti__5812160E]
GO
ALTER TABLE [dbo].[class_section] DROP CONSTRAINT [FK__class_sec__cours__571DF1D5]
GO
ALTER TABLE [dbo].[class] DROP CONSTRAINT [FK__class__course_id__4D94879B]
GO
/****** Object:  Table [dbo].[undergraduate]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[undergraduate]
GO
/****** Object:  Table [dbo].[teach]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[teach]
GO
/****** Object:  Table [dbo].[student_section]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[student_section]
GO
/****** Object:  Table [dbo].[student_program]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[student_program]
GO
/****** Object:  Table [dbo].[student_faculties_project]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[student_faculties_project]
GO
/****** Object:  Table [dbo].[student]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[student]
GO
/****** Object:  Table [dbo].[section]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[section]
GO
/****** Object:  Table [dbo].[schedule]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[schedule]
GO
/****** Object:  Table [dbo].[project]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[project]
GO
/****** Object:  Table [dbo].[program]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[program]
GO
/****** Object:  Table [dbo].[probation]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[probation]
GO
/****** Object:  Table [dbo].[prerequisite]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[prerequisite]
GO
/****** Object:  Table [dbo].[plans]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[plans]
GO
/****** Object:  Table [dbo].[meeting]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[meeting]
GO
/****** Object:  Table [dbo].[graduate]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[graduate]
GO
/****** Object:  Table [dbo].[faculty]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[faculty]
GO
/****** Object:  Table [dbo].[department]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[department]
GO
/****** Object:  Table [dbo].[degree]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[degree]
GO
/****** Object:  Table [dbo].[course]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[course]
GO
/****** Object:  Table [dbo].[committee]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[committee]
GO
/****** Object:  Table [dbo].[class_section]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[class_section]
GO
/****** Object:  Table [dbo].[class]    Script Date: 2013/2/10 22:06:12 ******/
DROP TABLE [dbo].[class]
GO
/****** Object:  Table [dbo].[class]    Script Date: 2013/2/10 22:06:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[class](
	[course_id] [varchar](7) NOT NULL,
	[quarter] [varchar](6) NOT NULL,
	[year] [time](4) NOT NULL,
	[title] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC,
	[quarter] ASC,
	[year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[class_section]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[class_section](
	[course_id] [varchar](7) NOT NULL,
	[section_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC,
	[section_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[committee]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[committee](
	[student_id] [int] NOT NULL,
	[faculty_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[faculty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[course]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[course](
	[course_id] [varchar](7) NOT NULL,
	[department] [varchar](100) NOT NULL,
	[is_consent] [bit] NOT NULL,
	[unit_range] [varchar](3) NOT NULL,
	[grade_type] [varchar](8) NOT NULL,
	[labwork] [bit] NOT NULL,
 CONSTRAINT [PK__course__8F1EF7AE6F7BFCA7] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[degree]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[degree](
	[degree_type] [varchar](6) NOT NULL,
 CONSTRAINT [PK_degree] PRIMARY KEY CLUSTERED 
(
	[degree_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[department]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[department](
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_department] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[faculty]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[faculty](
	[faculty_id] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[title] [varchar](20) NOT NULL,
	[department] [varchar](50) NOT NULL,
 CONSTRAINT [PK__faculty__7B00413CA4E5FBA5] PRIMARY KEY CLUSTERED 
(
	[faculty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[graduate]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[graduate](
	[student_id] [int] NOT NULL,
	[degree] [varchar](6) NOT NULL,
	[department] [varchar](50) NOT NULL,
	[state] [varchar](12) NOT NULL,
 CONSTRAINT [PK__graduate__2A33069A2D79E37B] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[meeting]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[meeting](
	[section_id] [int] NOT NULL,
	[type] [varchar](2) NOT NULL,
	[location] [varchar](45) NOT NULL,
	[start_time] [varchar](5) NOT NULL,
	[end_time] [varchar](5) NOT NULL,
	[days] [varchar](45) NOT NULL,
	[mandatory] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[section_id] ASC,
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[plans]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[plans](
	[degree] [varchar](6) NOT NULL,
	[course_id] [varchar](7) NOT NULL,
	[category] [varchar](50) NOT NULL,
	[department] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[degree] ASC,
	[course_id] ASC,
	[department] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[prerequisite]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[prerequisite](
	[course_id] [varchar](7) NOT NULL,
	[pre_course_id] [varchar](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC,
	[pre_course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[probation]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[probation](
	[student_id] [int] NOT NULL,
	[start_time] [date] NOT NULL,
	[end_time] [date] NOT NULL,
	[reason] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[start_time] ASC,
	[end_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[program]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[program](
	[degree] [varchar](6) NOT NULL,
	[category] [varchar](50) NOT NULL,
	[units] [tinyint] NOT NULL,
	[min-gpa] [float] NOT NULL,
	[department] [varchar](50) NOT NULL,
 CONSTRAINT [PK__program__CF1A0B48A9650185] PRIMARY KEY CLUSTERED 
(
	[department] ASC,
	[degree] ASC,
	[category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[project]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[project](
	[project_id] [int] NOT NULL,
	[name] [varchar](100) NOT NULL,
	[start_time] [date] NOT NULL,
	[end_time] [date] NOT NULL,
	[department] [varchar](50) NOT NULL,
	[funding] [money] NOT NULL,
	[category] [varchar](50) NOT NULL,
	[proposal] [text] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[project_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[schedule]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[schedule](
	[faculty_id] [int] NOT NULL,
	[course_id] [varchar](7) NOT NULL,
	[quarter] [varchar](6) NOT NULL,
	[year] [time](4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[faculty_id] ASC,
	[course_id] ASC,
	[quarter] ASC,
	[year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[section]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[section](
	[section_id] [int] NOT NULL,
	[enrolled_num] [int] NOT NULL,
	[waitlist_num] [int] NOT NULL,
	[limit_num] [int] NOT NULL,
 CONSTRAINT [PK_section] PRIMARY KEY CLUSTERED 
(
	[section_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[student]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[student](
	[student_id] [int] NOT NULL,
	[firstname] [varchar](50) NOT NULL,
	[middlename] [varchar](50) NOT NULL,
	[lastname] [varchar](50) NOT NULL,
	[ssn] [int] NOT NULL,
	[residency] [varchar](50) NOT NULL,
	[is_enrolled] [bit] NOT NULL,
	[hold_degree] [varchar](max) NOT NULL,
	[attendances] [varchar](max) NOT NULL,
 CONSTRAINT [PK_student] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[student_faculties_project]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_faculties_project](
	[student_id] [int] NOT NULL,
	[faculty_id] [int] NOT NULL,
	[project_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[faculty_id] ASC,
	[project_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[student_program]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[student_program](
	[student_id] [int] NOT NULL,
	[degree] [varchar](6) NOT NULL,
 CONSTRAINT [PK__student___1894476CC9599D9F] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[degree] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[student_section]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[student_section](
	[student_id] [int] NOT NULL,
	[section_id] [int] NOT NULL,
	[state] [varchar](8) NOT NULL,
	[grade_type] [varchar](8) NOT NULL,
	[unit] [tinyint] NOT NULL,
	[grade] [varchar](2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[section_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[teach]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teach](
	[faculty_id] [int] NOT NULL,
	[section_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[faculty_id] ASC,
	[section_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[undergraduate]    Script Date: 2013/2/10 22:06:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[undergraduate](
	[student_id] [int] NOT NULL,
	[college] [varchar](20) NOT NULL,
	[major] [varchar](50) NOT NULL,
	[minor] [varchar](50) NOT NULL,
	[type] [varchar](6) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[class]  WITH CHECK ADD  CONSTRAINT [FK__class__course_id__4D94879B] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
ALTER TABLE [dbo].[class] CHECK CONSTRAINT [FK__class__course_id__4D94879B]
GO
ALTER TABLE [dbo].[class_section]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
ALTER TABLE [dbo].[class_section]  WITH CHECK ADD FOREIGN KEY([section_id])
REFERENCES [dbo].[section] ([section_id])
GO
ALTER TABLE [dbo].[committee]  WITH CHECK ADD  CONSTRAINT [FK__committee__facul__6383C8BA] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[faculty] ([faculty_id])
GO
ALTER TABLE [dbo].[committee] CHECK CONSTRAINT [FK__committee__facul__6383C8BA]
GO
ALTER TABLE [dbo].[committee]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
ALTER TABLE [dbo].[faculty]  WITH CHECK ADD FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__degree__03F0984C] FOREIGN KEY([degree])
REFERENCES [dbo].[degree] ([degree_type])
GO
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__degree__03F0984C]
GO
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__studen__38996AB5] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__studen__38996AB5]
GO
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__studen__3A81B327] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__studen__3A81B327]
GO
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__studen__4BAC3F29] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__studen__4BAC3F29]
GO
ALTER TABLE [dbo].[meeting]  WITH CHECK ADD FOREIGN KEY([section_id])
REFERENCES [dbo].[section] ([section_id])
GO
ALTER TABLE [dbo].[plans]  WITH CHECK ADD  CONSTRAINT [FK__plans__course_id__656C112C] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
ALTER TABLE [dbo].[plans] CHECK CONSTRAINT [FK__plans__course_id__656C112C]
GO
ALTER TABLE [dbo].[plans]  WITH CHECK ADD FOREIGN KEY([degree])
REFERENCES [dbo].[degree] ([degree_type])
GO
ALTER TABLE [dbo].[plans]  WITH CHECK ADD FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
ALTER TABLE [dbo].[prerequisite]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
ALTER TABLE [dbo].[prerequisite]  WITH CHECK ADD FOREIGN KEY([pre_course_id])
REFERENCES [dbo].[course] ([course_id])
GO
ALTER TABLE [dbo].[probation]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
ALTER TABLE [dbo].[program]  WITH CHECK ADD FOREIGN KEY([degree])
REFERENCES [dbo].[degree] ([degree_type])
GO
ALTER TABLE [dbo].[program]  WITH CHECK ADD FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK__schedule__facult__60A75C0F] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[faculty] ([faculty_id])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK__schedule__facult__60A75C0F]
GO
ALTER TABLE [dbo].[student_faculties_project]  WITH CHECK ADD  CONSTRAINT [FK__student_f__facul__6A30C649] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[faculty] ([faculty_id])
GO
ALTER TABLE [dbo].[student_faculties_project] CHECK CONSTRAINT [FK__student_f__facul__6A30C649]
GO
ALTER TABLE [dbo].[student_faculties_project]  WITH CHECK ADD FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([project_id])
GO
ALTER TABLE [dbo].[student_faculties_project]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
ALTER TABLE [dbo].[student_program]  WITH CHECK ADD FOREIGN KEY([degree])
REFERENCES [dbo].[degree] ([degree_type])
GO
ALTER TABLE [dbo].[student_section]  WITH CHECK ADD FOREIGN KEY([section_id])
REFERENCES [dbo].[section] ([section_id])
GO
ALTER TABLE [dbo].[student_section]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
ALTER TABLE [dbo].[teach]  WITH CHECK ADD  CONSTRAINT [FK__teach__faculty_i__5DCAEF64] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[faculty] ([faculty_id])
GO
ALTER TABLE [dbo].[teach] CHECK CONSTRAINT [FK__teach__faculty_i__5DCAEF64]
GO
ALTER TABLE [dbo].[teach]  WITH CHECK ADD FOREIGN KEY([section_id])
REFERENCES [dbo].[section] ([section_id])
GO
ALTER TABLE [dbo].[undergraduate]  WITH CHECK ADD FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
