USE [GAIMisc]
GO
/* DISABLED: __EFMigrationsHistory is created automatically by EF Core.
 * Including it here causes "table already exists" errors during migration.
 *
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 9/15/2025 4:39:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
END DISABLED */
/****** Object:  Table [dbo].[AcidCorrection]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AcidCorrection](
	[ac_id] [int] IDENTITY(1,1) NOT NULL,
	[PercentAcid] [float] NOT NULL,
	[AcidCorrection] [real] NULL,
 CONSTRAINT [PK_AcidCorrection] PRIMARY KEY CLUSTERED 
(
	[ac_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BrixChart]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BrixChart](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[RefractiveIndex] [float] NULL,
	[Brix] [real] NOT NULL,
	[SpecificGravity] [float] NULL,
	[LbPerGallon] [float] NULL,
	[PoundSolid] [float] NULL,
 CONSTRAINT [PK_BrixChart] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_allocate]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_allocate](
	[all_index] [int] IDENTITY(1,1) NOT NULL,
	[all_id] [numeric](18, 0) NOT NULL,
	[all_ordernum] [bigint] NOT NULL,
	[all_codenum] [nvarchar](50) NOT NULL,
	[all_userlot] [nvarchar](50) NOT NULL,
	[all_qty] [int] NULL,
	[all_pick] [int] NULL,
	[all_date] [datetime] NULL,
	[all_chr1] [nvarchar](50) NULL,
	[all_chr2] [nvarchar](50) NULL,
	[all_chr3] [nvarchar](50) NULL,
	[all_chx1] [nvarchar](max) NULL,
	[all_chx2] [nvarchar](max) NULL,
	[all_chx3] [nvarchar](max) NULL,
	[all_int1] [int] NULL,
	[all_int2] [int] NULL,
	[all_int3] [int] NULL,
	[all_num1] [numeric](18, 0) NULL,
	[all_num2] [numeric](18, 0) NULL,
	[all_num3] [numeric](18, 0) NULL,
	[all_date1] [datetime] NULL,
	[all_date2] [datetime] NULL,
	[all_date3] [datetime] NULL,
	[all_dec1] [decimal](18, 8) NULL,
	[all_description] [nvarchar](50) NULL,
	[all_um] [nvarchar](50) NULL,
	[all_chr4] [nvarchar](50) NULL,
	[all_chr5] [nvarchar](50) NULL,
	[all_chr6] [nvarchar](50) NULL,
	[all_chx4] [nvarchar](max) NULL,
	[all_chx5] [nvarchar](max) NULL,
	[all_chx6] [nvarchar](max) NULL,
	[all_int4] [int] NULL,
	[all_int5] [int] NULL,
	[all_int6] [int] NULL,
	[all_dec4] [decimal](18, 0) NULL,
	[all_dec5] [decimal](18, 0) NULL,
	[all_dec6] [decimal](18, 0) NULL,
	[all_date4] [datetime] NULL,
	[all_date5] [datetime] NULL,
	[all_date6] [datetime] NULL,
	[all_dec3] [decimal](18, 0) NULL,
	[all_nwt] [decimal](18, 0) NULL,
	[all_gwt] [decimal](18, 0) NULL,
	[all_status] [nvarchar](50) NULL,
	[all_carrier] [nvarchar](50) NULL,
	[all_notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_gai_allocate] PRIMARY KEY CLUSTERED 
(
	[all_index] ASC,
	[all_id] ASC,
	[all_ordernum] ASC,
	[all_codenum] ASC,
	[all_userlot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_allocateaudit]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_allocateaudit](
	[ala_index] [int] IDENTITY(1,1) NOT NULL,
	[ala_id] [int] NOT NULL,
	[ala_ordernum] [bigint] NOT NULL,
	[ala_status] [int] NOT NULL,
	[ala_codenum] [nvarchar](50) NOT NULL,
	[ala_userlot] [nvarchar](50) NOT NULL,
	[ala_cw] [numeric](18, 7) NULL,
	[ala_expdate] [datetime] NULL,
	[ala_mfgdate] [datetime] NULL,
	[ala_qtywarehouse] [int] NULL,
	[ala_qtyallocated] [int] NULL,
	[ala_qtyremain] [int] NULL,
	[ala_country] [nvarchar](max) NULL,
	[ala_location] [nvarchar](max) NULL,
	[ala_typewarning] [nvarchar](max) NULL,
	[ala_chr1] [nvarchar](50) NULL,
	[ala_chr2] [nvarchar](50) NULL,
	[ala_chr3] [nvarchar](50) NULL,
	[ala_chx1] [nvarchar](max) NULL,
	[ala_chx2] [nvarchar](max) NULL,
	[ala_chx3] [nvarchar](max) NULL,
	[ala_num1] [numeric](18, 0) NULL,
	[ala_num2] [numeric](18, 0) NULL,
	[ala_num3] [numeric](18, 0) NULL,
	[ala_dec1] [decimal](18, 7) NULL,
	[ala_dec2] [decimal](18, 7) NULL,
	[ala_dec3] [decimal](18, 7) NULL,
	[ala_date1] [datetime] NULL,
	[ala_date2] [datetime] NULL,
	[ala_date3] [datetime] NULL,
	[ala_img1] [image] NULL,
	[ala_img2] [image] NULL,
	[ala_img3] [image] NULL,
 CONSTRAINT [PK_gai_allocateaudit] PRIMARY KEY CLUSTERED 
(
	[ala_index] ASC,
	[ala_id] ASC,
	[ala_ordernum] ASC,
	[ala_status] ASC,
	[ala_codenum] ASC,
	[ala_userlot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_bol]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_bol](
	[bol_index] [int] IDENTITY(1,1) NOT NULL,
	[bol_id] [numeric](18, 0) NOT NULL,
	[bol_ordernum] [bigint] NOT NULL,
	[bol_appid] [nvarchar](50) NOT NULL,
	[bol_date] [datetime] NOT NULL,
	[bol_condition] [nvarchar](50) NULL,
	[bol_temp] [nvarchar](50) NULL,
	[bol_clean] [nvarchar](50) NULL,
	[bol_pests] [nvarchar](50) NULL,
	[bol_odors] [nvarchar](50) NULL,
	[bol_padlocked] [nvarchar](50) NULL,
	[bol_itype] [nvarchar](50) NULL,
	[bol_tnumber] [nvarchar](50) NULL,
	[bol_tnotes] [nvarchar](max) NULL,
	[bol_tcheckedby] [nvarchar](50) NULL,
	[bol_scheddd] [nvarchar](50) NULL,
	[bol_deliveryd] [nvarchar](50) NULL,
	[bol_pod] [nvarchar](50) NULL,
	[bol_problnumber] [nvarchar](50) NULL,
	[bol_appcontactph] [nvarchar](50) NULL,
	[bol_appcontactname] [nvarchar](50) NULL,
	[bol_pallets] [nvarchar](50) NULL,
	[bol_drivername] [nvarchar](50) NULL,
	[bol_last3prod] [nvarchar](50) NULL,
	[bol_wtype] [nvarchar](50) NULL,
	[bol_chr1] [nvarchar](50) NULL,
	[bol_chr2] [nvarchar](50) NULL,
	[bol_chr3] [nvarchar](50) NULL,
	[bol_chx1] [nvarchar](max) NULL,
	[bol_chx2] [nvarchar](max) NULL,
	[bol_chx3] [nvarchar](max) NULL,
	[bol_date1] [datetime] NULL,
	[bol_date2] [datetime] NULL,
	[bol_num1] [bigint] NULL,
	[bol_num2] [bigint] NULL,
	[bol_img1] [bit] NULL,
	[bol_img2] [bit] NULL,
	[bol_img3] [bit] NULL,
 CONSTRAINT [PK_gai_bol] PRIMARY KEY CLUSTERED 
(
	[bol_id] ASC,
	[bol_ordernum] ASC,
	[bol_appid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_bolapp]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_bolapp](
	[bol_index] [int] IDENTITY(1,1) NOT NULL,
	[bol_id] [numeric](18, 0) NOT NULL,
	[bol_appid] [nvarchar](50) NOT NULL,
	[bol_tb11] [nvarchar](50) NULL,
	[bol_tb31] [nvarchar](50) NULL,
	[bol_tb28] [nvarchar](50) NULL,
	[bol_tb29] [nvarchar](50) NULL,
	[bol_tb30] [nvarchar](50) NULL,
	[bol_tb14] [nvarchar](50) NULL,
	[bol_tb16] [nvarchar](50) NULL,
	[bol_tb17] [nvarchar](50) NULL,
	[bol_tb23] [nvarchar](50) NULL,
	[bol_tb24] [nvarchar](50) NULL,
	[bol_tb25] [nvarchar](50) NULL,
	[bol_tb26] [nvarchar](50) NULL,
	[bol_tb27] [nvarchar](50) NULL,
	[bol_tb19] [nvarchar](50) NULL,
	[bol_tb20] [nvarchar](50) NULL,
	[bol_tb35] [nvarchar](50) NULL,
	[bol_tb32] [nvarchar](50) NULL,
	[bol_tb34] [nvarchar](50) NULL,
	[bol_tb36] [nvarchar](50) NULL,
	[bol_chr1] [nvarchar](50) NULL,
	[bol_chr2] [nvarchar](50) NULL,
	[bol_chr3] [nvarchar](50) NULL,
	[bol_chx1] [nvarchar](max) NULL,
	[bol_chx2] [nvarchar](max) NULL,
	[bol_chx3] [nvarchar](max) NULL,
	[bol_img1] [varbinary](max) NULL,
	[bol_img2] [varbinary](max) NULL,
	[bol_img3] [varbinary](max) NULL,
	[bol_img4] [varbinary](max) NULL,
	[bol_img5] [varbinary](max) NULL,
 CONSTRAINT [PK_gai.bolapp] PRIMARY KEY CLUSTERED 
(
	[bol_index] ASC,
	[bol_id] ASC,
	[bol_appid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_boldetail]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_boldetail](
	[gb_bol] [bigint] NULL,
	[gb_npcs] [decimal](18, 0) NULL,
	[gb_container] [nvarchar](50) NULL,
	[gb_codenum] [nvarchar](50) NULL,
	[gb_description] [nvarchar](50) NULL,
	[gb_netw] [decimal](18, 0) NULL,
	[gb_grossw] [decimal](18, 0) NULL,
	[gb_class] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_bolheader]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_bolheader](
	[gb_bol] [bigint] NULL,
	[gb_carrierno] [int] NULL,
	[gb_pono] [nvarchar](50) NULL,
	[gb_carrier] [nvarchar](50) NULL,
	[gb_at] [nvarchar](50) NULL,
	[gb_at1] [nvarchar](50) NULL,
	[gb_from1] [nvarchar](50) NULL,
	[gb_consigned] [nvarchar](50) NULL,
	[gb_destination] [nvarchar](50) NULL,
	[gb_tpc] [int] NULL,
	[gb_twl] [decimal](18, 0) NULL,
	[gb_freight1] [nvarchar](50) NULL,
	[gb_type1] [nvarchar](50) NULL,
	[gb_loadedby] [nvarchar](50) NULL,
	[gb_palletsin] [int] NULL,
	[gb_freepest] [nchar](10) NULL,
	[gb_trailerclean] [nchar](10) NULL,
	[gb_trailerintact] [nchar](10) NULL,
	[gb_sealno] [nchar](10) NULL,
	[gb_temp1] [nchar](10) NULL,
	[gb_palletsout] [int] NULL,
	[gb_acceptableodor] [nchar](10) NULL,
	[gb_padlocker] [nchar](10) NULL,
	[gb_approvedby] [nvarchar](50) NULL,
	[gb_temp2] [nchar](10) NULL,
	[gb_initials] [nchar](10) NULL,
	[gb_notes] [nvarchar](50) NULL,
	[gb_shipper] [nvarchar](50) NULL,
	[gb_agent] [nvarchar](50) NULL,
	[gb_postoffice] [nvarchar](50) NULL,
	[gb_chr1] [nvarchar](50) NULL,
	[gb_chr2] [nvarchar](50) NULL,
	[gb_chr3] [nvarchar](50) NULL,
	[gb_chr4] [nvarchar](50) NULL,
	[gb_chr5] [nvarchar](50) NULL,
	[gb_num1] [int] NULL,
	[gb_num2] [int] NULL,
	[gb_num3] [int] NULL,
	[gb_dec1] [decimal](18, 0) NULL,
	[gb_dec2] [decimal](18, 0) NULL,
	[gb_dec3] [decimal](18, 0) NULL,
	[gb_scac] [nvarchar](50) NULL,
	[gb_delcarrier] [nvarchar](50) NULL,
	[gb_carvei] [nvarchar](50) NULL,
	[gb_carvein] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_combob]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_combob](
	[cb_index] [int] IDENTITY(1,1) NOT NULL,
	[cb_type] [int] NOT NULL,
	[cb_ulogin] [nvarchar](50) NOT NULL,
	[cb_chr1] [nvarchar](50) NULL,
	[cb_chr2] [nvarchar](50) NULL,
	[cb_chr3] [nvarchar](50) NULL,
	[cb_chx1] [nvarchar](max) NULL,
	[cb_chx2] [nvarchar](max) NULL,
	[cb_int1] [int] NULL,
	[cb_int2] [int] NULL,
	[cb_int3] [int] NULL,
	[cb_date1] [datetime] NULL,
	[cb_date2] [datetime] NULL,
	[cb_date3] [datetime] NULL,
 CONSTRAINT [PK_gai_combob] PRIMARY KEY CLUSTERED 
(
	[cb_index] ASC,
	[cb_type] ASC,
	[cb_ulogin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_dmstech]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_dmstech](
	[gs_index] [int] IDENTITY(1,1) NOT NULL,
	[gs_id] [numeric](18, 0) NOT NULL,
	[gs_type] [int] NOT NULL,
	[gs_chr1] [nvarchar](50) NOT NULL,
	[gs_chr2] [nvarchar](50) NULL,
	[gs_chr3] [nvarchar](50) NULL,
	[gs_chr4] [nvarchar](50) NULL,
	[gs_chr5] [nvarchar](50) NULL,
	[gs_chx1] [nvarchar](max) NULL,
	[gs_chx2] [nvarchar](50) NULL,
	[gs_chx3] [nvarchar](50) NULL,
	[gs_int1] [int] NULL,
	[gs_int2] [int] NULL,
	[gs_int3] [int] NULL,
	[gs_date1] [datetime] NULL,
	[gs_date2] [datetime] NULL,
	[gs_date3] [datetime] NULL,
	[gs_consignor_sig] [varbinary](max) NULL,
	[gs_driver_sig] [varbinary](max) NULL,
	[gs_security2] [nvarchar](50) NULL,
 CONSTRAINT [PK_gai_dmstech] PRIMARY KEY CLUSTERED 
(
	[gs_index] ASC,
	[gs_id] ASC,
	[gs_type] ASC,
	[gs_chr1] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_lock]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_lock](
	[gl_index] [int] IDENTITY(1,1) NOT NULL,
	[gl_id] [int] NOT NULL,
	[gl_ordnum] [bigint] NOT NULL,
	[gl_partnum] [nvarchar](50) NOT NULL,
	[gl_userlot] [nvarchar](50) NOT NULL,
	[gl_username] [nvarchar](50) NULL,
	[gl_qty1] [int] NULL,
	[gl_qty2] [int] NULL,
	[gl_qty3] [int] NULL,
	[gl_datel] [datetime] NULL,
	[gl_date1] [datetime] NULL,
	[gl_date2] [datetime] NULL,
	[gl_notes1] [nvarchar](max) NULL,
	[gl_notes2] [nvarchar](max) NULL,
	[gl_chr1] [nvarchar](50) NULL,
	[gl_chr2] [nvarchar](50) NULL,
	[gl_chx1] [nvarchar](max) NULL,
	[gl_chx2] [nvarchar](max) NULL,
	[gl_int1] [int] NULL,
	[gl_int2] [int] NULL,
	[gl_dec1] [decimal](18, 0) NULL,
	[gl_dec2] [decimal](18, 0) NULL,
	[gl_date3] [datetime] NULL,
	[gl_date4] [datetime] NULL,
 CONSTRAINT [PK_gai_lock] PRIMARY KEY CLUSTERED 
(
	[gl_index] ASC,
	[gl_id] ASC,
	[gl_ordnum] ASC,
	[gl_partnum] ASC,
	[gl_userlot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_paway]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_paway](
	[gp_index] [int] IDENTITY(1,1) NOT NULL,
	[gp_id] [int] NOT NULL,
	[gp_ordnum] [bigint] NOT NULL,
	[gp_codenum] [nvarchar](50) NOT NULL,
	[gp_userlot] [nvarchar](50) NOT NULL,
	[gp_qty] [int] NULL,
	[gp_qty1] [int] NULL,
	[gp_qty2] [int] NULL,
	[gp_qty3] [int] NULL,
	[gp_lo] [nvarchar](50) NULL,
	[gp_lo1] [nvarchar](50) NULL,
	[gp_lo2] [nvarchar](50) NULL,
	[gp_lo3] [nvarchar](50) NULL,
	[gp_datep] [datetime] NULL,
	[gp_date1] [datetime] NULL,
	[gp_date2] [datetime] NULL,
	[gp_date3] [datetime] NULL,
	[gp_chr1] [nvarchar](50) NULL,
	[gp_chr2] [nvarchar](50) NULL,
	[gp_chr3] [nvarchar](50) NULL,
	[gp_int1] [int] NULL,
	[gp_int2] [int] NULL,
	[gp_int3] [int] NULL,
	[gp_dec1] [decimal](18, 0) NULL,
	[gp_dec2] [decimal](18, 0) NULL,
	[gp_dec3] [decimal](18, 0) NULL,
	[gp_chx1] [nvarchar](max) NULL,
	[gp_chx2] [nvarchar](max) NULL,
	[gp_chx3] [nvarchar](max) NULL,
	[gp_ima1] [image] NULL,
	[gp_ima2] [image] NULL,
	[gp_ima3] [image] NULL,
 CONSTRAINT [PK_paway] PRIMARY KEY CLUSTERED 
(
	[gp_index] ASC,
	[gp_id] ASC,
	[gp_ordnum] ASC,
	[gp_codenum] ASC,
	[gp_userlot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_putaway]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_putaway](
	[gp_id] [int] IDENTITY(1,1) NOT NULL,
	[gp_type] [nvarchar](20) NULL,
	[gp_orderid] [numeric](15, 0) NULL,
	[gp_prcodenum] [nvarchar](30) NULL,
	[gp_loid] [int] NULL,
	[gp_userlot] [nvarchar](60) NULL,
	[gp_masterlot] [int] NULL,
	[gp_quant] [int] NULL,
 CONSTRAINT [PK_gai_putaway] PRIMARY KEY CLUSTERED 
(
	[gp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_rddetail]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_rddetail](
	[rdd_id] [int] IDENTITY(1,1) NOT NULL,
	[rdd_rdhid] [int] NULL,
	[rdd_ingname] [nvarchar](60) NULL,
	[rdd_code] [nvarchar](30) NULL,
	[rdd_formulapct] [numeric](18, 4) NULL,
	[rdd_ingredienttype] [nvarchar](30) NULL,
	[rdd_supplierlotinfo] [nvarchar](60) NULL,
	[rdd_chemstate] [nvarchar](10) NULL,
	[rdd_density] [numeric](18, 5) NULL,
	[rdd_abvpercent] [numeric](18, 1) NULL,
	[rdd_juicename] [nvarchar](60) NULL,
	[rdd_brix] [numeric](18, 1) NULL,
	[rdd_rmc] [numeric](18, 3) NULL,
 CONSTRAINT [PK_gai_rddetail] PRIMARY KEY CLUSTERED 
(
	[rdd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_rdheader]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_rdheader](
	[rdh_id] [int] IDENTITY(1,1) NOT NULL,
	[rdh_formulaname] [nvarchar](100) NULL,
	[rdh_code] [nvarchar](30) NULL,
	[rdh_datecreated] [datetime2](7) NULL,
	[rdh_version] [int] NULL,
	[rdh_productyield] [numeric](18, 1) NULL,
	[rdh_targetabv] [numeric](18, 1) NULL,
	[rdh_targetco2] [numeric](18, 1) NULL,
	[rdh_targetta] [numeric](18, 2) NULL,
	[rdh_targetph] [numeric](18, 2) NULL,
	[rdh_targetdensity] [numeric](18, 5) NULL,
	[rdh_processinginstr] [nvarchar](max) NULL,
	[rdh_targetbrix] [numeric](18, 1) NULL,
	[rdh_waterdensity] [numeric](18, 5) NULL,
	[rdh_productdensity] [numeric](18, 5) NULL,
	[rdh_solutionprocessinstr] [nvarchar](max) NULL,
 CONSTRAINT [PK_gai_rdheader] PRIMARY KEY CLUSTERED 
(
	[rdh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_ReservedLocations]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_ReservedLocations](
	[gr_id] [int] IDENTITY(1,1) NOT NULL,
	[gr_loid] [int] NULL,
	[gr_orderid] [numeric](15, 0) NULL,
	[gr_resdate] [datetime2](7) NULL,
	[gr_restime] [datetime2](7) NULL,
 CONSTRAINT [PK_gai_ReservedLocations] PRIMARY KEY CLUSTERED 
(
	[gr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_scheduler]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_scheduler](
	[gs_index] [int] IDENTITY(1,1) NOT NULL,
	[gs_id] [numeric](18, 0) NOT NULL,
	[gs_ordnum] [bigint] NOT NULL,
	[gs_dock] [nchar](10) NULL,
	[gs_datestart] [datetime] NULL,
	[gs_dateend] [datetime] NULL,
	[gs_dockm] [time](7) NULL,
	[gs_company] [nvarchar](50) NULL,
	[gs_carrier] [nvarchar](50) NULL,
	[gs_driver] [nvarchar](50) NULL,
	[gs_notes] [nvarchar](200) NULL,
	[gs_datechkin] [datetime] NULL,
	[gs_status] [nvarchar](50) NULL,
	[gs_appid] [nvarchar](50) NOT NULL,
	[gs_forkop] [nvarchar](max) NULL,
	[gs_chr1] [nvarchar](50) NULL,
	[gs_chr2] [nvarchar](50) NULL,
	[gs_chr3] [nvarchar](50) NULL,
	[gs_num1] [bigint] NULL,
	[gs_num2] [bigint] NULL,
	[gs_num3] [bigint] NULL,
	[gs_dec1] [decimal](18, 0) NULL,
	[gs_dec2] [decimal](18, 0) NULL,
	[gs_dec3] [decimal](18, 0) NULL,
	[gs_log1] [bit] NULL,
	[gs_log2] [bit] NULL,
	[gs_log3] [bit] NULL,
	[gs_img1] [image] NULL,
	[gs_img2] [image] NULL,
	[gs_img3] [image] NULL,
	[gs_date1] [datetime] NULL,
	[gs_date2] [datetime] NULL,
	[gs_date3] [datetime] NULL,
	[gs_picker] [nvarchar](50) NULL,
	[gs_pickerout] [datetime] NULL,
	[gs_pickerin] [datetime] NULL,
	[gs_auditor] [nvarchar](50) NULL,
	[gs_auditorout] [datetime] NULL,
	[gs_auditorin] [datetime] NULL,
	[gs_assembler] [nvarchar](50) NULL,
	[gs_assemblerout] [datetime] NULL,
	[gs_assemblerin] [datetime] NULL,
	[gs_chr4] [nvarchar](50) NULL,
	[gs_chr5] [nvarchar](50) NULL,
	[gs_chr6] [nvarchar](50) NULL,
	[gs_num4] [bigint] NULL,
	[gs_num5] [bigint] NULL,
	[gs_num6] [bigint] NULL,
	[gs_dec4] [decimal](18, 0) NULL,
	[gs_dec5] [decimal](18, 0) NULL,
	[gs_dec6] [bigint] NULL,
	[gs_log4] [bit] NULL,
	[gs_log5] [bit] NULL,
	[gs_log6] [bit] NULL,
	[gs_img4] [image] NULL,
	[gs_img5] [image] NULL,
	[gs_img6] [image] NULL,
	[gs_date4] [datetime] NULL,
	[gs_date5] [datetime] NULL,
	[gs_date6] [datetime] NULL,
	[gs_pronum] [int] NULL,
	[gs_pallets] [int] NULL,
	[gs_nwt] [decimal](18, 0) NULL,
	[gs_gwt] [decimal](18, 0) NULL,
	[gs_notesict] [nvarchar](max) NULL,
 CONSTRAINT [PK_Ordnum_appid] PRIMARY KEY CLUSTERED 
(
	[gs_index] ASC,
	[gs_id] ASC,
	[gs_ordnum] ASC,
	[gs_appid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_scheduler_old]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_scheduler_old](
	[gs_id] [numeric](18, 0) NOT NULL,
	[gs_ordnum] [bigint] NOT NULL,
	[gs_dock] [nchar](10) NULL,
	[gs_datestart] [datetime] NULL,
	[gs_dateend] [datetime] NULL,
	[gs_dockm] [time](7) NULL,
	[gs_company] [nvarchar](50) NULL,
	[gs_carrier] [nvarchar](50) NULL,
	[gs_driver] [nvarchar](50) NULL,
	[gs_notes] [nvarchar](50) NULL,
	[gs_datechkin] [datetime] NULL,
	[gs_status] [nvarchar](50) NULL,
	[gs_appid] [nvarchar](50) NULL,
	[gs_forkop] [nvarchar](max) NULL,
	[gs_chr1] [nvarchar](50) NULL,
	[gs_chr2] [nvarchar](50) NULL,
	[gs_chr3] [nvarchar](50) NULL,
	[gs_num1] [bigint] NULL,
	[gs_num2] [bigint] NULL,
	[gs_num3] [bigint] NULL,
	[gs_dec1] [decimal](18, 0) NULL,
	[gs_dec2] [decimal](18, 0) NULL,
	[gs_dec3] [decimal](18, 0) NULL,
	[gs_log1] [bit] NULL,
	[gs_log2] [bit] NULL,
	[gs_log3] [bit] NULL,
	[gs_img1] [image] NULL,
	[gs_img2] [image] NULL,
	[gs_img3] [image] NULL,
	[gs_date1] [datetime] NULL,
	[gs_date2] [datetime] NULL,
	[gs_date3] [datetime] NULL,
	[gs_picker] [nvarchar](50) NULL,
	[gs_pickerout] [datetime] NULL,
	[gs_pickerin] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_scheduler_tmp]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_scheduler_tmp](
	[gs_index] [int] IDENTITY(1,1) NOT NULL,
	[gs_id] [numeric](18, 0) NOT NULL,
	[gs_ordnum] [bigint] NOT NULL,
	[gs_dock] [nchar](10) NULL,
	[gs_datestart] [datetime] NULL,
	[gs_dateend] [datetime] NULL,
	[gs_dockm] [time](7) NULL,
	[gs_company] [nvarchar](50) NULL,
	[gs_carrier] [nvarchar](50) NULL,
	[gs_driver] [nvarchar](50) NULL,
	[gs_notes] [nvarchar](200) NULL,
	[gs_datechkin] [datetime] NULL,
	[gs_status] [nvarchar](50) NULL,
	[gs_appid] [nvarchar](50) NOT NULL,
	[gs_forkop] [nvarchar](max) NULL,
	[gs_chr1] [nvarchar](50) NULL,
	[gs_chr2] [nvarchar](50) NULL,
	[gs_chr3] [nvarchar](50) NULL,
	[gs_num1] [bigint] NULL,
	[gs_num2] [bigint] NULL,
	[gs_num3] [bigint] NULL,
	[gs_dec1] [decimal](18, 0) NULL,
	[gs_dec2] [decimal](18, 0) NULL,
	[gs_dec3] [decimal](18, 0) NULL,
	[gs_log1] [bit] NULL,
	[gs_log2] [bit] NULL,
	[gs_log3] [bit] NULL,
	[gs_img1] [image] NULL,
	[gs_img2] [image] NULL,
	[gs_img3] [image] NULL,
	[gs_date1] [datetime] NULL,
	[gs_date2] [datetime] NULL,
	[gs_date3] [datetime] NULL,
	[gs_picker] [nvarchar](50) NULL,
	[gs_pickerout] [datetime] NULL,
	[gs_pickerin] [datetime] NULL,
	[gs_auditor] [nvarchar](50) NULL,
	[gs_auditorout] [datetime] NULL,
	[gs_auditorin] [datetime] NULL,
	[gs_assembler] [nvarchar](50) NULL,
	[gs_assemblerout] [datetime] NULL,
	[gs_assemblerin] [datetime] NULL,
	[gs_chr4] [nvarchar](50) NULL,
	[gs_chr5] [nvarchar](50) NULL,
	[gs_chr6] [nvarchar](50) NULL,
	[gs_num4] [bigint] NULL,
	[gs_num5] [bigint] NULL,
	[gs_num6] [bigint] NULL,
	[gs_dec4] [decimal](18, 0) NULL,
	[gs_dec5] [decimal](18, 0) NULL,
	[gs_dec6] [bigint] NULL,
	[gs_log4] [bit] NULL,
	[gs_log5] [bit] NULL,
	[gs_log6] [bit] NULL,
	[gs_img4] [image] NULL,
	[gs_img5] [image] NULL,
	[gs_img6] [image] NULL,
	[gs_date4] [datetime] NULL,
	[gs_date5] [datetime] NULL,
	[gs_date6] [datetime] NULL,
	[gs_pronum] [int] NULL,
	[gs_pallets] [int] NULL,
	[gs_nwt] [decimal](18, 0) NULL,
	[gs_gwt] [decimal](18, 0) NULL,
	[gs_notesict] [nvarchar](max) NULL,
	[gs_stagloc] [nvarchar](max) NULL,
 CONSTRAINT [PK_Ordnum_appid_tmp] PRIMARY KEY CLUSTERED
(
	[gs_index] ASC,
	[gs_id] ASC,
	[gs_ordnum] ASC,
	[gs_appid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_shipping_rate]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_shipping_rate](
	[sr_id] [int] IDENTITY(1,1) NOT NULL,
	[sr_source] [nvarchar](50) NULL,
	[sr_destination] [nvarchar](50) NULL,
	[sr_rate] [money] NULL,
	[sr_startdate] [datetime2](7) NULL,
	[sr_enddate] [datetime2](7) NULL,
 CONSTRAINT [PK_gai_shipping_rate] PRIMARY KEY CLUSTERED 
(
	[sr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_singlestrengthconversions]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_singlestrengthconversions](
	[ssc_id] [int] IDENTITY(1,1) NOT NULL,
	[ssc_Fruit] [varchar](50) NULL,
	[ssc_BrixAtSingleStrength] [varchar](50) NULL,
	[ssc_Ref] [varchar](50) NULL,
 CONSTRAINT [PK_gai_singlestrengthconversions_new] PRIMARY KEY CLUSTERED 
(
	[ssc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_singlestrengthconversions_old]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_singlestrengthconversions_old](
	[Fruit] [varchar](50) NULL,
	[BrixAtSingleStrength] [varchar](50) NULL,
	[Ref] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_sr_destinations]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_sr_destinations](
	[sd_id] [int] IDENTITY(1,1) NOT NULL,
	[sd_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_gai_sr_destinations] PRIMARY KEY CLUSTERED 
(
	[sd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_sr_sources]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_sr_sources](
	[sc_id] [int] IDENTITY(1,1) NOT NULL,
	[sc_name] [nvarchar](50) NULL,
 CONSTRAINT [PK_gai_sr_sources] PRIMARY KEY CLUSTERED 
(
	[sc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gai_syslogs]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gai_syslogs](
	[gs_index] [int] IDENTITY(1,1) NOT NULL,
	[gs_id] [numeric](18, 0) NOT NULL,
	[gs_sys] [nchar](10) NOT NULL,
	[gs_user] [nvarchar](50) NOT NULL,
	[gs_in] [datetime] NOT NULL,
	[gs_out] [datetime] NULL,
 CONSTRAINT [PK_gai_syslogs] PRIMARY KEY CLUSTERED 
(
	[gs_id] ASC,
	[gs_sys] ASC,
	[gs_user] ASC,
	[gs_in] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gp_f011head]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gp_f011head](
	[gf_index] [int] IDENTITY(1,1) NOT NULL,
	[gf_id] [decimal](18, 0) NOT NULL,
	[gf_jobnum] [bigint] NOT NULL,
	[gf_fdate] [datetime] NOT NULL,
	[gf_1s] [nvarchar](50) NULL,
	[gf_1sdate] [datetime] NULL,
	[gf_2s] [nvarchar](50) NULL,
	[gf_2sdate] [datetime] NULL,
	[gf_oper] [nvarchar](50) NULL,
	[gf_chr1] [nvarchar](50) NULL,
	[gf_chr2] [nvarchar](50) NULL,
	[gf_chx1] [nvarchar](max) NULL,
	[gf_chx2] [nvarchar](max) NULL,
	[gf_date1] [datetime] NULL,
	[gf_date2] [datetime] NULL,
	[gf_dec1] [decimal](18, 0) NULL,
	[gf_dec2] [decimal](18, 0) NULL,
	[gf_int1] [int] NULL,
	[gf_int2] [int] NULL,
	[gf_ima1] [image] NULL,
	[gf_ima2] [image] NULL,
 CONSTRAINT [PK_gp_f011head] PRIMARY KEY CLUSTERED 
(
	[gf_id] ASC,
	[gf_jobnum] ASC,
	[gf_fdate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gp_prodrep]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gp_prodrep](
	[gf_index] [int] IDENTITY(1,1) NOT NULL,
	[gf_id] [decimal](18, 0) NOT NULL,
	[gf_form] [int] NOT NULL,
	[gf_sec] [int] NOT NULL,
	[gf_jobdate] [datetime] NOT NULL,
	[gf_jobnum] [bigint] NOT NULL,
	[gf_f1] [nvarchar](50) NULL,
	[gf_f2] [nvarchar](50) NULL,
	[gf_f3] [nvarchar](50) NULL,
	[gf_f4] [nvarchar](50) NULL,
	[gf_f5] [nvarchar](50) NULL,
	[gf_f6] [nvarchar](50) NULL,
	[gf_f7] [nvarchar](50) NULL,
	[gf_f8] [nvarchar](50) NULL,
	[gf_f9] [nvarchar](50) NULL,
	[gf_f10] [nchar](10) NULL,
	[gf_chr1] [nvarchar](50) NULL,
	[gf_chr2] [nvarchar](50) NULL,
	[gf_chr3] [nvarchar](50) NULL,
	[gf_chx1] [nvarchar](max) NULL,
	[gf_chx2] [nvarchar](max) NULL,
	[gf_chx3] [nvarchar](max) NULL,
	[gf_int1] [int] NULL,
	[gf_int2] [int] NULL,
	[gf_int3] [int] NULL,
	[gf_date1] [datetime] NULL,
	[gf_date2] [datetime] NULL,
	[gf_date3] [datetime] NULL,
	[gf_ima1] [image] NULL,
	[gf_ima2] [image] NULL,
	[gf_ima3] [image] NULL,
 CONSTRAINT [PK_gp_prodrep] PRIMARY KEY CLUSTERED 
(
	[gf_index] ASC,
	[gf_id] ASC,
	[gf_form] ASC,
	[gf_sec] ASC,
	[gf_jobdate] ASC,
	[gf_jobnum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gp_scheduler]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gp_scheduler](
	[gp_index] [int] NOT NULL,
	[gp_id] [numeric](18, 0) NOT NULL,
	[gp_startdate] [datetime] NULL,
	[gp_enddate] [datetime] NULL,
	[gp_jobnum] [bigint] NOT NULL,
	[gp_filling] [decimal](18, 0) NULL,
	[gp_jobqty] [decimal](18, 0) NULL,
	[gp_unit] [nvarchar](50) NULL,
	[gp_pounds] [decimal](18, 0) NULL,
	[gp_spec] [nvarchar](50) NULL,
	[gp_product] [nvarchar](50) NULL,
	[gp_notes] [nvarchar](50) NULL,
	[gp_remarks] [nvarchar](max) NULL,
	[gp_backc] [nvarchar](50) NULL,
	[gp_forec] [nvarchar](50) NULL,
	[gp_chr1] [nvarchar](50) NULL,
	[gp_chr2] [nvarchar](50) NULL,
	[gp_chr3] [nvarchar](50) NULL,
	[gp_chx1] [nvarchar](max) NULL,
	[gp_chx2] [nvarchar](max) NULL,
	[gp_chx3] [nvarchar](max) NULL,
	[gp_dec1] [decimal](18, 0) NULL,
	[gp_dec2] [decimal](18, 0) NULL,
	[gp_dec3] [decimal](18, 0) NULL,
	[gp_num1] [numeric](18, 0) NULL,
	[gp_num2] [numeric](18, 0) NULL,
	[gp_num3] [numeric](18, 0) NULL,
	[gp_date1] [datetime] NULL,
	[gp_date2] [datetime] NULL,
	[gp_date3] [datetime] NULL,
	[gp_log1] [bit] NULL,
	[gp_log2] [bit] NULL,
	[gp_log3] [bit] NULL,
	[gp_image1] [image] NULL,
	[gp_image2] [image] NULL,
	[gp_image3] [image] NULL,
 CONSTRAINT [PK_gp_scheduler] PRIMARY KEY CLUSTERED 
(
	[gp_jobnum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gw_prefixes]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gw_prefixes](
	[pf_id] [int] IDENTITY(1,1) NOT NULL,
	[pf_udfid] [int] NULL,
	[pf_veid] [int] NULL,
	[pf_prefix] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[pf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[liberation_tariff]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[liberation_tariff](
	[Country_ID] [nchar](10) NOT NULL,
	[Country_name] [nvarchar](max) NOT NULL,
	[Country_code] [nvarchar](50) NOT NULL,
	[Country_Group] [nvarchar](50) NULL,
	[Liberation_tariff] [decimal](18, 0) NOT NULL,
	[Effective_Date] [date] NULL,
	[New_liberation] [decimal](18, 0) NULL,
 CONSTRAINT [PK_liberation_tariff] PRIMARY KEY CLUSTERED 
(
	[Country_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shipping_Rate]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipping_Rate](
	[sr_id] [int] IDENTITY(1,1) NOT NULL,
	[sr_source] [nvarchar](max) NOT NULL,
	[sr_destination] [nvarchar](max) NOT NULL,
	[sr_rate] [float] NOT NULL,
	[sr_startdate] [datetime2](7) NOT NULL,
	[sr_enddate] [datetime2](7) NULL,
 CONSTRAINT [PK_Shipping_Rates] PRIMARY KEY CLUSTERED 
(
	[sr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USDABrandedFood2]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USDABrandedFood2](
	[fdc_id] [float] NULL,
	[brand_owner] [nvarchar](255) NULL,
	[brand_name] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[subbrand_name] [nvarchar](255) NULL,
	[gtin_upc] [float] NULL,
	[ingredients] [nvarchar](max) NULL,
	[branded_food_category] [nvarchar](255) NULL,
	[food_category_id] [nvarchar](255) NULL,
	[publication_date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USDABrandedFoodIngredients]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USDABrandedFoodIngredients](
	[fdc_id] [float] NULL,
	[brand_owner] [nvarchar](255) NULL,
	[brand_name] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[subbrand_name] [nvarchar](255) NULL,
	[gtin_upc] [float] NULL,
	[ingredient] [nvarchar](max) NULL,
	[branded_food_category] [nvarchar](255) NULL,
	[food_category_id] [nvarchar](255) NULL,
	[publication_date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USDABrandedFoods]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USDABrandedFoods](
	[fdc_id] [float] NULL,
	[brand_owner] [nvarchar](255) NULL,
	[brand_name] [nvarchar](255) NULL,
	[description] [nvarchar](255) NULL,
	[subbrand_name] [nvarchar](255) NULL,
	[gtin_upc] [float] NULL,
	[ingredients] [ntext] NULL,
	[branded_food_category] [nvarchar](255) NULL,
	[food_category_id] [nvarchar](255) NULL,
	[publication_date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[acuity_appointments]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acuity_appointments](
	[id] [bigint] NOT NULL,
	[firstName] [nvarchar](100) NOT NULL,
	[lastName] [nvarchar](100) NOT NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](255) NULL,
	[date] [nvarchar](50) NULL,
	[time] [nvarchar](20) NULL,
	[endTime] [nvarchar](20) NULL,
	[dateCreated] [nvarchar](50) NULL,
	[datetimeCreated] [datetime2] NULL,
	[datetime] [datetime2] NULL,
	[price] [decimal](10,2) NOT NULL DEFAULT 0.00,
	[priceSold] [decimal](10,2) NOT NULL DEFAULT 0.00,
	[paid] [nvarchar](10) NULL,
	[amountPaid] [decimal](10,2) NOT NULL DEFAULT 0.00,
	[type] [nvarchar](100) NULL,
	[appointmentTypeID] [int] NULL,
	[classID] [int] NULL,
	[category] [nvarchar](100) NULL,
	[duration] [int] NULL,
	[calendar] [nvarchar](100) NULL,
	[calendarID] [int] NULL,
	[certificate] [nvarchar](500) NULL,
	[confirmationPage] [nvarchar](1000) NULL,
	[confirmationPagePaymentLink] [nvarchar](1000) NULL,
	[location] [nvarchar](255) NULL,
	[notes] [ntext] NULL,
	[timezone] [nvarchar](50) NULL,
	[calendarTimezone] [nvarchar](50) NULL,
	[canceled] [bit] NOT NULL DEFAULT 0,
	[canClientCancel] [bit] NOT NULL DEFAULT 0,
	[canClientReschedule] [bit] NOT NULL DEFAULT 0,
	[labels] [nvarchar](500) NULL,
	[formsText] [ntext] NULL,
	[created_at] [datetime2] NOT NULL DEFAULT GETDATE(),
	[updated_at] [datetime2] NOT NULL DEFAULT GETDATE(),
 CONSTRAINT [PK_acuity_appointments] PRIMARY KEY CLUSTERED ([id] ASC)
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/* DISABLED: acuity_forms and acuity_form_values use composite primary/foreign keys
 * which are not supported by the DDL parser. See GitHub issue for enhancement.
 * Re-enable after DDL parser supports composite keys.
 *
/****** Object:  Table [dbo].[acuity_forms]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acuity_forms](
	[id] [bigint] NOT NULL,
	[appointment_id] [bigint] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[created_at] [datetime2] NOT NULL DEFAULT GETDATE(),
	[updated_at] [datetime2] NOT NULL DEFAULT GETDATE(),
 CONSTRAINT [PK_acuity_forms] PRIMARY KEY CLUSTERED ([id] ASC, [appointment_id] ASC),
 CONSTRAINT [FK_acuity_forms_appointments] FOREIGN KEY ([appointment_id])
	REFERENCES [dbo].[acuity_appointments] ([id]) ON DELETE CASCADE
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[acuity_form_values]    Script Date: 9/15/2025 4:39:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[acuity_form_values](
	[id] [bigint] NOT NULL,
	[form_id] [bigint] NOT NULL,
	[appointment_id] [bigint] NOT NULL,
	[fieldID] [bigint] NOT NULL,
	[value] [ntext] NULL,
	[name] [nvarchar](500) NOT NULL,
	[created_at] [datetime2] NOT NULL DEFAULT GETDATE(),
	[updated_at] [datetime2] NOT NULL DEFAULT GETDATE(),
 CONSTRAINT [PK_acuity_form_values] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_acuity_form_values_forms] FOREIGN KEY ([form_id], [appointment_id])
	REFERENCES [dbo].[acuity_forms] ([id], [appointment_id]) ON DELETE CASCADE,
 CONSTRAINT [FK_acuity_form_values_appointments] FOREIGN KEY ([appointment_id])
	REFERENCES [dbo].[acuity_appointments] ([id]) ON DELETE NO ACTION
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
END DISABLED */
