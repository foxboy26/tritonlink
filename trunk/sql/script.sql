USE [master]
GO
/****** Object:  Database [tritonlink]    Script Date: 2013/2/25 23:42:20 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'tritonlink')
BEGIN
CREATE DATABASE [tritonlink]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tritonlink', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\tritonlink.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'tritonlink_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\tritonlink_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
END

GO
ALTER DATABASE [tritonlink] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [tritonlink].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [tritonlink] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [tritonlink] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [tritonlink] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [tritonlink] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [tritonlink] SET ARITHABORT OFF 
GO
ALTER DATABASE [tritonlink] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [tritonlink] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [tritonlink] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [tritonlink] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [tritonlink] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [tritonlink] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [tritonlink] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [tritonlink] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [tritonlink] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [tritonlink] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [tritonlink] SET  DISABLE_BROKER 
GO
ALTER DATABASE [tritonlink] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [tritonlink] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [tritonlink] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [tritonlink] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [tritonlink] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [tritonlink] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [tritonlink] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [tritonlink] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [tritonlink] SET  MULTI_USER 
GO
ALTER DATABASE [tritonlink] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [tritonlink] SET DB_CHAINING OFF 
GO
ALTER DATABASE [tritonlink] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [tritonlink] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [tritonlink]
GO
/****** Object:  Table [dbo].[class]    Script Date: 2013/2/25 23:42:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[class]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[class](
	[course_id] [varchar](7) NOT NULL,
	[quarter] [varchar](15) NOT NULL,
	[title] [varchar](100) NOT NULL,
 CONSTRAINT [PK_class] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC,
	[quarter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[class_section]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[class_section]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[class_section](
	[course_id] [varchar](7) NOT NULL,
	[section_id] [varchar](10) NOT NULL,
	[quarter] [varchar](15) NOT NULL,
 CONSTRAINT [PK__class_se__309AD1D8304FBF16] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC,
	[section_id] ASC,
	[quarter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[committee]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[committee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[committee](
	[student_id] [int] NOT NULL,
	[faculty_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[faculty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[course]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[course]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[course](
	[course_id] [varchar](7) NOT NULL,
	[department] [varchar](50) NOT NULL,
	[is_consent] [bit] NOT NULL,
	[unit_range] [varchar](3) NOT NULL,
	[grade_type] [varchar](8) NOT NULL,
	[labwork] [bit] NOT NULL,
 CONSTRAINT [PK__course__8F1EF7AE6F7BFCA7] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[degree]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[degree]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[degree](
	[degree_type] [varchar](10) NOT NULL,
 CONSTRAINT [PK_degree_1] PRIMARY KEY CLUSTERED 
(
	[degree_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[department]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[department]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[department](
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_department] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[faculty]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[faculty]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[graduate]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[graduate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[graduate](
	[student_id] [int] NOT NULL,
	[department] [varchar](50) NOT NULL,
	[degree_type] [varchar](10) NOT NULL,
	[state] [varchar](20) NULL,
 CONSTRAINT [PK__graduate__2A33069A2D79E37B] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[meeting]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[meeting]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[meeting](
	[section_id] [varchar](10) NOT NULL,
	[type] [varchar](2) NOT NULL,
	[location] [varchar](45) NOT NULL,
	[start_time] [varchar](5) NOT NULL,
	[end_time] [varchar](5) NOT NULL,
	[days] [varchar](45) NOT NULL,
	[mandatory] [bit] NOT NULL,
 CONSTRAINT [PK__meeting__767DE24E7A106D4A] PRIMARY KEY CLUSTERED 
(
	[section_id] ASC,
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[plans]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[plans]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[plans](
	[program_name] [varchar](50) NOT NULL,
	[course_id] [varchar](7) NOT NULL,
	[category] [varchar](50) NOT NULL,
 CONSTRAINT [PK_plans] PRIMARY KEY CLUSTERED 
(
	[program_name] ASC,
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[prerequisite]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[prerequisite]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[prerequisite](
	[course_id] [varchar](7) NOT NULL,
	[pre_course_id] [varchar](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[course_id] ASC,
	[pre_course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[probation]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[probation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[probation](
	[student_id] [int] NOT NULL,
	[start_time] [varchar](10) NOT NULL,
	[end_time] [varchar](10) NOT NULL,
	[reason] [varchar](300) NOT NULL,
 CONSTRAINT [PK__probatio__30D0B329285E5D9C] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[start_time] ASC,
	[end_time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[program]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[program]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[program](
	[name] [varchar](50) NOT NULL,
	[degree_type] [varchar](10) NOT NULL,
	[department] [varchar](50) NOT NULL,
 CONSTRAINT [PK_degree] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[program_requirement]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[program_requirement]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[program_requirement](
	[program_name] [varchar](50) NOT NULL,
	[category] [varchar](50) NOT NULL,
	[units] [tinyint] NOT NULL,
	[min_gpa] [float] NOT NULL,
 CONSTRAINT [PK_program_requirement] PRIMARY KEY CLUSTERED 
(
	[program_name] ASC,
	[category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[project]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[project]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[schedule]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[schedule]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[schedule](
	[faculty_id] [int] NOT NULL,
	[course_id] [varchar](7) NOT NULL,
	[quarter] [varchar](10) NOT NULL,
 CONSTRAINT [PK_schedule] PRIMARY KEY CLUSTERED 
(
	[faculty_id] ASC,
	[course_id] ASC,
	[quarter] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[section]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[section]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[section](
	[section_id] [varchar](10) NOT NULL,
	[enrolled_num] [int] NOT NULL,
	[waitlist_num] [int] NOT NULL,
	[limit_num] [int] NOT NULL,
 CONSTRAINT [PK_section] PRIMARY KEY CLUSTERED 
(
	[section_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[student]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[student]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[student](
	[student_id] [int] NOT NULL,
	[firstname] [varchar](50) NOT NULL,
	[middlename] [varchar](50) NULL,
	[lastname] [varchar](50) NOT NULL,
	[ssn] [int] NULL,
	[residency] [varchar](50) NOT NULL,
	[is_enrolled] [bit] NOT NULL,
	[hold_degrees] [varchar](max) NULL,
	[attendances] [varchar](max) NOT NULL,
 CONSTRAINT [PK_student] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[student_faculties_project]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[student_faculties_project]') AND type in (N'U'))
BEGIN
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
END
GO
/****** Object:  Table [dbo].[student_program]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[student_program]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[student_program](
	[student_id] [int] NOT NULL,
	[program_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__student___1894476CC9599D9F] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[program_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[student_section]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[student_section]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[student_section](
	[student_id] [int] NOT NULL,
	[section_id] [varchar](10) NOT NULL,
	[state] [varchar](8) NOT NULL,
	[unit] [tinyint] NOT NULL,
	[grade] [varchar](2) NULL,
	[grade_type] [varchar](8) NULL,
 CONSTRAINT [PK__student___95B720ECE3A68067] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[section_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[teach]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[teach]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[teach](
	[faculty_id] [int] NOT NULL,
	[section_id] [varchar](10) NOT NULL,
 CONSTRAINT [PK__teach__C484674AD8911EB6] PRIMARY KEY CLUSTERED 
(
	[faculty_id] ASC,
	[section_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[undergraduate]    Script Date: 2013/2/25 23:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[undergraduate]') AND type in (N'U'))
BEGIN
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
END
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'0987653', N'Fall 1900', N'vzsafd')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'0987653', N'Winter 2013', N'Network')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'1234567', N'Winter 2013', N'DB System Applications')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'2345689', N'Fall 1906', N'sfdaafs')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'2345689', N'Fall 2013', N'AI')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'2345689', N'Winter 2013', N'AI')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'4567890', N'Fall 2011', N'Software Engineering')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'5679876', N'Spring 2012', N'Public Policy')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'cse007', N'Fall 1905', N'databased1')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE132b', N'Fall 1912', N'134')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE202', N'Fall 1911', N'123')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'2345689', N'2', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'2345689', N'21333', N'Fall 1906')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'cse007', N'94949', N'Fall 1905')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'cse007', N'9999', N'Fall 1905')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE132b', N'3337', N'Fall 1912')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE132b', N'869', N'Fall 1912')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE202', N'122239', N'Fall 1911')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE202', N'133', N'Fall 1911')
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53012343, 123)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53012343, 666)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53012343, 131313)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53025734, 123)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53025734, 123124)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53025734, 131313)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53032364, 123)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53032364, 123124)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53032364, 131313)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'0987653', N'Computer Science and Engineering', 0, N'4~8', N'grade', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'1234567', N'Computer Science and Engineering', 1, N'4', N'grade', 1)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'2345689', N'Humanity', 0, N'0~4', N'grade', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'4567890', N'Material Science', 0, N'2', N'S/U Only', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'5679876', N'IRPS', 1, N'4', N'grade', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE001', N'Computer Science and Engineering', 1, N'4', N'Grade', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'cse007', N'Computer Science and Engineering', 1, N'1~4', N'Grade', 1)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE132b', N'Computer Science and Engineering', 0, N'4', N'Grade', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE202', N'Computer Science and Engineering', 1, N'4', N'Grade', 0)
INSERT [dbo].[degree] ([degree_type]) VALUES (N'BA')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'BE')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'BSC')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'MS')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'MSE')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'Ph.D')
INSERT [dbo].[department] ([name]) VALUES (N'Computer Science and Engineering')
INSERT [dbo].[department] ([name]) VALUES (N'Electrical and Computer Engineering')
INSERT [dbo].[department] ([name]) VALUES (N'History')
INSERT [dbo].[department] ([name]) VALUES (N'Humanity')
INSERT [dbo].[department] ([name]) VALUES (N'IRPS')
INSERT [dbo].[department] ([name]) VALUES (N'Material Science')
INSERT [dbo].[department] ([name]) VALUES (N'Mathematics')
INSERT [dbo].[department] ([name]) VALUES (N'Mechanical Engineering')
INSERT [dbo].[department] ([name]) VALUES (N'Physics')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (123, N'Charls Elkan', N'Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (666, N'XXX', N'Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (999, N'ABC', N'Associate Professor', N'IRPS')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (123124, N'yannis', N'Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (131313, N'gauss', N'Professor', N'Mathematics')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (555555, N'abcde', N'Associate Professor', N'Material Science')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (828492, N'Alineee', N'Associate Professor', N'History')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (1231554, N'xxxxxx', N'Lecturer', N'IRPS')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (1314565, N'newton', N'Assistant Professor', N'Physics')
INSERT [dbo].[graduate] ([student_id], [department], [degree_type], [state]) VALUES (487333, N'Computer Science and Engineering', N'Ph.D', N'PhD candidates')
INSERT [dbo].[graduate] ([student_id], [department], [degree_type], [state]) VALUES (1111111, N'Computer Science and Engineering', N'MS', N'PhD candidates')
INSERT [dbo].[graduate] ([student_id], [department], [degree_type], [state]) VALUES (53025734, N'Computer Science and Engineering', N'MS', NULL)
INSERT [dbo].[graduate] ([student_id], [department], [degree_type], [state]) VALUES (53032364, N'Computer Science and Engineering', N'MS', NULL)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'122239', N'LE', N'5', N'3', N'2', N'5', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'123', N'LE', N'sadsv', N'123', N'321', N'sd', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'123', N'RW', N'gasdsgdgsd', N'13', N'555', N'13/12/3', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'133', N'LE', N'2355', N'2', N'3', N'5', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'2', N'LE', N'3', N'1', N'2', N'5', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'21333', N'LE', N'33', N'2', N'3', N'3', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'3337', N'LE', N'as', N'3', N'2', N'df', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'766775', N'RW', N'asdf', N'132', N'123', N'12/12/12', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'766776', N'RW', N'dsafsfd', N'1233', N'1234', N'1/1/1', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'869', N'LE', N'12', N'2', N'3', N'44', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'94949', N'LE', N'dd', N'12', N'3', N'wd', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'9999', N'LE', N'dfff', N'23', N'44', N'dfsfd', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'99998', N'DI', N'HSS', N'1234', N'4422', N'WF', 0)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'99999', N'LE', N'WHL', N'123', N'111', N'MW', 0)
INSERT [dbo].[prerequisite] ([course_id], [pre_course_id]) VALUES (N'CSE001', N'0987653')
INSERT [dbo].[prerequisite] ([course_id], [pre_course_id]) VALUES (N'CSE001', N'2345689')
INSERT [dbo].[prerequisite] ([course_id], [pre_course_id]) VALUES (N'cse007', N'CSE132b')
INSERT [dbo].[prerequisite] ([course_id], [pre_course_id]) VALUES (N'cse007', N'CSE202')
INSERT [dbo].[prerequisite] ([course_id], [pre_course_id]) VALUES (N'CSE202', N'1234567')
INSERT [dbo].[prerequisite] ([course_id], [pre_course_id]) VALUES (N'CSE202', N'CSE132b')
INSERT [dbo].[probation] ([student_id], [start_time], [end_time], [reason]) VALUES (487333, N'Spring1900', N'Spring1900', N'jjljkj')
INSERT [dbo].[probation] ([student_id], [start_time], [end_time], [reason]) VALUES (53025734, N'Fall1900', N'Fall1900', N'adfsd')
INSERT [dbo].[probation] ([student_id], [start_time], [end_time], [reason]) VALUES (53025734, N'Fall1905', N'Fall1900', N'dfsfadfdfa')
INSERT [dbo].[probation] ([student_id], [start_time], [end_time], [reason]) VALUES (53025734, N'Fall1946', N'Fall1909', N'dddddddddddddd')
INSERT [dbo].[probation] ([student_id], [start_time], [end_time], [reason]) VALUES (53032364, N'Fall1900', N'Spring1900', N'afsdfaf')
INSERT [dbo].[program] ([name], [degree_type], [department]) VALUES (N'BA IN HM', N'BA', N'Humanity')
INSERT [dbo].[program] ([name], [degree_type], [department]) VALUES (N'BS IN CSE', N'BSC', N'Computer Science and Engineering')
INSERT [dbo].[program] ([name], [degree_type], [department]) VALUES (N'MS IN CSE', N'MS', N'Computer Science and Engineering')
INSERT [dbo].[program] ([name], [degree_type], [department]) VALUES (N'PHD IN CSE', N'Ph.D', N'Computer Science and Engineering')
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'BS IN CSE', N'all', 233, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'BS IN CSE', N'upper', 123, 1)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'PHD IN CSE', N'all', 250, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'PHD IN CSE', N'sdfasafs', 3, 4)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'122239', 0, 0, 3)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'123', 0, 0, 21)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'133', 0, 0, 2)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'2', 0, 0, 33)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'21333', 0, 0, 22)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'3337', 0, 0, 33)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'345678', 20, 20, 20)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'766775', 30, 15, 30)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'766776', 18, 0, 30)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'766777', 53, 0, 60)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'869', 0, 0, 3)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'876547', 33, 17, 40)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'94949', 0, 0, 33)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'9999', 0, 0, 10)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'99998', 0, 0, 123)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'99999', 0, 0, 100)
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (9292, N'df', N'dd', N'ddd', 1234, N'California resident', 1, N'aaaa BE;', N'Spring2005-Spring2008;')
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (90902, N'lala', N'hehe', N'ohoh', 9494, N'California resident', 1, N'kdkdkdkdkd BA; BA;', N'Spring1900-Spring1900;Spring1900-Spring1900;')
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (487333, N'afdf', N'', N'sdafd', 313, N'Non-CA US student', 1, N'ssss BA;', N'Spring1909-Spring1912;')
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (1111111, N'www', N'eee', N'aaa', 12345, N'California resident', 1, N'asdfg BA;', N'Spring1905-Spring1915;')
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (53012343, N'xiaoming', N'', N'huang', NULL, N'Foreign student', 1, N'abc Bachelor;', N'Spring1233-Spring1234;')
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (53025734, N'Zhiheng', N'', N'Li', NULL, N'Non-CA US student', 1, N'SJTU Bachelor;', N'Fall2012-Spring2013;')
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (53032364, N'Xixi', N'', N'Xiao', NULL, N'Non-CA US student', 1, N'Tsinghua University Bachelor;', N'Fall2012-Spring2013;')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (1111111, N'2', N'enrolled', 2, NULL, N'grade')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53012343, N'2', N'enrolled', 3, N'A+', N'grade')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'2', N'enrolled', 4, N'A+', N'grade')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123, N'122239')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123, N'123')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123, N'133')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123, N'2')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123, N'21333')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123, N'3337')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123, N'869')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123, N'94949')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123, N'99999')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123124, N'9999')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (123124, N'99998')
INSERT [dbo].[undergraduate] ([student_id], [college], [major], [minor], [type]) VALUES (9292, N'Revelle', N'History', N'Computer Science and Engineering', N'normal')
INSERT [dbo].[undergraduate] ([student_id], [college], [major], [minor], [type]) VALUES (90902, N'Revelle', N'Computer Science and Engineering', N'Material Science', N'normal')
INSERT [dbo].[undergraduate] ([student_id], [college], [major], [minor], [type]) VALUES (53012343, N'Revelle', N'Computer Science and Engineering', N'Electrical and Computer Engineering', N'normal')
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__class__course_id__4D94879B]') AND parent_object_id = OBJECT_ID(N'[dbo].[class]'))
ALTER TABLE [dbo].[class]  WITH CHECK ADD  CONSTRAINT [FK__class__course_id__4D94879B] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__class__course_id__4D94879B]') AND parent_object_id = OBJECT_ID(N'[dbo].[class]'))
ALTER TABLE [dbo].[class] CHECK CONSTRAINT [FK__class__course_id__4D94879B]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__class_sec__cours__398D8EEE]') AND parent_object_id = OBJECT_ID(N'[dbo].[class_section]'))
ALTER TABLE [dbo].[class_section]  WITH CHECK ADD  CONSTRAINT [FK__class_sec__cours__398D8EEE] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__class_sec__cours__398D8EEE]') AND parent_object_id = OBJECT_ID(N'[dbo].[class_section]'))
ALTER TABLE [dbo].[class_section] CHECK CONSTRAINT [FK__class_sec__cours__398D8EEE]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__class_sec__secti__3A81B327]') AND parent_object_id = OBJECT_ID(N'[dbo].[class_section]'))
ALTER TABLE [dbo].[class_section]  WITH CHECK ADD  CONSTRAINT [FK__class_sec__secti__3A81B327] FOREIGN KEY([section_id])
REFERENCES [dbo].[section] ([section_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__class_sec__secti__3A81B327]') AND parent_object_id = OBJECT_ID(N'[dbo].[class_section]'))
ALTER TABLE [dbo].[class_section] CHECK CONSTRAINT [FK__class_sec__secti__3A81B327]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__committee__facul__6383C8BA]') AND parent_object_id = OBJECT_ID(N'[dbo].[committee]'))
ALTER TABLE [dbo].[committee]  WITH CHECK ADD  CONSTRAINT [FK__committee__facul__6383C8BA] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[faculty] ([faculty_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__committee__facul__6383C8BA]') AND parent_object_id = OBJECT_ID(N'[dbo].[committee]'))
ALTER TABLE [dbo].[committee] CHECK CONSTRAINT [FK__committee__facul__6383C8BA]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__committee__stude__3C69FB99]') AND parent_object_id = OBJECT_ID(N'[dbo].[committee]'))
ALTER TABLE [dbo].[committee]  WITH CHECK ADD  CONSTRAINT [FK__committee__stude__3C69FB99] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__committee__stude__3C69FB99]') AND parent_object_id = OBJECT_ID(N'[dbo].[committee]'))
ALTER TABLE [dbo].[committee] CHECK CONSTRAINT [FK__committee__stude__3C69FB99]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_course_department]') AND parent_object_id = OBJECT_ID(N'[dbo].[course]'))
ALTER TABLE [dbo].[course]  WITH CHECK ADD  CONSTRAINT [FK_course_department] FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_course_department]') AND parent_object_id = OBJECT_ID(N'[dbo].[course]'))
ALTER TABLE [dbo].[course] CHECK CONSTRAINT [FK_course_department]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__faculty__departm__412EB0B6]') AND parent_object_id = OBJECT_ID(N'[dbo].[faculty]'))
ALTER TABLE [dbo].[faculty]  WITH CHECK ADD FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__depart__3F466844]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__depart__3F466844] FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__depart__3F466844]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__depart__3F466844]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__studen__4BAC3F29]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__studen__4BAC3F29] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__studen__4BAC3F29]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__studen__4BAC3F29]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_graduate_degree]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK_graduate_degree] FOREIGN KEY([degree_type])
REFERENCES [dbo].[degree] ([degree_type])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_graduate_degree]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK_graduate_degree]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__meeting__section__44FF419A]') AND parent_object_id = OBJECT_ID(N'[dbo].[meeting]'))
ALTER TABLE [dbo].[meeting]  WITH CHECK ADD  CONSTRAINT [FK__meeting__section__44FF419A] FOREIGN KEY([section_id])
REFERENCES [dbo].[section] ([section_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__meeting__section__44FF419A]') AND parent_object_id = OBJECT_ID(N'[dbo].[meeting]'))
ALTER TABLE [dbo].[meeting] CHECK CONSTRAINT [FK__meeting__section__44FF419A]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__plans__course_id__656C112C]') AND parent_object_id = OBJECT_ID(N'[dbo].[plans]'))
ALTER TABLE [dbo].[plans]  WITH CHECK ADD  CONSTRAINT [FK__plans__course_id__656C112C] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__plans__course_id__656C112C]') AND parent_object_id = OBJECT_ID(N'[dbo].[plans]'))
ALTER TABLE [dbo].[plans] CHECK CONSTRAINT [FK__plans__course_id__656C112C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_plans_program]') AND parent_object_id = OBJECT_ID(N'[dbo].[plans]'))
ALTER TABLE [dbo].[plans]  WITH CHECK ADD  CONSTRAINT [FK_plans_program] FOREIGN KEY([program_name])
REFERENCES [dbo].[program] ([name])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_plans_program]') AND parent_object_id = OBJECT_ID(N'[dbo].[plans]'))
ALTER TABLE [dbo].[plans] CHECK CONSTRAINT [FK_plans_program]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__prerequis__cours__46E78A0C]') AND parent_object_id = OBJECT_ID(N'[dbo].[prerequisite]'))
ALTER TABLE [dbo].[prerequisite]  WITH CHECK ADD  CONSTRAINT [FK__prerequis__cours__46E78A0C] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__prerequis__cours__46E78A0C]') AND parent_object_id = OBJECT_ID(N'[dbo].[prerequisite]'))
ALTER TABLE [dbo].[prerequisite] CHECK CONSTRAINT [FK__prerequis__cours__46E78A0C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__prerequis__pre_c__47DBAE45]') AND parent_object_id = OBJECT_ID(N'[dbo].[prerequisite]'))
ALTER TABLE [dbo].[prerequisite]  WITH CHECK ADD  CONSTRAINT [FK__prerequis__pre_c__47DBAE45] FOREIGN KEY([pre_course_id])
REFERENCES [dbo].[course] ([course_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__prerequis__pre_c__47DBAE45]') AND parent_object_id = OBJECT_ID(N'[dbo].[prerequisite]'))
ALTER TABLE [dbo].[prerequisite] CHECK CONSTRAINT [FK__prerequis__pre_c__47DBAE45]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__probation__stude__48CFD27E]') AND parent_object_id = OBJECT_ID(N'[dbo].[probation]'))
ALTER TABLE [dbo].[probation]  WITH CHECK ADD  CONSTRAINT [FK__probation__stude__48CFD27E] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__probation__stude__48CFD27E]') AND parent_object_id = OBJECT_ID(N'[dbo].[probation]'))
ALTER TABLE [dbo].[probation] CHECK CONSTRAINT [FK__probation__stude__48CFD27E]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_program_degree]') AND parent_object_id = OBJECT_ID(N'[dbo].[program]'))
ALTER TABLE [dbo].[program]  WITH CHECK ADD  CONSTRAINT [FK_program_degree] FOREIGN KEY([degree_type])
REFERENCES [dbo].[degree] ([degree_type])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_program_degree]') AND parent_object_id = OBJECT_ID(N'[dbo].[program]'))
ALTER TABLE [dbo].[program] CHECK CONSTRAINT [FK_program_degree]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_program_department]') AND parent_object_id = OBJECT_ID(N'[dbo].[program]'))
ALTER TABLE [dbo].[program]  WITH CHECK ADD  CONSTRAINT [FK_program_department] FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_program_department]') AND parent_object_id = OBJECT_ID(N'[dbo].[program]'))
ALTER TABLE [dbo].[program] CHECK CONSTRAINT [FK_program_department]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_program_requirement_program]') AND parent_object_id = OBJECT_ID(N'[dbo].[program_requirement]'))
ALTER TABLE [dbo].[program_requirement]  WITH CHECK ADD  CONSTRAINT [FK_program_requirement_program] FOREIGN KEY([program_name])
REFERENCES [dbo].[program] ([name])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_program_requirement_program]') AND parent_object_id = OBJECT_ID(N'[dbo].[program_requirement]'))
ALTER TABLE [dbo].[program_requirement] CHECK CONSTRAINT [FK_program_requirement_program]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__schedule__course__4BAC3F29]') AND parent_object_id = OBJECT_ID(N'[dbo].[schedule]'))
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK__schedule__course__4BAC3F29] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__schedule__course__4BAC3F29]') AND parent_object_id = OBJECT_ID(N'[dbo].[schedule]'))
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK__schedule__course__4BAC3F29]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__schedule__facult__60A75C0F]') AND parent_object_id = OBJECT_ID(N'[dbo].[schedule]'))
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK__schedule__facult__60A75C0F] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[faculty] ([faculty_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__schedule__facult__60A75C0F]') AND parent_object_id = OBJECT_ID(N'[dbo].[schedule]'))
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK__schedule__facult__60A75C0F]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_f__facul__6A30C649]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_faculties_project]'))
ALTER TABLE [dbo].[student_faculties_project]  WITH CHECK ADD  CONSTRAINT [FK__student_f__facul__6A30C649] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[faculty] ([faculty_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_f__facul__6A30C649]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_faculties_project]'))
ALTER TABLE [dbo].[student_faculties_project] CHECK CONSTRAINT [FK__student_f__facul__6A30C649]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_f__proje__5070F446]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_faculties_project]'))
ALTER TABLE [dbo].[student_faculties_project]  WITH CHECK ADD FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([project_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_f__stude__4F7CD00D]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_faculties_project]'))
ALTER TABLE [dbo].[student_faculties_project]  WITH CHECK ADD  CONSTRAINT [FK__student_f__stude__4F7CD00D] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_f__stude__4F7CD00D]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_faculties_project]'))
ALTER TABLE [dbo].[student_faculties_project] CHECK CONSTRAINT [FK__student_f__stude__4F7CD00D]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_student_program_program]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_program]'))
ALTER TABLE [dbo].[student_program]  WITH CHECK ADD  CONSTRAINT [FK_student_program_program] FOREIGN KEY([program_name])
REFERENCES [dbo].[program] ([name])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_student_program_program]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_program]'))
ALTER TABLE [dbo].[student_program] CHECK CONSTRAINT [FK_student_program_program]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_s__secti__534D60F1]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_section]'))
ALTER TABLE [dbo].[student_section]  WITH CHECK ADD  CONSTRAINT [FK__student_s__secti__534D60F1] FOREIGN KEY([section_id])
REFERENCES [dbo].[section] ([section_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_s__secti__534D60F1]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_section]'))
ALTER TABLE [dbo].[student_section] CHECK CONSTRAINT [FK__student_s__secti__534D60F1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_s__stude__52593CB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_section]'))
ALTER TABLE [dbo].[student_section]  WITH CHECK ADD  CONSTRAINT [FK__student_s__stude__52593CB8] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_s__stude__52593CB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_section]'))
ALTER TABLE [dbo].[student_section] CHECK CONSTRAINT [FK__student_s__stude__52593CB8]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__teach__faculty_i__5DCAEF64]') AND parent_object_id = OBJECT_ID(N'[dbo].[teach]'))
ALTER TABLE [dbo].[teach]  WITH CHECK ADD  CONSTRAINT [FK__teach__faculty_i__5DCAEF64] FOREIGN KEY([faculty_id])
REFERENCES [dbo].[faculty] ([faculty_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__teach__faculty_i__5DCAEF64]') AND parent_object_id = OBJECT_ID(N'[dbo].[teach]'))
ALTER TABLE [dbo].[teach] CHECK CONSTRAINT [FK__teach__faculty_i__5DCAEF64]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__teach__section_i__5629CD9C]') AND parent_object_id = OBJECT_ID(N'[dbo].[teach]'))
ALTER TABLE [dbo].[teach]  WITH CHECK ADD  CONSTRAINT [FK__teach__section_i__5629CD9C] FOREIGN KEY([section_id])
REFERENCES [dbo].[section] ([section_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__teach__section_i__5629CD9C]') AND parent_object_id = OBJECT_ID(N'[dbo].[teach]'))
ALTER TABLE [dbo].[teach] CHECK CONSTRAINT [FK__teach__section_i__5629CD9C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__undergrad__major__571DF1D5]') AND parent_object_id = OBJECT_ID(N'[dbo].[undergraduate]'))
ALTER TABLE [dbo].[undergraduate]  WITH CHECK ADD FOREIGN KEY([major])
REFERENCES [dbo].[department] ([name])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__undergrad__minor__5812160E]') AND parent_object_id = OBJECT_ID(N'[dbo].[undergraduate]'))
ALTER TABLE [dbo].[undergraduate]  WITH CHECK ADD FOREIGN KEY([minor])
REFERENCES [dbo].[department] ([name])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__undergrad__stude__5535A963]') AND parent_object_id = OBJECT_ID(N'[dbo].[undergraduate]'))
ALTER TABLE [dbo].[undergraduate]  WITH CHECK ADD  CONSTRAINT [FK__undergrad__stude__5535A963] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__undergrad__stude__5535A963]') AND parent_object_id = OBJECT_ID(N'[dbo].[undergraduate]'))
ALTER TABLE [dbo].[undergraduate] CHECK CONSTRAINT [FK__undergrad__stude__5535A963]
GO
USE [master]
GO
ALTER DATABASE [tritonlink] SET  READ_WRITE 
GO
