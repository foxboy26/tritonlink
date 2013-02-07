USE [tritonlink]
GO
/****** Object:  Table [dbo].[student]    Script Date: 2013/2/7 11:03:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[student]') AND type in (N'U'))
DROP TABLE [dbo].[student]
GO
USE [master]
GO
/****** Object:  Database [tritonlink]    Script Date: 2013/2/7 11:03:58 ******/
IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'tritonlink')
DROP DATABASE [tritonlink]
GO
/****** Object:  Database [tritonlink]    Script Date: 2013/2/7 11:03:58 ******/
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
/****** Object:  Table [dbo].[student]    Script Date: 2013/2/7 11:03:58 ******/
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
	[ssn] [int] NOT NULL,
	[residency] [varchar](50) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[student] ([student_id], [firstname], [middlename], [lastname], [ssn], [residency]) VALUES (53025734, N'Zhiheng', N'', N'Li', 1234, N'Non-us')
USE [master]
GO
ALTER DATABASE [tritonlink] SET  READ_WRITE 
GO
