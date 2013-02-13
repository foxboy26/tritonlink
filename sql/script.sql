USE [master]
GO
/****** Object:  Database [tritonlink]    Script Date: 2013/2/12 19:34:18 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'tritonlink')
BEGIN
CREATE DATABASE [tritonlink]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'tritonlink', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\tritonlink.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'tritonlink_log', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\tritonlink_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[class]    Script Date: 2013/2/12 19:34:18 ******/
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
/****** Object:  Table [dbo].[class_section]    Script Date: 2013/2/12 19:34:19 ******/
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
 CONSTRAINT [PK__class_se__309AD1D8304FBF16] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC,
	[section_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[committee]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[course]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[degree]    Script Date: 2013/2/12 19:34:19 ******/
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
 CONSTRAINT [PK_degree] PRIMARY KEY CLUSTERED 
(
	[degree_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[department]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[faculty]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[graduate]    Script Date: 2013/2/12 19:34:19 ******/
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
	[degree] [varchar](10) NOT NULL,
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
/****** Object:  Table [dbo].[meeting]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[plans]    Script Date: 2013/2/12 19:34:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[plans]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[plans](
	[degree] [varchar](10) NOT NULL,
	[course_id] [varchar](7) NOT NULL,
	[category] [varchar](50) NOT NULL,
	[department] [varchar](50) NOT NULL,
 CONSTRAINT [PK__plans__51BABAA72F26904E] PRIMARY KEY CLUSTERED 
(
	[degree] ASC,
	[course_id] ASC,
	[department] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[prerequisite]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[probation]    Script Date: 2013/2/12 19:34:19 ******/
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
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[program]    Script Date: 2013/2/12 19:34:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[program]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[program](
	[degree] [varchar](10) NOT NULL,
	[category] [varchar](50) NOT NULL,
	[units] [tinyint] NOT NULL,
	[min_gpa] [float] NOT NULL,
	[department] [varchar](50) NOT NULL,
 CONSTRAINT [PK__program__CF1A0B48A9650185] PRIMARY KEY CLUSTERED 
(
	[department] ASC,
	[degree] ASC,
	[category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[project]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[schedule]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[section]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[student]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[student_faculties_project]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[student_program]    Script Date: 2013/2/12 19:34:19 ******/
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
	[degree] [varchar](10) NOT NULL,
 CONSTRAINT [PK__student___1894476CC9599D9F] PRIMARY KEY CLUSTERED 
(
	[student_id] ASC,
	[degree] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[student_section]    Script Date: 2013/2/12 19:34:19 ******/
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
	[grade_type] [varchar](8) NOT NULL,
	[unit] [tinyint] NOT NULL,
	[grade] [varchar](2) NOT NULL,
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
/****** Object:  Table [dbo].[teach]    Script Date: 2013/2/12 19:34:19 ******/
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
/****** Object:  Table [dbo].[undergraduate]    Script Date: 2013/2/12 19:34:19 ******/
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
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_class_section_class_section]') AND parent_object_id = OBJECT_ID(N'[dbo].[class_section]'))
ALTER TABLE [dbo].[class_section]  WITH CHECK ADD  CONSTRAINT [FK_class_section_class_section] FOREIGN KEY([course_id], [section_id])
REFERENCES [dbo].[class_section] ([course_id], [section_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_class_section_class_section]') AND parent_object_id = OBJECT_ID(N'[dbo].[class_section]'))
ALTER TABLE [dbo].[class_section] CHECK CONSTRAINT [FK_class_section_class_section]
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
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__faculty__departm__3F466844]') AND parent_object_id = OBJECT_ID(N'[dbo].[faculty]'))
ALTER TABLE [dbo].[faculty]  WITH CHECK ADD FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__degree__03F0984C]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__degree__03F0984C] FOREIGN KEY([degree])
REFERENCES [dbo].[degree] ([degree_type])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__degree__03F0984C]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__degree__03F0984C]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__depart__3F466844]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__depart__3F466844] FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__depart__3F466844]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__depart__3F466844]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__studen__38996AB5]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__studen__38996AB5] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__studen__38996AB5]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__studen__38996AB5]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__studen__3A81B327]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__studen__3A81B327] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__studen__3A81B327]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__studen__3A81B327]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__studen__4BAC3F29]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate]  WITH CHECK ADD  CONSTRAINT [FK__graduate__studen__4BAC3F29] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([student_id])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__graduate__studen__4BAC3F29]') AND parent_object_id = OBJECT_ID(N'[dbo].[graduate]'))
ALTER TABLE [dbo].[graduate] CHECK CONSTRAINT [FK__graduate__studen__4BAC3F29]
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
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__plans__degree__44FF419A]') AND parent_object_id = OBJECT_ID(N'[dbo].[plans]'))
ALTER TABLE [dbo].[plans]  WITH CHECK ADD  CONSTRAINT [FK__plans__degree__44FF419A] FOREIGN KEY([degree])
REFERENCES [dbo].[degree] ([degree_type])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__plans__degree__44FF419A]') AND parent_object_id = OBJECT_ID(N'[dbo].[plans]'))
ALTER TABLE [dbo].[plans] CHECK CONSTRAINT [FK__plans__degree__44FF419A]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__plans__departmen__45F365D3]') AND parent_object_id = OBJECT_ID(N'[dbo].[plans]'))
ALTER TABLE [dbo].[plans]  WITH CHECK ADD  CONSTRAINT [FK__plans__departmen__45F365D3] FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__plans__departmen__45F365D3]') AND parent_object_id = OBJECT_ID(N'[dbo].[plans]'))
ALTER TABLE [dbo].[plans] CHECK CONSTRAINT [FK__plans__departmen__45F365D3]
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
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__program__degree__49C3F6B7]') AND parent_object_id = OBJECT_ID(N'[dbo].[program]'))
ALTER TABLE [dbo].[program]  WITH CHECK ADD  CONSTRAINT [FK__program__degree__49C3F6B7] FOREIGN KEY([degree])
REFERENCES [dbo].[degree] ([degree_type])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__program__degree__49C3F6B7]') AND parent_object_id = OBJECT_ID(N'[dbo].[program]'))
ALTER TABLE [dbo].[program] CHECK CONSTRAINT [FK__program__degree__49C3F6B7]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__program__departm__4AB81AF0]') AND parent_object_id = OBJECT_ID(N'[dbo].[program]'))
ALTER TABLE [dbo].[program]  WITH CHECK ADD  CONSTRAINT [FK__program__departm__4AB81AF0] FOREIGN KEY([department])
REFERENCES [dbo].[department] ([name])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__program__departm__4AB81AF0]') AND parent_object_id = OBJECT_ID(N'[dbo].[program]'))
ALTER TABLE [dbo].[program] CHECK CONSTRAINT [FK__program__departm__4AB81AF0]
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
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_p__degre__5070F446]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_program]'))
ALTER TABLE [dbo].[student_program]  WITH CHECK ADD  CONSTRAINT [FK__student_p__degre__5070F446] FOREIGN KEY([degree])
REFERENCES [dbo].[degree] ([degree_type])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__student_p__degre__5070F446]') AND parent_object_id = OBJECT_ID(N'[dbo].[student_program]'))
ALTER TABLE [dbo].[student_program] CHECK CONSTRAINT [FK__student_p__degre__5070F446]
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
