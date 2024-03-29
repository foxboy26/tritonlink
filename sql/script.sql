USE [master]
GO
/****** Object:  Database [tritonlink]    Script Date: 2013/3/13 16:58:29 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'tritonlink')
BEGIN
CREATE DATABASE [tritonlink]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tritonlink', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\tritonlink.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'tritonlink_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\tritonlink_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[class]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[class_section]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[committee]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[course]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[CPG]    Script Date: 2013/3/13 16:58:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CPG]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CPG](
	[course_id] [varchar](7) NOT NULL,
	[faculty_id] [int] NOT NULL,
	[count] [int] NULL,
	[type] [varchar](5) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CPQG]    Script Date: 2013/3/13 16:58:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CPQG]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CPQG](
	[course_id] [varchar](7) NOT NULL,
	[faculty_id] [int] NOT NULL,
	[quarter] [varchar](15) NOT NULL,
	[count] [int] NULL,
	[type] [varchar](5) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[degree]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[department]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[faculty]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[grade_conversion]    Script Date: 2013/3/13 16:58:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[grade_conversion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[grade_conversion](
	[letter_grade] [varchar](2) NOT NULL,
	[number_grade] [decimal](2, 1) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[graduate]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[meeting]    Script Date: 2013/3/13 16:58:29 ******/
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
	[start_time] [time](0) NOT NULL,
	[end_time] [time](0) NOT NULL,
	[days] [varchar](45) NOT NULL,
	[mandatory] [bit] NOT NULL,
 CONSTRAINT [PK_meeting] PRIMARY KEY CLUSTERED 
(
	[section_id] ASC,
	[type] ASC,
	[start_time] ASC,
	[end_time] ASC,
	[days] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[plans]    Script Date: 2013/3/13 16:58:29 ******/
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
 CONSTRAINT [PK_plans_1] PRIMARY KEY CLUSTERED 
(
	[program_name] ASC,
	[course_id] ASC,
	[category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[prerequisite]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[probation]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[program]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[program_requirement]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[project]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[schedule]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[section]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[student]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[student_faculties_project]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[student_program]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[student_section]    Script Date: 2013/3/13 16:58:29 ******/
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
	[grade_type] [varchar](8) NOT NULL,
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
/****** Object:  Table [dbo].[teach]    Script Date: 2013/3/13 16:58:29 ******/
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
/****** Object:  Table [dbo].[undergraduate]    Script Date: 2013/3/13 16:58:29 ******/
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
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'BENG1', N'Winter 2013', N'Introduction to Bioengineering')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE132B', N'Winter 2013', N'Database System Applications')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE135', N'Fall 2011', N'Server-side Web Applications')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE200', N'Winter 2013', N'Computability and Complexity')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE202', N'Fall 2012', N'Algorithm Design and Analysis')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE202', N'Winter 2013', N'Algorithm Design and Analysis')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE226', N'Fall 2011', N'Storage Systems')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE230', N'Winter 2013', N'Principles Programming Languages')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE232A', N'Fall 2012', N'Principles of Database Systems')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE232B', N'Spring 2013', N'Database System Implementation')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE233', N'Spring 2013', N'Database Theory')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE240A', N'Winter 2013', N'Principles of Computer Architecture')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE250A', N'Fall 2011', N'Artificial Intelligence: Search and Reasoning')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE250A', N'Fall 2012', N'Artificial Intelligence: Search and Reasoning')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE250B', N'Fall 2014', N'Artificial Intelligence II: Learning')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE250B', N'Winter 2013', N'Artificial Intelligence: Learning')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE292', N'Fall 2012', N'Faculty Research Sem: Frontiers in CSE')
INSERT [dbo].[class] ([course_id], [quarter], [title]) VALUES (N'CSE292', N'Winter 2013', N'Faculty Research Sem: Frontiers in CSE')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'BENG1', N'1', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'BENG1', N'2', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'BENG1', N'3', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'BENG1', N'4', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE132B', N'5', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE132B', N'6', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE135', N'13', N'Fall 2011')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE135', N'23', N'Fall 2011')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE200', N'19', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE200', N'24', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE202', N'18', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE202', N'22', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE202', N'8', N'Fall 2012')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE226', N'14', N'Fall 2011')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE230', N'7', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE232A', N'10', N'Fall 2012')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE232B', N'11', N'Spring 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE240A', N'15', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE250A', N'21', N'Fall 2011')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE250A', N'9', N'Fall 2012')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE250B', N'16', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE250B', N'17', N'Winter 2013')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE292', N'12', N'Fall 2012')
INSERT [dbo].[class_section] ([course_id], [section_id], [quarter]) VALUES (N'CSE292', N'20', N'Winter 2013')
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53025734, 23011111)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53025734, 23012345)
INSERT [dbo].[committee] ([student_id], [faculty_id]) VALUES (53025734, 52012323)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'BENG1', N'Bioengineering', 0, N'4', N'Letter', 1)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE132B', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE135', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE200', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE202', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE221', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE226', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE230', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE232A', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE232B', N'Computer Science and Engineering', 1, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE233', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE240A', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE250A', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE250B', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE251', N'Computer Science and Engineering', 0, N'4', N'Letter', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE292', N'Computer Science and Engineering', 0, N'1', N'S/U', 0)
INSERT [dbo].[course] ([course_id], [department], [is_consent], [unit_range], [grade_type], [labwork]) VALUES (N'CSE298', N'Computer Science and Engineering', 1, N'1~8', N'S/U Only', 0)
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'BENG1', 52012223, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'BENG1', 52012223, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'BENG1', 52012223, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'BENG1', 52012223, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'BENG1', 52012223, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23011111, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23011111, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23011111, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23011111, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23011111, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23023456, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23023456, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23023456, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23023456, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE132B', 23023456, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23011111, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23011111, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23011111, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23011111, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23011111, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23023456, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23023456, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23023456, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23023456, 1, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE135', 23023456, 1, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE200', 23012345, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE200', 23012345, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE200', 23012345, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE200', 23012345, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE200', 23012345, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23011111, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23011111, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23011111, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23011111, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23011111, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23012345, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23012345, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23012345, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23012345, 1, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE202', 23012345, 1, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE226', 23011111, 1, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE226', 23011111, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE226', 23011111, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE226', 23011111, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE226', 23011111, 2, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE230', 52023336, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE230', 52023336, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE230', 52023336, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE230', 52023336, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE230', 52023336, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232A', 23011111, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232A', 23011111, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232A', 23011111, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232A', 23011111, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232A', 23011111, 2, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232B', 23023456, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232B', 23023456, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232B', 23023456, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232B', 23023456, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE232B', 23023456, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE240A', 52025433, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE240A', 52025433, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE240A', 52025433, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE240A', 52025433, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE240A', 52025433, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250A', 52012323, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250A', 52012323, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250A', 52012323, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250A', 52012323, 2, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250A', 52012323, 3, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52000944, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52000944, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52000944, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52000944, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52000944, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52012323, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52012323, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52012323, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52012323, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE250B', 52012323, 0, N'Other')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE292', 52084842, 0, N'A')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE292', 52084842, 0, N'B')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE292', 52084842, 0, N'C')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE292', 52084842, 0, N'D')
INSERT [dbo].[CPG] ([course_id], [faculty_id], [count], [type]) VALUES (N'CSE292', 52084842, 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'BENG1', 52012223, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'BENG1', 52012223, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'BENG1', 52012223, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'BENG1', 52012223, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'BENG1', 52012223, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23011111, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23011111, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23011111, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23011111, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23011111, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23023456, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23023456, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23023456, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23023456, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE132B', 23023456, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23011111, N'Fall 2011', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23011111, N'Fall 2011', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23011111, N'Fall 2011', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23011111, N'Fall 2011', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23011111, N'Fall 2011', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23023456, N'Fall 2011', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23023456, N'Fall 2011', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23023456, N'Fall 2011', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23023456, N'Fall 2011', 1, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE135', 23023456, N'Fall 2011', 1, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE200', 23012345, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE200', 23012345, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE200', 23012345, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE200', 23012345, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE200', 23012345, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23011111, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23011111, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23011111, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23011111, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23011111, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Fall 2012', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Fall 2012', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Fall 2012', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Fall 2012', 1, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Fall 2012', 1, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE202', 23012345, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE226', 23011111, N'Fall 2011', 1, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE226', 23011111, N'Fall 2011', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE226', 23011111, N'Fall 2011', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE226', 23011111, N'Fall 2011', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE226', 23011111, N'Fall 2011', 2, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE230', 52023336, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE230', 52023336, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE230', 52023336, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE230', 52023336, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE230', 52023336, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232A', 23011111, N'Fall 2012', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232A', 23011111, N'Fall 2012', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232A', 23011111, N'Fall 2012', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232A', 23011111, N'Fall 2012', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232A', 23011111, N'Fall 2012', 2, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232B', 23023456, N'Spring 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232B', 23023456, N'Spring 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232B', 23023456, N'Spring 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232B', 23023456, N'Spring 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE232B', 23023456, N'Spring 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE240A', 52025433, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE240A', 52025433, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE240A', 52025433, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE240A', 52025433, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE240A', 52025433, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2011', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2011', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2011', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2011', 1, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2011', 1, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2012', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2012', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2012', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2012', 1, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250A', 52012323, N'Fall 2012', 2, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52000944, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52000944, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52000944, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52000944, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52000944, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52012323, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52012323, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52012323, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52012323, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE250B', 52012323, N'Winter 2013', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Fall 2012', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Fall 2012', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Fall 2012', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Fall 2012', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Fall 2012', 0, N'Other')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Winter 2013', 0, N'A')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Winter 2013', 0, N'B')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Winter 2013', 0, N'C')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Winter 2013', 0, N'D')
INSERT [dbo].[CPQG] ([course_id], [faculty_id], [quarter], [count], [type]) VALUES (N'CSE292', 52084842, N'Winter 2013', 0, N'Other')
GO
INSERT [dbo].[degree] ([degree_type]) VALUES (N'B.A')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'B.E')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'B.S')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'M. Eng')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'M.S.')
INSERT [dbo].[degree] ([degree_type]) VALUES (N'PH.D')
INSERT [dbo].[department] ([name]) VALUES (N'Anesthesiology')
INSERT [dbo].[department] ([name]) VALUES (N'Anthropology')
INSERT [dbo].[department] ([name]) VALUES (N'Bioengineering')
INSERT [dbo].[department] ([name]) VALUES (N'Chemical Engineering')
INSERT [dbo].[department] ([name]) VALUES (N'Chinese Studies')
INSERT [dbo].[department] ([name]) VALUES (N'Computer Science and Engineering')
INSERT [dbo].[department] ([name]) VALUES (N'Linguistics')
INSERT [dbo].[department] ([name]) VALUES (N'Music')
INSERT [dbo].[department] ([name]) VALUES (N'Visual Arts')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (23011111, N'Yannis Papakonstantinou', N'Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (23012345, N'Russell Impagliazzo', N'Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (23023456, N'Alin Deutsch', N'Associate Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (52000944, N'Sanjoy Dasgupta', N'Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (52012223, N'G. Cauwenberghs', N'Professor', N'Bioengineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (52012323, N'Charles Elkan', N'Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (52012339, N'T. Coleman', N'Associate Professor', N'Bioengineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (52023336, N'Ranjit Jhala', N'Associate Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (52025433, N'Michael B. Taylor', N'Professor', N'Computer Science and Engineering')
INSERT [dbo].[faculty] ([faculty_id], [name], [title], [department]) VALUES (52084842, N'Yuanyuan Zhou', N'Professor', N'Computer Science and Engineering')
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'A+', CAST(4.3 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'A', CAST(4.0 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'A-', CAST(3.7 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'B+', CAST(3.4 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'B', CAST(3.1 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'B-', CAST(2.8 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'C+', CAST(2.5 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'C', CAST(2.2 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'C-', CAST(1.9 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'D', CAST(1.6 AS Decimal(2, 1)))
INSERT [dbo].[grade_conversion] ([letter_grade], [number_grade]) VALUES (N'F', CAST(0.0 AS Decimal(2, 1)))
INSERT [dbo].[graduate] ([student_id], [department], [degree_type], [state]) VALUES (53000007, N'Anesthesiology', N'M. Eng', NULL)
INSERT [dbo].[graduate] ([student_id], [department], [degree_type], [state]) VALUES (53025734, N'Computer Science and Engineering', N'M.S.', NULL)
INSERT [dbo].[graduate] ([student_id], [department], [degree_type], [state]) VALUES (53032364, N'Computer Science and Engineering', N'M.S.', NULL)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'10', N'DI', N'4567', CAST(0x00B09A0000000000 AS Time), CAST(0x00B8A10000000000 AS Time), N'Tu', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'14', N'LE', N'1234', CAST(0x00A08C0000000000 AS Time), CAST(0x00C0A80000000000 AS Time), N'Mo', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'15', N'DI', N'ABC', CAST(0x00302A0000000000 AS Time), CAST(0x0040380000000000 AS Time), N'Th', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'15', N'RW', N'ABC', CAST(0x0000E10000000000 AS Time), CAST(0x0010EF0000000000 AS Time), N'4/24/2013', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'17', N'DI', N'WHL2214', CAST(0x00907E0000000000 AS Time), CAST(0x00A8930000000000 AS Time), N'Fr', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'18', N'DI', N'ABC', CAST(0x00F0D20000000000 AS Time), CAST(0x0000E10000000000 AS Time), N'We', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'19', N'DI', N'WHL2214', CAST(0x00E0C40000000000 AS Time), CAST(0x00F0D20000000000 AS Time), N'We', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'20', N'LE', N'ABC', CAST(0x00A8930000000000 AS Time), CAST(0x00609F0000000000 AS Time), N'Mo', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'23', N'LE', N'HSS', CAST(0x00907E0000000000 AS Time), CAST(0x00A08C0000000000 AS Time), N'We', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'5', N'DI', N'ABC', CAST(0x00907E0000000000 AS Time), CAST(0x00A08C0000000000 AS Time), N'We', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'6', N'DI', N'HSS', CAST(0x0000E10000000000 AS Time), CAST(0x0010EF0000000000 AS Time), N'Mo', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'6', N'LE', N'HSS', CAST(0x00907E0000000000 AS Time), CAST(0x00A8930000000000 AS Time), N'Fr', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'6', N'LE', N'HSS', CAST(0x00907E0000000000 AS Time), CAST(0x00A8930000000000 AS Time), N'Mo', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'6', N'LE', N'HSS', CAST(0x00907E0000000000 AS Time), CAST(0x00A8930000000000 AS Time), N'We', 1)
INSERT [dbo].[meeting] ([section_id], [type], [location], [start_time], [end_time], [days], [mandatory]) VALUES (N'7', N'RW', N'WHL2212', CAST(0x00A08C0000000000 AS Time), CAST(0x00B09A0000000000 AS Time), N'01-03-2013', 1)
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'BS IN CSE', N'BENG1', N'Elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'BS IN CSE', N'CSE132b', N'Elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'BS IN CSE', N'CSE132b', N'Upper')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'BS IN CSE', N'CSE202', N'Elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'BS IN CSE', N'CSE202', N'Upper')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE132B', N'c-database')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE135', N'c-database')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE200', N'elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE202', N'core')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE221', N'core')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE226', N'c-database')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE226', N'elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE232A', N'c-database')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE232A', N'elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE232B', N'c-database')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE233', N'c-database')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE233', N'elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE240A', N'core')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE250A', N'c-ai')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE250A', N'elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE250B', N'c-ai')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE250B', N'elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE251', N'c-ai')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE251', N'elective')
INSERT [dbo].[plans] ([program_name], [course_id], [category]) VALUES (N'MS IN CSE', N'CSE292', N'core')
INSERT [dbo].[probation] ([student_id], [start_time], [end_time], [reason]) VALUES (51012345, N'Spring2012', N'Fall2012', N'make film')
INSERT [dbo].[probation] ([student_id], [start_time], [end_time], [reason]) VALUES (53025734, N'Fall2013', N'Winter2013', N'Happying~')
INSERT [dbo].[program] ([name], [degree_type], [department]) VALUES (N'BE IN BENG', N'B.E', N'Bioengineering')
INSERT [dbo].[program] ([name], [degree_type], [department]) VALUES (N'BS IN CSE', N'B.S', N'Computer Science and Engineering')
INSERT [dbo].[program] ([name], [degree_type], [department]) VALUES (N'MS IN CSE', N'M.S.', N'Computer Science and Engineering')
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'BE IN BENG', N'all', 150, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'BE IN BENG', N'Lower', 60, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'BE IN BENG', N'Upper', 40, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'BS IN CSE', N'all', 150, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'BS IN CSE', N'Elective', 50, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'BS IN CSE', N'Lower', 60, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'BS IN CSE', N'Upper', 40, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'MS IN CSE', N'all', 49, 0)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'MS IN CSE', N'c-ai', 12, 3)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'MS IN CSE', N'c-archi', 12, 3)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'MS IN CSE', N'c-database', 12, 3)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'MS IN CSE', N'core', 13, 3)
INSERT [dbo].[program_requirement] ([program_name], [category], [units], [min_gpa]) VALUES (N'MS IN CSE', N'elective', 12, 3)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'1', 2, 0, 2)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'10', 0, 0, 50)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'11', 0, 0, 30)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'12', 0, 0, 80)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'13', 0, 0, 20)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'14', 0, 0, 40)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'15', 0, 0, 40)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'16', 1, 0, 40)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'17', 0, 0, 30)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'18', 0, 0, 20)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'19', 0, 0, 10)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'2', 0, 0, 120)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'20', 0, 0, 30)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'21', 0, 0, 10)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'22', 0, 0, 10)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'23', 0, 0, 10)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'24', 0, 0, 10)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'3', 0, 0, 80)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'4', 0, 0, 50)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'5', 1, 0, 30)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'6', 0, 0, 20)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'7', 0, 0, 40)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'8', 0, 0, 50)
INSERT [dbo].[section] ([section_id], [enrolled_num], [waitlist_num], [limit_num]) VALUES (N'9', 0, 0, 50)
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (51012345, N'Xiaoming', N'', N'Huang', 1000000000, N'California resident', 1, N'abc university B.A;', N'Spring 2010-Spring 2012;')
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (53000007, N'Bond', N'', N'James', 1234567890, N'California resident', 1, N'abc university B.A;', N'Spring 2011-Spring 2012;')
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (53025734, N'Zhiheng', N'', N'Li', NULL, N'Non-CA US student', 1, N'Shanghai Jiao Tong University B.E;', N'Fall 2012-Spring 2013;')
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency], [is_enrolled], [hold_degrees], [attendances]) VALUES (53032364, N'Xixi', N'', N'Xiao', NULL, N'Non-CA US student', 1, N'Tsinghua University B.E;', N'Fall 2012-Spring 2013;')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (51012345, N'13', N'enrolled', 4, N'B', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (51012345, N'21', N'enrolled', 4, N'B', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (51012345, N'5', N'enrolled', 4, NULL, N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (51012345, N'8', N'enrolled', 4, N'C+', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53000007, N'1', N'enrolled', 4, NULL, N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53000007, N'14', N'enrolled', 4, N'A-', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53000007, N'21', N'enrolled', 4, N'A+', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53000007, N'9', N'enrolled', 4, N'B-', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53025734, N'10', N'enrolled', 4, N'A', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53025734, N'14', N'enrolled', 4, N'B', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53025734, N'16', N'enrolled', 4, NULL, N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53025734, N'5', N'enrolled', 4, NULL, N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53025734, N'7', N'enrolled', 4, NULL, N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53025734, N'9', N'enrolled', 4, N'A', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'1', N'enrolled', 4, NULL, N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'10', N'enrolled', 4, N'A+', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'12', N'enrolled', 1, N'S', N'S/U')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'13', N'enrolled', 4, N'A+', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'14', N'enrolled', 4, N'A+', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'5', N'enrolled', 4, NULL, N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'7', N'enrolled', 4, NULL, N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'8', N'enrolled', 4, N'A+', N'Letter')
INSERT [dbo].[student_section] ([student_id], [section_id], [state], [unit], [grade], [grade_type]) VALUES (53032364, N'9', N'enrolled', 4, N'A', N'Grade')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23011111, N'10')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23011111, N'14')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23011111, N'22')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23011111, N'23')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23011111, N'5')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23012345, N'18')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23012345, N'19')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23012345, N'8')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23023456, N'11')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23023456, N'13')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (23023456, N'6')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52000944, N'17')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52000944, N'24')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52012223, N'1')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52012323, N'16')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52012323, N'21')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52012323, N'9')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52023336, N'7')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52025433, N'15')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52084842, N'12')
INSERT [dbo].[teach] ([faculty_id], [section_id]) VALUES (52084842, N'20')
INSERT [dbo].[undergraduate] ([student_id], [college], [major], [minor], [type]) VALUES (51012345, N'Revelle', N'Anesthesiology', N'Visual Arts', N'normal')
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
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__faculty__departm__4222D4EF]') AND parent_object_id = OBJECT_ID(N'[dbo].[faculty]'))
ALTER TABLE [dbo].[faculty]  WITH CHECK ADD FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__faculty__departm__4316F928]') AND parent_object_id = OBJECT_ID(N'[dbo].[faculty]'))
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
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_f__proje__52593CB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_faculties_project]'))
ALTER TABLE [dbo].[student_faculties_project]  WITH CHECK ADD FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([project_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_f__proje__534D60F1]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_faculties_project]'))
ALTER TABLE [dbo].[student_faculties_project]  WITH CHECK ADD FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([project_id])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_f__proje__5441852A]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_faculties_project]'))
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
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__undergrad__major__5AEE82B9]') AND parent_object_id = OBJECT_ID(N'[dbo].[undergraduate]'))
ALTER TABLE [dbo].[undergraduate]  WITH CHECK ADD FOREIGN KEY([major])
REFERENCES [dbo].[department] ([name])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__undergrad__major__5BE2A6F2]') AND parent_object_id = OBJECT_ID(N'[dbo].[undergraduate]'))
ALTER TABLE [dbo].[undergraduate]  WITH CHECK ADD FOREIGN KEY([major])
REFERENCES [dbo].[department] ([name])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__undergrad__minor__5CD6CB2B]') AND parent_object_id = OBJECT_ID(N'[dbo].[undergraduate]'))
ALTER TABLE [dbo].[undergraduate]  WITH CHECK ADD FOREIGN KEY([minor])
REFERENCES [dbo].[department] ([name])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__undergrad__minor__5DCAEF64]') AND parent_object_id = OBJECT_ID(N'[dbo].[undergraduate]'))
ALTER TABLE [dbo].[undergraduate]  WITH CHECK ADD FOREIGN KEY([minor])
REFERENCES [dbo].[department] ([name])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__undergrad__minor__5EBF139D]') AND parent_object_id = OBJECT_ID(N'[dbo].[undergraduate]'))
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
/****** Object:  Trigger [dbo].[cpqg_cpg_tr]    Script Date: 2013/3/13 16:58:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[cpqg_cpg_tr]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[cpqg_cpg_tr] 
   ON  [dbo].[class_section]
   FOR INSERT
AS
	DECLARE @facultyId AS INT,
		    @courseId AS VARCHAR(7),
			@quarter AS VARCHAR(15),
			@grade AS VARCHAR(2)

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	SELECT @facultyId=t.faculty_id, @courseId=cs.course_id, @quarter=cs.quarter
	FROM inserted AS i, class_section AS cs, teach AS t 
	WHERE i.section_id=cs.section_id AND t.section_id=i.section_id
	
	INSERT INTO CPQG VALUES(@courseId, @facultyId, @quarter, 0, ''A'')
	INSERT INTO CPQG VALUES(@courseId, @facultyId, @quarter, 0, ''B'')
	INSERT INTO CPQG VALUES(@courseId, @facultyId, @quarter, 0, ''C'')
	INSERT INTO CPQG VALUES(@courseId, @facultyId, @quarter, 0, ''D'')
	INSERT INTO CPQG VALUES(@courseId, @facultyId, @quarter, 0, ''Other'')

	IF (NOT EXISTS (SELECT * FROM CPG WHERE CPG.course_id=@courseId AND CPG.faculty_id=@facultyId))
	BEGIN
		INSERT INTO CPG VALUES(@courseId, @facultyId, 0, ''A'')
		INSERT INTO CPG VALUES(@courseId, @facultyId, 0, ''B'')
		INSERT INTO CPG VALUES(@courseId, @facultyId, 0, ''C'')
		INSERT INTO CPG VALUES(@courseId, @facultyId, 0, ''D'')
		INSERT INTO CPG VALUES(@courseId, @facultyId, 0, ''Other'')
	END
END
' 
GO
/****** Object:  Trigger [dbo].[meeting_tr]    Script Date: 2013/3/13 16:58:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[meeting_tr]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[meeting_tr] 
   ON  [dbo].[meeting]
   FOR INSERT
AS
IF (
(select count(*) from meeting as m, inserted as i 
	where m.days = i.days 
	AND m.section_id= i.section_id
	AND i.start_time < m.end_time
	AND i.end_time > m.start_time
) > 1)
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for trigger here

	raiserror(''conflict'', 16, 16)
	rollback transaction
END

' 
GO
/****** Object:  Trigger [dbo].[meeting_tr2]    Script Date: 2013/3/13 16:58:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[meeting_tr2]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[meeting_tr2] 
   ON  [dbo].[meeting]
   FOR INSERT
AS
IF (
(select count (*) from  
	(select t.faculty_id, cs.quarter from meeting as m, teach as t,class_section as cs, inserted as i 
	where i.section_id = m.section_id
	AND m.section_id = t.section_id AND cs.section_id= m.section_id) as f, teach as t, meeting as m, class_section as cs, inserted as i 
	where f.faculty_id = t.faculty_id 
	AND f.quarter = cs.quarter
	AND cs.section_id = t.section_id
	AND i.days = m.days
	AND i.days = m.days
	AND t.section_id = m.section_id
	AND i.start_time < m.end_time
	AND i.end_time > m.start_time
) > 1)
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for trigger here

	raiserror(''faculty conflict'', 16, 16)
	rollback transaction
END

' 
GO
/****** Object:  Trigger [dbo].[section_tr]    Script Date: 2013/3/13 16:58:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[section_tr]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[section_tr]  
   ON  [dbo].[section] 
   FOR UPDATE
AS 
IF ((select limit_num from deleted) = (select enrolled_num from deleted))
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	raiserror(''conflict'', 16, 16)
	rollback transaction
END

' 
GO
/****** Object:  Trigger [dbo].[cpg_tr]    Script Date: 2013/3/13 16:58:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[cpg_tr]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[cpg_tr] 
   ON  [dbo].[student_section]
   FOR INSERT
AS
	DECLARE @facultyId AS INT,
		    @courseId AS VARCHAR(7),
			@grade AS VARCHAR(2)

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	SELECT @facultyId=t.faculty_id, @courseId=cs.course_id, @grade=SUBSTRING(i.grade, 1, 1) 
	FROM inserted AS i, class_section AS cs, teach AS t 
	WHERE i.section_id=cs.section_id AND t.section_id=i.section_id
	
	UPDATE CPG SET CPG.count=CPG.count+1
	WHERE CPG.course_id=@courseId
	AND CPG.faculty_id=@facultyId
	AND CPG.type=@grade
END
' 
GO
/****** Object:  Trigger [dbo].[cpqg_tr]    Script Date: 2013/3/13 16:58:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[cpqg_tr]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[cpqg_tr] 
   ON  [dbo].[student_section]
   FOR INSERT
AS
	DECLARE @facultyId AS INT,
		    @courseId AS VARCHAR(7),
			@quarter AS VARCHAR(15),
			@grade AS VARCHAR(2)

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	SELECT @facultyId=t.faculty_id, @courseId=cs.course_id, @quarter=cs.quarter, @grade=SUBSTRING(i.grade, 1, 1) 
	FROM inserted AS i, class_section AS cs, teach AS t 
	WHERE i.section_id=cs.section_id AND t.section_id=i.section_id
	
	UPDATE CPQG SET CPQG.count=CPQG.count+1
	WHERE CPQG.course_id=@courseId
	AND CPQG.faculty_id=@facultyId
	AND CPQG.quarter=@quarter
	AND CPQG.type=@grade
END
' 
GO
USE [master]
GO
ALTER DATABASE [tritonlink] SET  READ_WRITE 
GO
