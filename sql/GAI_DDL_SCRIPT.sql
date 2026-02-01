USE [GAI]
GO
/****** Object:  Table [dbo].[dcbom2]    Script Date: 6/30/2025 12:49:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dcbom2](
	[bc_id] [int] IDENTITY(1,1) NOT NULL,
	[bc_group] [int] NOT NULL,
	[bc_ljid] [int] NOT NULL,
	[bc_orid] [int] NOT NULL,
 CONSTRAINT [PK_dcbom2] PRIMARY KEY CLUSTERED 
(
	[bc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dccash]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dccash](
	[ca_group] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dccash] PRIMARY KEY CLUSTERED 
(
	[ca_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dccpay]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dccpay](
	[cp_group] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dccpay] PRIMARY KEY CLUSTERED 
(
	[cp_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dccreg]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dccreg](
	[ca_group] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dccreg] PRIMARY KEY CLUSTERED 
(
	[ca_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dcfifo]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dcfifo](
	[fi_group] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dcfifo] PRIMARY KEY CLUSTERED 
(
	[fi_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dcgl]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dcgl](
	[gl_group] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dcgl] PRIMARY KEY CLUSTERED 
(
	[gl_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dcij]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dcij](
	[ij_group] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dcij] PRIMARY KEY CLUSTERED 
(
	[ij_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dcjob3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dcjob3](
	[j3_group] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dcjob3] PRIMARY KEY CLUSTERED 
(
	[j3_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dcjour]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dcjour](
	[jo_group] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dcjour] PRIMARY KEY CLUSTERED 
(
	[jo_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dcqc4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dcqc4](
	[q4_group] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dcqc4] PRIMARY KEY CLUSTERED 
(
	[q4_group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dm1099type]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dm1099type](
	[ty_id] [int] IDENTITY(1,1) NOT NULL,
	[ty_active] [bit] NOT NULL,
	[ty_default] [bit] NOT NULL,
	[ty_name] [nvarchar](30) NOT NULL,
	[ty_fieldname] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dm1099type] PRIMARY KEY CLUSTERED 
(
	[ty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmalloc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmalloc](
	[al_id] [int] IDENTITY(1,1) NOT NULL,
	[al_childchid] [int] NOT NULL,
	[al_parentchid] [int] NOT NULL,
	[al_pct] [numeric](6, 2) NOT NULL,
	[al_biid] [int] NOT NULL,
	[al_shid] [int] NOT NULL,
	[al_veid] [int] NOT NULL,
 CONSTRAINT [PK_dmalloc] PRIMARY KEY CLUSTERED 
(
	[al_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmalpn]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmalpn](
	[alp_id] [numeric](10, 0) NOT NULL,
	[alp_size] [nvarchar](30) NOT NULL,
	[alp_spec] [nvarchar](30) NOT NULL,
	[alp_number] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dmalpn] PRIMARY KEY CLUSTERED 
(
	[alp_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmauth]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmauth](
	[au_id] [int] IDENTITY(1,1) NOT NULL,
	[au_biid] [int] NOT NULL,
	[au_shid] [int] NOT NULL,
	[au_name] [nvarchar](30) NOT NULL,
	[au_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmauth] PRIMARY KEY CLUSTERED 
(
	[au_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmautoclient]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmautoclient](
	[ac_source] [nvarchar](15) NOT NULL,
	[ac_verbose] [bit] NOT NULL,
	[ac_loopback] [bit] NOT NULL,
	[ac_com] [nvarchar](10) NOT NULL,
	[ac_id] [int] IDENTITY(1,1) NOT NULL,
	[ac_smid] [int] NOT NULL,
	[ac_layout] [nvarchar](30) NOT NULL,
	[ac_lotprinter] [nvarchar](100) NOT NULL,
	[ac_masterlotprinter] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_dmautoclient] PRIMARY KEY CLUSTERED 
(
	[ac_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmautoexport]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmautoexport](
	[ae_dayofweek] [int] NOT NULL,
	[ae_filepath] [nvarchar](256) NOT NULL,
	[ae_id] [int] IDENTITY(1,1) NOT NULL,
	[ae_interval] [nvarchar](5) NOT NULL,
	[ae_lastprint] [datetime] NULL,
	[ae_reid] [int] NOT NULL,
	[ae_reportfor] [nvarchar](30) NOT NULL,
	[ae_reportid] [int] NOT NULL,
	[ae_time] [numeric](4, 0) NOT NULL,
	[ae_destinationtype] [nvarchar](30) NOT NULL,
	[ae_destination] [nvarchar](max) NOT NULL,
	[ae_emailbody] [nvarchar](max) NOT NULL,
	[ae_emailsubject] [nvarchar](60) NOT NULL,
	[ae_text] [nvarchar](max) NOT NULL,
	[ae_type] [nvarchar](30) NOT NULL,
	[ae_ftppass] [nvarchar](max) NOT NULL,
	[ae_ftpserver] [nvarchar](60) NOT NULL,
	[ae_ftpport] [int] NOT NULL,
	[ae_ftpuser] [nvarchar](30) NOT NULL,
	[ae_invssl] [bit] NOT NULL,
	[ae_sftp] [bit] NOT NULL,
	[ae_delimiter] [nvarchar](30) NOT NULL,
	[ae_includeheader] [bit] NOT NULL,
	[ae_doublequotes] [bit] NOT NULL,
	[ae_password] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmautoexport] PRIMARY KEY CLUSTERED 
(
	[ae_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbankacc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbankacc](
	[ba_id] [int] IDENTITY(1,1) NOT NULL,
	[ba_active] [bit] NOT NULL,
	[ba_name] [nvarchar](120) NOT NULL,
	[ba_for] [nvarchar](60) NOT NULL,
	[ba_street] [nvarchar](60) NOT NULL,
	[ba_street2] [nvarchar](60) NOT NULL,
	[ba_city] [nvarchar](40) NOT NULL,
	[ba_state] [nvarchar](40) NOT NULL,
	[ba_zip] [nvarchar](40) NOT NULL,
	[ba_country] [nvarchar](40) NOT NULL,
	[ba_cyid] [int] NOT NULL,
	[ba_contact] [nvarchar](30) NOT NULL,
	[ba_phone] [nvarchar](30) NOT NULL,
	[ba_phext] [nvarchar](30) NOT NULL,
	[ba_fax] [nvarchar](30) NOT NULL,
	[ba_email] [nvarchar](max) NOT NULL,
	[ba_url] [nvarchar](250) NOT NULL,
	[ba_bankid] [nvarchar](30) NOT NULL,
	[ba_bic] [nvarchar](30) NOT NULL,
	[ba_idcode] [nvarchar](30) NOT NULL,
	[ba_acctype] [nvarchar](30) NOT NULL,
	[ba_account] [nvarchar](100) NOT NULL,
	[ba_accname] [nvarchar](60) NOT NULL,
	[ba_iban] [nvarchar](200) NOT NULL,
	[ba_balanced] [bit] NOT NULL,
	[ba_payorid] [nvarchar](30) NOT NULL,
	[ba_payor] [nvarchar](120) NOT NULL,
	[ba_pstreet] [nvarchar](60) NOT NULL,
	[ba_pstreet2] [nvarchar](60) NOT NULL,
	[ba_pcity] [nvarchar](40) NOT NULL,
	[ba_pstate] [nvarchar](40) NOT NULL,
	[ba_pzip] [nvarchar](40) NOT NULL,
	[ba_pcountry] [nvarchar](40) NOT NULL,
	[ba_pcyid] [int] NOT NULL,
	[ba_pphone] [nvarchar](30) NOT NULL,
	[ba_pemail] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmbankacc] PRIMARY KEY CLUSTERED 
(
	[ba_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbcodefmt]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbcodefmt](
	[bf_id] [int] IDENTITY(1,1) NOT NULL,
	[bf_name] [nvarchar](30) NOT NULL,
	[bf_length] [int] NOT NULL,
	[bf_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmbcodefmt] PRIMARY KEY CLUSTERED 
(
	[bf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbcodeseg]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbcodeseg](
	[bs_id] [int] IDENTITY(1,1) NOT NULL,
	[bs_bfid] [int] NOT NULL,
	[bs_start] [int] NOT NULL,
	[bs_end] [int] NOT NULL,
	[bs_ai] [int] NOT NULL,
 CONSTRAINT [PK_dmbcodeseg] PRIMARY KEY CLUSTERED 
(
	[bs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbiassign]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbiassign](
	[ba_id] [int] IDENTITY(1,1) NOT NULL,
	[ba_bpid] [int] NOT NULL,
	[ba_usid] [int] NOT NULL,
	[ba_seq] [int] NOT NULL,
 CONSTRAINT [PK_dmbiassign] PRIMARY KEY CLUSTERED 
(
	[ba_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbicategory]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbicategory](
	[bc_id] [int] IDENTITY(1,1) NOT NULL,
	[bc_name] [nvarchar](60) NOT NULL,
	[bc_active] [bit] NOT NULL,
	[bc_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmbicategory] PRIMARY KEY CLUSTERED 
(
	[bc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbicatsecurity]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbicatsecurity](
	[bs_id] [int] IDENTITY(1,1) NOT NULL,
	[bs_bcid] [int] NOT NULL,
	[bs_access] [bit] NOT NULL,
	[bs_ugid] [int] NOT NULL,
 CONSTRAINT [PK_dmbicatsecurity] PRIMARY KEY CLUSTERED 
(
	[bs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbicolorprofiles]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbicolorprofiles](
	[cp_id] [int] IDENTITY(1,1) NOT NULL,
	[cp_name] [nvarchar](60) NOT NULL,
	[cp_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmbicolorprofiles] PRIMARY KEY CLUSTERED 
(
	[cp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbicolors]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbicolors](
	[bc_id] [int] IDENTITY(1,1) NOT NULL,
	[bc_cpid] [int] NOT NULL,
	[bc_seq] [int] NOT NULL,
	[bc_color] [int] NOT NULL,
 CONSTRAINT [PK_dmbicolors] PRIMARY KEY CLUSTERED 
(
	[bc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbidataset]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbidataset](
	[bd_active] [bit] NOT NULL,
	[bd_d2id] [int] NOT NULL,
	[bd_daid] [int] NOT NULL,
	[bd_descrip] [nvarchar](60) NOT NULL,
	[bd_name] [nvarchar](30) NOT NULL,
	[bd_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dmbidataset] PRIMARY KEY CLUSTERED 
(
	[bd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbielement]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbielement](
	[be_type] [nvarchar](30) NOT NULL,
	[be_grid] [int] NOT NULL,
	[be_right] [numeric](10, 7) NOT NULL,
	[be_bottom] [numeric](10, 7) NOT NULL,
	[be_left] [numeric](10, 7) NOT NULL,
	[be_top] [numeric](10, 7) NOT NULL,
	[be_bdid] [int] NOT NULL,
	[be_bpid] [int] NOT NULL,
	[be_id] [int] IDENTITY(1,1) NOT NULL,
	[be_title] [nvarchar](60) NOT NULL,
	[be_drilldownbdid] [int] NOT NULL,
	[be_drilldownbpid] [int] NOT NULL,
	[be_cpid] [int] NOT NULL,
	[be_anchorxref] [nvarchar](30) NOT NULL,
	[be_anchorxpos] [numeric](10, 7) NOT NULL,
	[be_anchoryref] [nvarchar](30) NOT NULL,
	[be_anchorypos] [numeric](10, 7) NOT NULL,
	[be_heightpct] [numeric](10, 7) NOT NULL,
	[be_widthpct] [numeric](10, 7) NOT NULL,
	[be_aggregate] [bit] NOT NULL,
 CONSTRAINT [PK_dmbielement] PRIMARY KEY CLUSTERED 
(
	[be_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbigridcols]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbigridcols](
	[bc_b2id] [int] NOT NULL,
	[bc_beid] [int] NOT NULL,
	[bc_id] [int] IDENTITY(1,1) NOT NULL,
	[bc_aggtype] [nvarchar](30) NOT NULL,
	[bc_c2guid] [uniqueidentifier] NULL,
	[bc_seq] [int] NOT NULL,
	[bc_width] [int] NOT NULL,
	[bc_format] [nvarchar](30) NOT NULL,
	[bc_mask] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmbigridcols] PRIMARY KEY CLUSTERED 
(
	[bc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbill]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbill](
	[bi_name] [nvarchar](60) NOT NULL,
	[bi_id] [int] IDENTITY(1,1) NOT NULL,
	[bi_grid] [int] NOT NULL,
	[bi_street] [nvarchar](60) NOT NULL,
	[bi_street2] [nvarchar](60) NOT NULL,
	[bi_city] [nvarchar](40) NOT NULL,
	[bi_state] [nvarchar](40) NOT NULL,
	[bi_zip] [nvarchar](40) NOT NULL,
	[bi_phone] [nvarchar](30) NOT NULL,
	[bi_fax] [nvarchar](30) NOT NULL,
	[bi_contact] [nvarchar](30) NOT NULL,
	[bi_credlim] [numeric](12, 0) NOT NULL,
	[bi_teid] [int] NOT NULL,
	[bi_credhld] [datetime] NULL,
	[bi_active] [bit] NOT NULL,
	[bi_notes] [nvarchar](max) NOT NULL,
	[bi_collect] [nvarchar](max) NOT NULL,
	[bi_country] [nvarchar](40) NOT NULL,
	[bi_ccode] [nvarchar](30) NOT NULL,
	[bi_user1] [nvarchar](30) NOT NULL,
	[bi_brid] [int] NOT NULL,
	[bi_smid] [int] NOT NULL,
	[bi_s1id] [int] NOT NULL,
	[bi_s2id] [int] NOT NULL,
	[bi_trid] [int] NOT NULL,
	[bi_waid] [int] NOT NULL,
	[bi_statax] [int] NOT NULL,
	[bi_loctax] [int] NOT NULL,
	[bi_highcrd] [numeric](12, 2) NOT NULL,
	[bi_county] [nvarchar](40) NOT NULL,
	[bi_custid] [nvarchar](30) NOT NULL,
	[bi_email] [nvarchar](max) NOT NULL,
	[bi_poreqd] [bit] NOT NULL,
	[bi_frid] [int] NOT NULL,
	[bi_pastday] [numeric](10, 0) NOT NULL,
	[bi_service] [bit] NOT NULL,
	[bi_s3id] [int] NOT NULL,
	[bi_webname] [nvarchar](30) NOT NULL,
	[bi_webpass] [nvarchar](100) NOT NULL,
	[bi_backord] [bit] NOT NULL,
	[bi_dba] [nvarchar](40) NOT NULL,
	[bi_s4id] [int] NOT NULL,
	[bi_s5id] [int] NOT NULL,
	[bi_credmast] [bit] NOT NULL,
	[bi_phext] [nvarchar](30) NOT NULL,
	[bi_lastcred] [datetime] NULL,
	[bi_nextact] [nvarchar](30) NOT NULL,
	[bi_nextdate] [datetime] NULL,
	[bi_exid] [int] NOT NULL,
	[bi_dear] [nvarchar](30) NOT NULL,
	[bi_said] [int] NOT NULL,
	[bi_fcid] [int] NOT NULL,
	[bi_popup] [nvarchar](max) NOT NULL,
	[bi_invdest] [nvarchar](30) NOT NULL,
	[bi_statedest] [nvarchar](30) NOT NULL,
	[bi_psid] [int] NOT NULL,
	[bi_quota] [numeric](10, 0) NOT NULL,
	[bi_exempt] [bit] NOT NULL,
	[bi_exceed] [numeric](10, 0) NOT NULL,
	[bi_exday] [numeric](10, 0) NOT NULL,
	[bi_credflag] [bit] NOT NULL,
	[bi_dgid] [int] NOT NULL,
	[bi_pomask] [nvarchar](30) NOT NULL,
	[bi_shelfpct] [numeric](10, 0) NOT NULL,
	[bi_archid] [int] NOT NULL,
	[bi_mobileid] [int] NOT NULL,
	[bi_popupship] [nvarchar](max) NOT NULL,
	[bi_trakid] [int] NOT NULL,
	[bi_trak2id] [int] NOT NULL,
	[bi_shelfdays] [numeric](10, 0) NOT NULL,
	[bi_pfuser] [nvarchar](30) NOT NULL,
	[bi_sotrakid] [int] NOT NULL,
	[bi_posprice] [bit] NOT NULL,
	[bi_exreserve] [bit] NOT NULL,
	[bi_routeacct] [bit] NOT NULL,
	[bi_shortship] [nvarchar](30) NOT NULL,
	[bi_pfid] [int] NOT NULL,
	[bi_nopospay] [bit] NOT NULL,
	[bi_reqcpart] [bit] NOT NULL,
	[bi_availall] [bit] NOT NULL,
	[bi_street3] [nvarchar](60) NOT NULL,
	[bi_ccid] [int] NOT NULL,
	[bi_caid] [int] NOT NULL,
	[bi_pdid] [int] NOT NULL,
	[bi_restrictshipfrom] [bit] NOT NULL,
	[bi_noinvdflt] [bit] NOT NULL,
	[bi_rebill] [bit] NOT NULL,
	[bi_rebillworkflow] [int] NOT NULL,
	[bi_shortpayprid] [int] NOT NULL,
	[bi_noreserve] [bit] NOT NULL,
	[bi_cardvaultid] [nvarchar](60) NOT NULL,
	[bi_retattrib1] [bit] NOT NULL,
	[bi_retattrib2] [bit] NOT NULL,
	[bi_retattrib3] [bit] NOT NULL,
	[bi_retdates] [bit] NOT NULL,
	[bi_laststateprint] [datetime] NULL,
	[bi_creddueshipdays] [int] NOT NULL,
	[bi_ttid] [int] NOT NULL,
	[bi_addressvalid] [datetime] NULL,
	[bi_edibilltopo] [bit] NOT NULL,
	[bi_edibilltopodays] [int] NOT NULL,
	[bi_c3id] [int] NOT NULL,
	[bi_emailtype] [nvarchar](30) NOT NULL,
	[bi_linkedjobfinish] [nvarchar](30) NOT NULL,
	[bi_vatid] [nvarchar](30) NOT NULL,
	[bi_cyid] [int] NOT NULL,
	[bi_serializeonreserve] [bit] NOT NULL,
	[bi_invoiceemail] [nvarchar](max) NOT NULL,
	[bi_statementemail] [nvarchar](max) NOT NULL,
	[bi_baid] [int] NOT NULL,
	[bi_ccproccontactid] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_dmbill] PRIMARY KEY CLUSTERED 
(
	[bi_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbillfacility]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbillfacility](
	[bf_id] [int] IDENTITY(1,1) NOT NULL,
	[bf_biid] [int] NOT NULL,
	[bf_waid] [int] NOT NULL,
	[bf_s1id] [int] NOT NULL,
	[bf_s2id] [int] NOT NULL,
	[bf_s3id] [int] NOT NULL,
	[bf_s4id] [int] NOT NULL,
	[bf_s5id] [int] NOT NULL,
	[bf_brid] [int] NOT NULL,
	[bf_trid] [int] NOT NULL,
	[bf_frid] [int] NOT NULL,
	[bf_psid] [int] NOT NULL,
	[bf_sotrakid] [int] NOT NULL,
	[bf_fcid] [int] NOT NULL,
	[bf_dgid] [int] NOT NULL,
	[bf_ccproccontactid] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_dmbillfacility] PRIMARY KEY CLUSTERED 
(
	[bf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbillship]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbillship](
	[bs_id] [int] IDENTITY(1,1) NOT NULL,
	[bs_biid] [int] NOT NULL,
	[bs_shid] [int] NOT NULL,
	[bs_shipdefault] [bit] NOT NULL,
	[bs_billdefault] [bit] NOT NULL,
 CONSTRAINT [PK_dmbillship] PRIMARY KEY CLUSTERED 
(
	[bs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbipage]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbipage](
	[bp_id] [int] IDENTITY(1,1) NOT NULL,
	[bp_name] [nvarchar](30) NOT NULL,
	[bp_descrip] [nvarchar](60) NOT NULL,
	[bp_active] [bit] NOT NULL,
	[bp_bcid] [int] NOT NULL,
 CONSTRAINT [PK_dmbipage] PRIMARY KEY CLUSTERED 
(
	[bp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbom]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbom](
	[bo_id] [int] IDENTITY(1,1) NOT NULL,
	[bo_bomfor] [int] NOT NULL,
	[bo_prid] [int] NOT NULL,
	[bo_seq] [numeric](10, 0) NOT NULL,
	[bo_quant] [numeric](20, 10) NOT NULL,
	[bo_notes] [nvarchar](max) NOT NULL,
	[bo_desig] [nvarchar](30) NOT NULL,
	[bo_reid] [int] NOT NULL,
	[bo_subtot] [bit] NOT NULL,
	[bo_costonly] [bit] NOT NULL,
	[bo_unid] [int] NOT NULL,
	[bo_scrap] [numeric](17, 7) NOT NULL,
	[bo_overage] [numeric](17, 7) NOT NULL,
	[bo_byproduct] [bit] NOT NULL,
	[bo_overissue] [numeric](10, 4) NOT NULL,
	[bo_bgid] [int] NOT NULL,
	[bo_bomcalc] [nvarchar](11) NOT NULL,
	[bo_fixqty] [bit] NOT NULL,
	[bo_scrapcost] [numeric](17, 7) NOT NULL,
	[bo_uselot] [bit] NOT NULL,
	[bo_useexp] [bit] NOT NULL,
	[bo_coprod] [int] NOT NULL,
	[bo_propattrib] [bit] NOT NULL,
	[bo_cpcost] [nvarchar](30) NOT NULL,
	[bo_finasissued] [bit] NOT NULL,
	[bo_reqseq] [bit] NOT NULL,
	[bo_incqty] [numeric](17, 7) NOT NULL,
	[bo_maxage] [int] NOT NULL,
	[bo_coprodquant] [numeric](17, 7) NOT NULL,
	[bo_groupby] [nvarchar](max) NOT NULL,
	[bo_q3id] [int] NOT NULL,
	[bo_minage] [int] NOT NULL,
	[bo_nonscaleableqty] [nvarchar](30) NOT NULL,
	[bo_propattrib1] [bit] NOT NULL,
	[bo_propattrib2] [bit] NOT NULL,
	[bo_propattrib3] [bit] NOT NULL,
	[bo_issueunid] [int] NOT NULL,
	[bo_shelfpct] [numeric](10, 0) NOT NULL,
	[bo_shelfdays] [numeric](10, 0) NOT NULL,
	[bo_relievecatch] [bit] NOT NULL,
	[bo_issueinctype] [nvarchar](30) NOT NULL,
	[bo_issueincexp] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmbom] PRIMARY KEY CLUSTERED 
(
	[bo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbomgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbomgrp](
	[bg_id] [int] IDENTITY(1,1) NOT NULL,
	[bg_name] [nvarchar](30) NOT NULL,
	[bg_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmbomgrp] PRIMARY KEY CLUSTERED 
(
	[bg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbrok]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbrok](
	[br_name] [nvarchar](30) NOT NULL,
	[br_id] [int] IDENTITY(1,1) NOT NULL,
	[br_street] [nvarchar](40) NOT NULL,
	[br_street2] [nvarchar](40) NOT NULL,
	[br_city] [nvarchar](40) NOT NULL,
	[br_state] [nvarchar](40) NOT NULL,
	[br_zip] [nvarchar](40) NOT NULL,
	[br_phone] [nvarchar](30) NOT NULL,
	[br_fax] [nvarchar](30) NOT NULL,
	[br_contact] [nvarchar](30) NOT NULL,
	[br_active] [bit] NOT NULL,
	[br_default] [bit] NOT NULL,
	[br_webname] [nvarchar](30) NOT NULL,
	[br_webpass] [nvarchar](100) NOT NULL,
	[br_phext] [nvarchar](30) NOT NULL,
	[br_quota] [numeric](10, 0) NOT NULL,
	[br_email] [nvarchar](max) NOT NULL,
	[br_ccode] [nvarchar](30) NOT NULL,
	[br_ccid] [int] NOT NULL,
	[br_veid] [int] NOT NULL,
	[br_cyid] [int] NOT NULL,
 CONSTRAINT [PK_dmbrok] PRIMARY KEY CLUSTERED 
(
	[br_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbud]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbud](
	[bu_id] [int] IDENTITY(1,1) NOT NULL,
	[bu_peid] [int] NOT NULL,
	[bu_chid] [int] NOT NULL,
	[bu_peramt1] [numeric](15, 2) NOT NULL,
	[bu_peramt2] [numeric](15, 2) NOT NULL,
	[bu_peramt3] [numeric](15, 2) NOT NULL,
	[bu_peramt4] [numeric](15, 2) NOT NULL,
	[bu_peramt5] [numeric](15, 2) NOT NULL,
	[bu_peramt6] [numeric](15, 2) NOT NULL,
	[bu_peramt7] [numeric](15, 2) NOT NULL,
	[bu_peramt8] [numeric](15, 2) NOT NULL,
	[bu_peramt9] [numeric](15, 2) NOT NULL,
	[bu_peramt10] [numeric](15, 2) NOT NULL,
	[bu_peramt11] [numeric](15, 2) NOT NULL,
	[bu_peramt12] [numeric](15, 2) NOT NULL,
	[bu_peramt13] [numeric](15, 2) NOT NULL,
 CONSTRAINT [PK_dmbud] PRIMARY KEY CLUSTERED 
(
	[bu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmbuyer]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmbuyer](
	[bu_id] [int] IDENTITY(1,1) NOT NULL,
	[bu_name] [nvarchar](30) NOT NULL,
	[bu_active] [bit] NOT NULL,
	[bu_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmbuyer] PRIMARY KEY CLUSTERED 
(
	[bu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcalc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcalc](
	[ca_id] [int] IDENTITY(1,1) NOT NULL,
	[ca_name] [nvarchar](30) NOT NULL,
	[ca_active] [bit] NOT NULL,
	[ca_express] [nvarchar](max) NOT NULL,
	[ca_type] [nvarchar](30) NOT NULL,
	[ca_picture] [nvarchar](30) NOT NULL,
	[ca_notes] [nvarchar](max) NOT NULL,
	[ca_field] [nvarchar](30) NOT NULL,
	[ca_seq] [int] NOT NULL,
	[ca_table] [nvarchar](30) NOT NULL,
	[ca_fldtype] [nvarchar](1) NOT NULL,
	[ca_linecalc] [nvarchar](30) NOT NULL,
	[ca_level] [nvarchar](30) NOT NULL,
	[ca_regulatory] [bit] NOT NULL,
	[ca_until] [nvarchar](30) NOT NULL,
	[ca_prtform] [bit] NOT NULL,
	[ca_masterorder] [bit] NOT NULL,
	[ca_manualrecalc] [bit] NOT NULL,
 CONSTRAINT [PK_dmcalc] PRIMARY KEY CLUSTERED 
(
	[ca_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcampaign]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcampaign](
	[ca_name] [nvarchar](30) NOT NULL,
	[ca_id] [int] IDENTITY(1,1) NOT NULL,
	[ca_default] [bit] NOT NULL,
	[ca_active] [bit] NOT NULL,
	[ca_emid] [int] NOT NULL,
 CONSTRAINT [PK_dmcampaign] PRIMARY KEY CLUSTERED 
(
	[ca_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcampaignemail]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcampaignemail](
	[ce_name] [nvarchar](30) NOT NULL,
	[ce_id] [int] IDENTITY(1,1) NOT NULL,
	[ce_default] [bit] NOT NULL,
	[ce_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmcampaignemail] PRIMARY KEY CLUSTERED 
(
	[ce_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcash3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcash3](
	[c3_id] [int] IDENTITY(1,1) NOT NULL,
	[c3_name] [nvarchar](30) NOT NULL,
	[c3_default] [bit] NOT NULL,
	[c3_active] [bit] NOT NULL,
	[c3_recon] [bit] NOT NULL,
	[c3_badchk] [bit] NOT NULL,
	[c3_chid] [int] NOT NULL,
	[c3_cashback] [bit] NOT NULL,
	[c3_recchid] [int] NOT NULL,
	[c3_recgain] [int] NOT NULL,
	[c3_ccmask] [nvarchar](30) NOT NULL,
	[c3_creditcard] [bit] NOT NULL,
	[c3_giftcard] [bit] NOT NULL,
	[c3_max] [numeric](17, 2) NOT NULL,
	[c3_cashchid] [int] NOT NULL,
	[c3_showcashreg] [bit] NOT NULL,
	[c3_seq] [int] NOT NULL,
	[c3_swipeexpression] [nvarchar](max) NOT NULL,
	[c3_showdsd] [bit] NOT NULL,
 CONSTRAINT [PK_dmcash3] PRIMARY KEY CLUSTERED 
(
	[c3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcats]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcats](
	[ca_id] [int] IDENTITY(1,1) NOT NULL,
	[ca_name] [nvarchar](30) NOT NULL,
	[ca_active] [bit] NOT NULL,
	[ca_default] [bit] NOT NULL,
	[ca_quota] [numeric](10, 0) NOT NULL,
	[ca_restricted] [bit] NOT NULL,
 CONSTRAINT [PK_dmcats] PRIMARY KEY CLUSTERED 
(
	[ca_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcats2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcats2](
	[c2_id] [int] IDENTITY(1,1) NOT NULL,
	[c2_name] [nvarchar](30) NOT NULL,
	[c2_active] [bit] NOT NULL,
	[c2_caid] [int] NOT NULL,
	[c2_quota] [numeric](10, 0) NOT NULL,
	[c2_restricted] [bit] NOT NULL,
 CONSTRAINT [PK_dmcats2] PRIMARY KEY CLUSTERED 
(
	[c2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcats3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcats3](
	[c3_id] [int] IDENTITY(1,1) NOT NULL,
	[c3_caid] [int] NOT NULL,
	[c3_biid] [int] NOT NULL,
	[c3_shid] [int] NOT NULL,
	[c3_c2id] [int] NOT NULL,
	[c3_exid] [int] NOT NULL,
	[c3_waid] [int] NOT NULL,
	[c3_rsid] [int] NOT NULL,
	[c3_parentrsid] [int] NOT NULL,
	[c3_rtid] [int] NOT NULL,
	[c3_min] [numeric](17, 7) NOT NULL,
	[c3_max] [numeric](17, 7) NOT NULL,
	[c3_p1id] [int] NOT NULL,
	[c3_p2id] [int] NOT NULL,
	[c3_p3id] [int] NOT NULL,
	[c3_p4id] [int] NOT NULL,
	[c3_p5id] [int] NOT NULL,
 CONSTRAINT [PK_dmcats3] PRIMARY KEY CLUSTERED 
(
	[c3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmccard]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmccard](
	[cc_id] [int] IDENTITY(1,1) NOT NULL,
	[cc_number] [nvarchar](100) NOT NULL,
	[cc_nameoncard] [nvarchar](60) NOT NULL,
	[cc_exp] [int] NOT NULL,
	[cc_c3id] [int] NOT NULL,
	[cc_billaddr] [bit] NOT NULL,
	[cc_street] [nvarchar](60) NOT NULL,
	[cc_street2] [nvarchar](60) NOT NULL,
	[cc_city] [nvarchar](40) NOT NULL,
	[cc_state] [nvarchar](40) NOT NULL,
	[cc_zip] [nvarchar](40) NOT NULL,
	[cc_country] [nvarchar](40) NOT NULL,
	[cc_biid] [int] NOT NULL,
	[cc_last4] [nvarchar](4) NOT NULL,
	[cc_ordnum] [numeric](15, 0) NOT NULL,
	[cc_billpo] [nvarchar](30) NOT NULL,
	[cc_cardvaultid] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_dmccard] PRIMARY KEY CLUSTERED 
(
	[cc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmccproc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmccproc](
	[cc_active] [bit] NOT NULL,
	[cc_id] [int] IDENTITY(1,1) NOT NULL,
	[cc_merchant] [nvarchar](30) NOT NULL,
	[cc_name] [nvarchar](30) NOT NULL,
	[cc_partner] [nvarchar](30) NOT NULL,
	[cc_pass] [nvarchar](100) NOT NULL,
	[cc_user] [nvarchar](30) NOT NULL,
	[cc_default] [bit] NOT NULL,
	[cc_type] [int] NOT NULL,
	[cc_host] [nvarchar](200) NOT NULL,
	[cc_ipport] [int] NOT NULL,
	[cc_terminalreq] [bit] NOT NULL,
	[cc_defaultdc] [bit] NOT NULL,
	[cc_location] [nvarchar](100) NOT NULL,
	[cc_termcode] [nvarchar](100) NOT NULL,
	[cc_client] [nvarchar](30) NOT NULL,
	[cc_testmode] [bit] NOT NULL,
	[cc_apikey] [nvarchar](200) NOT NULL,
	[cc_external] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_dmccproc] PRIMARY KEY CLUSTERED 
(
	[cc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcent]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcent](
	[ce_id] [int] IDENTITY(1,1) NOT NULL,
	[ce_name] [nvarchar](30) NOT NULL,
	[ce_shid] [int] NOT NULL,
	[ce_rate] [numeric](10, 2) NOT NULL,
	[ce_hours] [numeric](4, 0) NOT NULL,
	[ce_active] [bit] NOT NULL,
	[ce_util] [numeric](5, 2) NOT NULL,
	[ce_workcnt] [numeric](4, 0) NOT NULL,
	[ce_default] [bit] NOT NULL,
	[ce_acquired] [datetime] NULL,
	[ce_acqcost] [numeric](17, 7) NOT NULL,
	[ce_depreciation] [nvarchar](1) NOT NULL,
	[ce_parent] [int] NOT NULL,
	[ce_ctid] [int] NOT NULL,
	[ce_descrip] [nvarchar](60) NOT NULL,
	[ce_notes] [nvarchar](max) NOT NULL,
	[ce_manufacturer] [nvarchar](30) NOT NULL,
	[ce_model] [nvarchar](30) NOT NULL,
	[ce_serial] [nvarchar](30) NOT NULL,
	[ce_burfact] [numeric](17, 7) NOT NULL,
	[ce_depchid] [int] NOT NULL,
	[ce_depmonths] [int] NOT NULL,
	[ce_lastpostcost] [numeric](17, 7) NOT NULL,
	[ce_depexpensechid] [int] NOT NULL,
	[ce_lastpostdate] [datetime] NULL,
	[ce_minljquant] [numeric](17, 7) NOT NULL,
	[ce_maxljquant] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dmcent] PRIMARY KEY CLUSTERED 
(
	[ce_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcentmaint]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcentmaint](
	[cm_id] [int] IDENTITY(1,1) NOT NULL,
	[cm_ceid] [int] NOT NULL,
	[cm_recurtype] [nvarchar](1) NOT NULL,
	[cm_recurfreq] [int] NOT NULL,
	[cm_prid] [int] NOT NULL,
	[cm_name] [nvarchar](60) NOT NULL,
	[cm_mgid] [int] NOT NULL,
	[cm_unavailvl] [nvarchar](30) NOT NULL,
	[cm_priority] [int] NOT NULL,
	[cm_meter] [bit] NOT NULL,
	[cm_maxmeter] [numeric](17, 7) NOT NULL,
	[cm_schedtype] [nvarchar](30) NOT NULL,
	[cm_dayof] [nvarchar](30) NOT NULL,
	[cm_day] [int] NOT NULL,
	[cm_copydoc] [int] NOT NULL,
	[cm_initdate] [datetime] NULL,
	[cm_recid] [int] NOT NULL,
	[cm_table] [nvarchar](60) NOT NULL,
	[cm_notes] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmcentmaint] PRIMARY KEY CLUSTERED 
(
	[cm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcentstatus]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcentstatus](
	[cs_id] [int] IDENTITY(1,1) NOT NULL,
	[cs_cmid] [int] NOT NULL,
	[cs_lastmaint] [datetime] NULL,
	[cs_meter] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dmcentstatus] PRIMARY KEY CLUSTERED 
(
	[cs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcenttype]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcenttype](
	[ct_id] [int] IDENTITY(1,1) NOT NULL,
	[ct_name] [nvarchar](30) NOT NULL,
	[ct_active] [bit] NOT NULL,
	[ct_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmcenttype] PRIMARY KEY CLUSTERED 
(
	[ct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmchangeover]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmchangeover](
	[co_id] [int] IDENTITY(1,1) NOT NULL,
	[co_prevseq1] [int] NOT NULL,
	[co_nextseq1] [int] NOT NULL,
	[co_opid] [int] NOT NULL,
	[co_active] [bit] NOT NULL,
	[co_prid] [int] NOT NULL,
 CONSTRAINT [PK_dmchangeover] PRIMARY KEY CLUSTERED 
(
	[co_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmchgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmchgrp](
	[cg_id] [int] IDENTITY(1,1) NOT NULL,
	[cg_name] [nvarchar](30) NOT NULL,
	[cg_active] [bit] NOT NULL,
	[cg_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmchgrp] PRIMARY KEY CLUSTERED 
(
	[cg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmchgrp2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmchgrp2](
	[c2_id] [int] IDENTITY(1,1) NOT NULL,
	[c2_cgid] [int] NOT NULL,
	[c2_usid] [int] NOT NULL,
	[c2_ugid] [int] NOT NULL,
	[c2_access] [bit] NOT NULL,
 CONSTRAINT [PK_dmchgrp2] PRIMARY KEY CLUSTERED 
(
	[c2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmchrt]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmchrt](
	[ch_id] [int] IDENTITY(1,1) NOT NULL,
	[ch_account] [numeric](30, 0) NOT NULL,
	[ch_name] [nvarchar](120) NOT NULL,
	[ch_type] [nvarchar](30) NOT NULL,
	[ch_cogsid] [int] NOT NULL,
	[ch_active] [bit] NOT NULL,
	[ch_cgid] [int] NOT NULL,
	[ch_balance] [bit] NOT NULL,
	[ch_currgain] [int] NOT NULL,
	[ch_fcid] [int] NOT NULL,
	[ch_masterchid] [int] NOT NULL,
	[ch_laborcogsid] [int] NOT NULL,
	[ch_burdencogsid] [int] NOT NULL,
	[ch_baid] [int] NOT NULL,
 CONSTRAINT [PK_dmchrt] PRIMARY KEY CLUSTERED 
(
	[ch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcmscatlink]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcmscatlink](
	[cl_id] [int] IDENTITY(1,1) NOT NULL,
	[cl_ccid] [int] NOT NULL,
	[cl_type] [nvarchar](30) NOT NULL,
	[cl_recid] [int] NOT NULL,
	[cl_csid] [int] NOT NULL,
	[cl_parentccid] [int] NOT NULL,
 CONSTRAINT [PK_dmcmscatlink] PRIMARY KEY CLUSTERED 
(
	[cl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcmscats]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcmscats](
	[cc_id] [int] IDENTITY(1,1) NOT NULL,
	[cc_ecomcat] [nvarchar](60) NOT NULL,
	[cc_active] [bit] NOT NULL,
	[cc_default] [bit] NOT NULL,
	[cc_seq] [int] NOT NULL,
	[cc_type] [nvarchar](60) NOT NULL,
	[cc_includeinfooter] [bit] NOT NULL,
 CONSTRAINT [PK_dmcmscats] PRIMARY KEY CLUSTERED 
(
	[cc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcmsdefaults]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcmsdefaults](
	[cd_regbiid] [int] NOT NULL,
	[cd_regshid] [int] NOT NULL,
	[cd_minord] [numeric](17, 7) NOT NULL,
	[cd_allowsaturday] [bit] NOT NULL,
	[cd_allowsunday] [bit] NOT NULL,
	[cd_csid] [int] NOT NULL,
	[cd_id] [int] IDENTITY(1,1) NOT NULL,
	[cd_s1id] [int] NOT NULL,
	[cd_s2id] [int] NOT NULL,
	[cd_s3id] [int] NOT NULL,
	[cd_s4id] [int] NOT NULL,
	[cd_s5id] [int] NOT NULL,
	[cd_trid] [int] NOT NULL,
	[cd_smid] [int] NOT NULL,
 CONSTRAINT [PK_dmcmsdefaults] PRIMARY KEY CLUSTERED 
(
	[cd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcmsmenus]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcmsmenus](
	[cm_id] [int] IDENTITY(1,1) NOT NULL,
	[cm_parentmeid] [int] NOT NULL,
	[cm_text] [nvarchar](40) NOT NULL,
	[cm_desc] [nvarchar](200) NOT NULL,
	[cm_url] [nvarchar](100) NOT NULL,
	[cm_column] [nvarchar](40) NOT NULL,
	[cm_sort] [int] NOT NULL,
	[cm_active] [bit] NOT NULL,
	[cm_csid] [int] NOT NULL,
 CONSTRAINT [PK_dmcmsmenus] PRIMARY KEY CLUSTERED 
(
	[cm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcmsparentcats]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcmsparentcats](
	[pc_id] [int] IDENTITY(1,1) NOT NULL,
	[pc_ccid] [int] NOT NULL,
	[pc_parentccid] [int] NOT NULL,
 CONSTRAINT [PK_dmcmsparentcats] PRIMARY KEY CLUSTERED 
(
	[pc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcmssecquest]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcmssecquest](
	[cq_id] [int] IDENTITY(1,1) NOT NULL,
	[cq_question] [nvarchar](150) NOT NULL,
	[cq_active] [bit] NOT NULL,
	[cq_csid] [int] NOT NULL,
 CONSTRAINT [PK_dmcmssecquest] PRIMARY KEY CLUSTERED 
(
	[cq_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcmsuseracc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcmsuseracc](
	[cu_id] [int] IDENTITY(1,1) NOT NULL,
	[cu_type] [nvarchar](50) NOT NULL,
	[cu_biid] [int] NOT NULL,
	[cu_shid] [int] NOT NULL,
	[cu_active] [bit] NOT NULL,
	[cu_password] [nvarchar](150) NOT NULL,
	[cu_login] [nvarchar](50) NOT NULL,
	[cu_email] [nvarchar](150) NOT NULL,
	[cu_cqid] [int] NOT NULL,
	[cu_sqanswer] [nvarchar](150) NOT NULL,
	[cu_orderconfirm] [bit] NOT NULL,
	[cu_specialoffer] [bit] NOT NULL,
	[cu_newsletter] [bit] NOT NULL,
	[cu_deldate] [nvarchar](50) NOT NULL,
	[cu_minord] [numeric](17, 7) NOT NULL,
	[cu_minordtype] [nvarchar](30) NOT NULL,
	[cu_samedaycharge] [numeric](17, 7) NOT NULL,
	[cu_allowsunday] [bit] NOT NULL,
	[cu_allowsaturday] [bit] NOT NULL,
	[cu_brid] [int] NOT NULL,
	[cu_ccid] [int] NOT NULL,
	[cu_phone] [nvarchar](30) NOT NULL,
	[cu_csid] [int] NOT NULL,
	[cu_paymentrequired] [bit] NOT NULL,
	[cu_loginapproved] [bit] NOT NULL,
	[cu_chgpass] [bit] NOT NULL,
	[cu_guestuser] [bit] NOT NULL,
	[cu_fname] [nvarchar](60) NOT NULL,
	[cu_lname] [nvarchar](60) NOT NULL,
	[cu_allowcartreminder] [bit] NOT NULL,
	[cu_wishlist] [nvarchar](300) NOT NULL,
	[cu_defaultccid] [int] NOT NULL,
	[cu_statelessapionly] [bit] NOT NULL,
 CONSTRAINT [PK_dmcmsuseracc] PRIMARY KEY CLUSTERED 
(
	[cu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmco1]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmco1](
	[c1_id] [int] IDENTITY(1,1) NOT NULL,
	[c1_name] [nvarchar](30) NOT NULL,
	[c1_active] [bit] NOT NULL,
	[c1_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmco1] PRIMARY KEY CLUSTERED 
(
	[c1_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmco2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmco2](
	[c2_id] [int] IDENTITY(1,1) NOT NULL,
	[c2_name] [nvarchar](30) NOT NULL,
	[c2_active] [bit] NOT NULL,
	[c2_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmco2] PRIMARY KEY CLUSTERED 
(
	[c2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmco3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmco3](
	[c3_id] [int] IDENTITY(1,1) NOT NULL,
	[c3_name] [nvarchar](30) NOT NULL,
	[c3_active] [bit] NOT NULL,
	[c3_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmco3] PRIMARY KEY CLUSTERED 
(
	[c3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmco4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmco4](
	[c4_id] [int] IDENTITY(1,1) NOT NULL,
	[c4_name] [nvarchar](30) NOT NULL,
	[c4_active] [bit] NOT NULL,
	[c4_default] [bit] NOT NULL,
	[c4_financialmaster] [bit] NOT NULL,
 CONSTRAINT [PK_dmco4] PRIMARY KEY CLUSTERED 
(
	[c4_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmco5]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmco5](
	[c5_id] [int] IDENTITY(1,1) NOT NULL,
	[c5_name] [nvarchar](30) NOT NULL,
	[c5_active] [bit] NOT NULL,
	[c5_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmco5] PRIMARY KEY CLUSTERED 
(
	[c5_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcogrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcogrp](
	[cg_id] [int] IDENTITY(1,1) NOT NULL,
	[cg_name] [nvarchar](30) NOT NULL,
	[cg_active] [bit] NOT NULL,
	[cg_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmcogrp] PRIMARY KEY CLUSTERED 
(
	[cg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcogrp2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcogrp2](
	[c2_id] [int] IDENTITY(1,1) NOT NULL,
	[c2_usid] [int] NOT NULL,
	[c2_cgid] [int] NOT NULL,
 CONSTRAINT [PK_dmcogrp2] PRIMARY KEY CLUSTERED 
(
	[c2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcolsums]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcolsums](
	[cs_id] [int] IDENTITY(1,1) NOT NULL,
	[cs_usid] [int] NOT NULL,
	[cs_reporttype] [nvarchar](30) NOT NULL,
	[cs_gridclass] [nvarchar](60) NOT NULL,
	[cs_collapsed] [bit] NOT NULL,
 CONSTRAINT [PK_dmcolsums] PRIMARY KEY CLUSTERED 
(
	[cs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcomm2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcomm2](
	[c2_id] [int] IDENTITY(1,1) NOT NULL,
	[c2_for] [nvarchar](30) NOT NULL,
	[c2_fornum] [int] NOT NULL,
	[c2_forname] [nvarchar](60) NOT NULL,
	[c2_on] [nvarchar](30) NOT NULL,
	[c2_onnum] [int] NOT NULL,
	[c2_onname] [nvarchar](30) NOT NULL,
	[c2_type] [nvarchar](30) NOT NULL,
	[c2_typenum] [numeric](17, 7) NOT NULL,
	[c2_start] [datetime] NULL,
	[c2_end] [datetime] NULL,
	[c2_active] [bit] NOT NULL,
	[c2_comptype] [nvarchar](30) NOT NULL,
	[c2_compid] [int] NOT NULL,
	[c2_unid] [int] NOT NULL,
	[c2_cgid] [int] NOT NULL,
	[c2_includefreight] [bit] NOT NULL,
	[c2_descrip] [nvarchar](100) NOT NULL,
	[c2_expression] [nvarchar](max) NOT NULL,
	[c2_basedon] [nvarchar](30) NOT NULL,
	[c2_paytype] [nvarchar](30) NOT NULL,
	[c2_itemfilter] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmcomm2] PRIMARY KEY CLUSTERED 
(
	[c2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcommgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcommgrp](
	[cg_id] [int] IDENTITY(1,1) NOT NULL,
	[cg_name] [nvarchar](30) NOT NULL,
	[cg_active] [bit] NOT NULL,
	[cg_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmcommgrp] PRIMARY KEY CLUSTERED 
(
	[cg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmconstant]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmconstant](
	[co_id] [int] IDENTITY(1,1) NOT NULL,
	[co_name] [nvarchar](30) NOT NULL,
	[co_value] [numeric](17, 7) NOT NULL,
	[co_active] [bit] NOT NULL,
	[co_notes] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmconstant] PRIMARY KEY CLUSTERED 
(
	[co_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcont]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcont](
	[co_biid] [int] NOT NULL,
	[co_lname] [nvarchar](30) NOT NULL,
	[co_fname] [nvarchar](30) NOT NULL,
	[co_title] [nvarchar](30) NOT NULL,
	[co_dear] [nvarchar](30) NOT NULL,
	[co_phone] [nvarchar](30) NOT NULL,
	[co_fax] [nvarchar](30) NOT NULL,
	[co_email] [nvarchar](60) NOT NULL,
	[co_cell] [nvarchar](30) NOT NULL,
	[co_home] [nvarchar](30) NOT NULL,
	[co_website] [nvarchar](100) NOT NULL,
	[co_u1id] [int] NOT NULL,
	[co_u2id] [int] NOT NULL,
	[co_u3id] [int] NOT NULL,
	[co_u4id] [int] NOT NULL,
	[co_u5id] [int] NOT NULL,
	[co_notes] [nvarchar](max) NOT NULL,
	[co_id] [int] IDENTITY(1,1) NOT NULL,
	[co_evid] [int] NOT NULL,
	[co_e2id] [int] NOT NULL,
	[co_street] [nvarchar](40) NOT NULL,
	[co_street2] [nvarchar](40) NOT NULL,
	[co_city] [nvarchar](40) NOT NULL,
	[co_state] [nvarchar](40) NOT NULL,
	[co_zip] [nvarchar](40) NOT NULL,
	[co_active] [bit] NOT NULL,
	[co_evntdue] [datetime] NULL,
	[co_smid] [int] NOT NULL,
	[co_phext] [nvarchar](30) NOT NULL,
	[co_user1] [nvarchar](30) NOT NULL,
	[co_user2] [nvarchar](30) NOT NULL,
	[co_user3] [nvarchar](30) NOT NULL,
	[co_user4] [nvarchar](30) NOT NULL,
	[co_user5] [nvarchar](30) NOT NULL,
	[co_company] [nvarchar](60) NOT NULL,
	[co_nextact] [nvarchar](120) NOT NULL,
	[co_nextdate] [datetime] NULL,
	[co_usid] [int] NOT NULL,
	[co_private] [nvarchar](30) NOT NULL,
	[co_lastnote] [datetime] NULL,
	[co_said] [int] NOT NULL,
	[co_quota] [numeric](12, 0) NOT NULL,
	[co_nexttime] [numeric](4, 0) NOT NULL,
	[co_sync] [bit] NOT NULL,
	[co_shid] [int] NOT NULL,
	[co_veid] [int] NOT NULL,
	[co_cgid] [int] NOT NULL,
	[co_country] [nvarchar](40) NOT NULL,
	[co_rsslink] [nvarchar](250) NOT NULL,
	[co_ccode] [nvarchar](30) NOT NULL,
	[co_trakid] [int] NOT NULL,
	[co_trak2id] [int] NOT NULL,
	[co_revenues] [numeric](12, 0) NOT NULL,
	[co_employees] [int] NOT NULL,
	[co_parentname] [nvarchar](30) NOT NULL,
	[co_maid] [int] NOT NULL,
	[co_msid] [int] NOT NULL,
	[co_stocksym] [nvarchar](30) NOT NULL,
	[co_syncgoog] [bit] NOT NULL,
	[co_syncyahoo] [bit] NOT NULL,
	[co_lastrss] [datetime] NULL,
	[co_street3] [nvarchar](40) NOT NULL,
	[co_cyid] [int] NOT NULL,
	[co_ttid] [int] NOT NULL,
 CONSTRAINT [PK_dmcont] PRIMARY KEY CLUSTERED 
(
	[co_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcont2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcont2](
	[c2_id] [int] IDENTITY(1,1) NOT NULL,
	[c2_usid] [int] NOT NULL,
	[c2_date] [datetime] NULL,
	[c2_time] [nvarchar](8) NOT NULL,
	[c2_coid] [int] NOT NULL,
	[c2_notes] [nvarchar](max) NOT NULL,
	[c2_ctid] [int] NOT NULL,
	[c2_cpid] [int] NOT NULL,
 CONSTRAINT [PK_dmcont2] PRIMARY KEY CLUSTERED 
(
	[c2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcontainer]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcontainer](
	[cr_id] [int] IDENTITY(1,1) NOT NULL,
	[cr_contnum] [nvarchar](30) NOT NULL,
	[cr_unid] [int] NOT NULL,
	[cr_prid] [int] NOT NULL,
	[cr_tarewgt] [numeric](17, 7) NOT NULL,
	[cr_acqcost] [numeric](17, 7) NOT NULL,
	[cr_acquired] [datetime] NULL,
	[cr_depreciation] [nvarchar](30) NOT NULL,
	[cr_depchid] [int] NOT NULL,
	[cr_depmonths] [int] NOT NULL,
	[cr_lastpostcost] [numeric](17, 7) NOT NULL,
	[cr_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmcontainer] PRIMARY KEY CLUSTERED 
(
	[cr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcontcampaign]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcontcampaign](
	[cn_id] [int] IDENTITY(1,1) NOT NULL,
	[cn_coid] [int] NOT NULL,
	[cn_caid] [int] NOT NULL,
	[cn_ceid] [int] NOT NULL,
	[cn_date] [datetime] NULL,
	[cn_time] [numeric](4, 0) NOT NULL,
	[cn_cpid] [int] NOT NULL,
 CONSTRAINT [PK_dmcontcampaign] PRIMARY KEY CLUSTERED 
(
	[cn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcontpeople]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcontpeople](
	[cp_id] [int] IDENTITY(1,1) NOT NULL,
	[cp_dear] [nvarchar](30) NOT NULL,
	[cp_said] [int] NOT NULL,
	[cp_fname] [nvarchar](30) NOT NULL,
	[cp_lname] [nvarchar](30) NOT NULL,
	[cp_title] [nvarchar](60) NOT NULL,
	[cp_cell] [nvarchar](30) NOT NULL,
	[cp_phext] [nvarchar](30) NOT NULL,
	[cp_home] [nvarchar](30) NOT NULL,
	[cp_email] [nvarchar](max) NOT NULL,
	[cp_default] [bit] NOT NULL,
	[cp_active] [bit] NOT NULL,
	[cp_coid] [int] NOT NULL,
	[cp_ccode] [nvarchar](30) NOT NULL,
	[cp_phone] [nvarchar](30) NOT NULL,
	[cp_emailall] [bit] NOT NULL,
	[cp_linkemail] [bit] NOT NULL,
	[cp_massemail] [nvarchar](30) NOT NULL,
	[cp_cyid] [int] NOT NULL,
	[cp_country] [nvarchar](40) NOT NULL,
	[cp_monitoremail] [int] NOT NULL,
 CONSTRAINT [PK_dmcontpeople] PRIMARY KEY CLUSTERED 
(
	[cp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcountry]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcountry](
	[cy_id] [int] IDENTITY(1,1) NOT NULL,
	[cy_code] [int] NOT NULL,
	[cy_name] [nvarchar](30) NOT NULL,
	[cy_active] [bit] NOT NULL,
	[cy_default] [bit] NOT NULL,
	[cy_mask] [nvarchar](30) NOT NULL,
	[cy_fcid] [int] NOT NULL,
	[cy_caid] [int] NOT NULL,
 CONSTRAINT [pk_dmcountry] PRIMARY KEY CLUSTERED 
(
	[cy_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcrew]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcrew](
	[cr_id] [int] IDENTITY(1,1) NOT NULL,
	[cr_name] [nvarchar](30) NOT NULL,
	[cr_active] [bit] NOT NULL,
	[cr_default] [bit] NOT NULL,
	[cr_sfid] [int] NOT NULL,
	[cr_workother] [bit] NOT NULL,
 CONSTRAINT [PK_dmcrew] PRIMARY KEY CLUSTERED 
(
	[cr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcrmprojcats]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcrmprojcats](
	[cc_id] [int] IDENTITY(1,1) NOT NULL,
	[cc_name] [nvarchar](30) NOT NULL,
	[cc_active] [bit] NOT NULL,
	[cc_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmcrmprojcats] PRIMARY KEY CLUSTERED 
(
	[cc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmctype]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmctype](
	[ct_id] [int] IDENTITY(1,1) NOT NULL,
	[ct_name] [nvarchar](30) NOT NULL,
	[ct_active] [bit] NOT NULL,
	[ct_default] [bit] NOT NULL,
	[ct_system] [bit] NOT NULL,
	[ct_noid] [int] NOT NULL,
 CONSTRAINT [PK_dmctype] PRIMARY KEY CLUSTERED 
(
	[ct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmctypesec]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmctypesec](
	[cs_id] [int] IDENTITY(1,1) NOT NULL,
	[cs_access] [bit] NOT NULL,
	[cs_ctid] [int] NOT NULL,
	[cs_ugid] [int] NOT NULL,
 CONSTRAINT [PK_dmctypesec] PRIMARY KEY CLUSTERED 
(
	[cs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcust]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcust](
	[cu_id] [int] IDENTITY(1,1) NOT NULL,
	[cu_prid] [int] NOT NULL,
	[cu_biid] [int] NOT NULL,
	[cu_codenum] [nvarchar](30) NOT NULL,
	[cu_descrip] [nvarchar](200) NOT NULL,
	[cu_price] [numeric](17, 7) NOT NULL,
	[cu_active] [bit] NOT NULL,
	[cu_taxable] [bit] NOT NULL,
	[cu_salfact] [numeric](17, 7) NOT NULL,
	[cu_salunid] [int] NOT NULL,
	[cu_shid] [int] NOT NULL,
	[cu_msdsid] [int] NOT NULL,
	[cu_cofaid] [int] NOT NULL,
	[cu_solabid] [int] NOT NULL,
	[cu_prfact] [numeric](17, 7) NOT NULL,
	[cu_prunid] [int] NOT NULL,
	[cu_notes] [nvarchar](max) NOT NULL,
	[cu_default] [bit] NOT NULL,
	[cu_shelfdays] [numeric](10, 0) NOT NULL,
	[cu_shelfpct] [numeric](10, 0) NOT NULL,
	[cu_qcid] [int] NOT NULL,
	[cu_minsale] [numeric](17, 7) NOT NULL,
	[cu_incsale] [numeric](17, 7) NOT NULL,
	[cu_qcid2] [int] NOT NULL,
	[cu_soquan] [numeric](17, 7) NOT NULL,
	[cu_smid] [int] NOT NULL,
	[cu_smpct] [numeric](17, 2) NOT NULL,
	[cu_samelot] [bit] NOT NULL,
	[cu_linejobqcoverride] [bit] NOT NULL,
 CONSTRAINT [PK_dmcust] PRIMARY KEY CLUSTERED 
(
	[cu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcustlabel]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcustlabel](
	[cl_id] [int] IDENTITY(1,1) NOT NULL,
	[cl_cuid] [int] NOT NULL,
	[cl_rdid] [int] NOT NULL,
	[cl_printlabel] [nvarchar](30) NOT NULL,
	[cl_userexpr] [nvarchar](max) NOT NULL,
	[cl_type] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmcustlabel] PRIMARY KEY CLUSTERED 
(
	[cl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmcwbarcode]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmcwbarcode](
	[cb_id] [int] IDENTITY(1,1) NOT NULL,
	[cb_default] [bit] NOT NULL,
	[cb_active] [bit] NOT NULL,
	[cb_priceend] [int] NOT NULL,
	[cb_pricestart] [int] NOT NULL,
	[cb_partend] [int] NOT NULL,
	[cb_partstart] [int] NOT NULL,
	[cb_length] [int] NOT NULL,
	[cb_name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmcwbarcode] PRIMARY KEY CLUSTERED 
(
	[cb_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmd1]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmd1](
	[d1_id] [int] IDENTITY(1,1) NOT NULL,
	[d1_table] [nvarchar](20) NOT NULL,
	[d1_title] [nvarchar](30) NOT NULL,
	[d1_type] [nvarchar](1) NOT NULL,
	[d1_picture] [nvarchar](30) NOT NULL,
	[d1_require] [bit] NOT NULL,
	[d1_unique] [bit] NOT NULL,
	[d1_min] [numeric](16, 4) NOT NULL,
	[d1_max] [numeric](16, 4) NOT NULL,
	[d1_seq] [numeric](10, 0) NOT NULL,
	[d1_active] [bit] NOT NULL,
	[d1_calc] [bit] NOT NULL,
	[d1_prog] [nvarchar](max) NOT NULL,
	[d1_field] [nvarchar](30) NOT NULL,
	[d1_partforms] [bit] NOT NULL,
	[d1_sort] [bit] NOT NULL,
	[d1_usecaptions] [bit] NOT NULL,
	[d1_firecalcs] [bit] NOT NULL,
	[d1_includeindsd] [bit] NOT NULL,
	[d1_srnumber] [int] NOT NULL,
	[d1_searchboxoverride] [nvarchar](max) NOT NULL,
	[d1_copytobackorder] [bit] NOT NULL,
	[d1_defaultvalue] [nvarchar](30) NOT NULL,
	[d1_defaultmemo] [nvarchar](max) NOT NULL,
	[d1_syncmaster] [bit] NOT NULL,
 CONSTRAINT [PK_dmd1] PRIMARY KEY CLUSTERED 
(
	[d1_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmd3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmd3](
	[d3_d1id] [int] NOT NULL,
	[d3_value] [nvarchar](60) NOT NULL,
	[d3_id] [int] IDENTITY(1,1) NOT NULL,
	[d3_memo] [nvarchar](max) NOT NULL,
	[d3_active] [bit] NOT NULL,
	[d3_c2id] [int] NOT NULL,
	[d3_default] [bit] NOT NULL,
	[d3_c2guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dmd3] PRIMARY KEY CLUSTERED 
(
	[d3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdash]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdash](
	[da_id] [int] IDENTITY(1,1) NOT NULL,
	[da_name] [nvarchar](30) NOT NULL,
	[da_active] [bit] NOT NULL,
	[da_type] [nvarchar](30) NOT NULL,
	[da_mobacctype] [nvarchar](30) NOT NULL,
	[da_gridname] [nvarchar](15) NOT NULL,
	[da_c2id] [int] NOT NULL,
	[da_prefilter] [nvarchar](max) NOT NULL,
	[da_c2guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dmdash] PRIMARY KEY CLUSTERED 
(
	[da_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdash2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdash2](
	[d2_id] [int] IDENTITY(1,1) NOT NULL,
	[d2_daid] [int] NOT NULL,
	[d2_brid] [int] NOT NULL,
	[d2_seq] [int] NOT NULL,
	[d2_start] [nvarchar](30) NOT NULL,
	[d2_end] [nvarchar](30) NOT NULL,
	[d2_descrip] [nvarchar](60) NOT NULL,
	[d2_filters] [nvarchar](max) NOT NULL,
	[d2_gridtype] [nvarchar](30) NOT NULL,
	[d2_display] [nvarchar](max) NOT NULL,
	[d2_formname] [nvarchar](30) NOT NULL,
	[d2_b2id] [int] NOT NULL,
	[d2_folder] [nvarchar](254) NOT NULL,
	[d2_advfilters] [nvarchar](max) NOT NULL,
	[d2_display2] [nvarchar](max) NOT NULL,
	[d2_advfilters2] [nvarchar](max) NOT NULL,
	[d2_favorite] [bit] NOT NULL,
	[d2_grid] [int] NOT NULL,
	[d2_threshold] [nvarchar](30) NOT NULL,
	[d2_thresholdylw] [numeric](17, 7) NOT NULL,
	[d2_thresholdred] [numeric](17, 7) NOT NULL,
	[d2_sortorder] [nvarchar](max) NOT NULL,
	[d2_sortfields] [nvarchar](max) NOT NULL,
	[d2_sortsay] [nvarchar](max) NOT NULL,
	[d2_sumtype] [nvarchar](30) NOT NULL,
	[d2_sumformat] [nvarchar](30) NOT NULL,
	[d2_master] [bit] NOT NULL,
	[d2_jointo] [int] NOT NULL,
	[d2_jointocol] [nvarchar](60) NOT NULL,
	[d2_joinfromcol] [nvarchar](60) NOT NULL,
	[d2_joinalias] [nvarchar](30) NOT NULL,
	[d2_parameters] [nvarchar](max) NOT NULL,
	[d2_customfilters] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmdash2] PRIMARY KEY CLUSTERED 
(
	[d2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdash3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdash3](
	[d3_id] [int] IDENTITY(1,1) NOT NULL,
	[d3_daid] [int] NOT NULL,
	[d3_ugid] [int] NOT NULL,
	[d3_usid] [int] NOT NULL,
 CONSTRAINT [PK_dmdash3] PRIMARY KEY CLUSTERED 
(
	[d3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdashparams]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdashparams](
	[dp_id] [int] IDENTITY(1,1) NOT NULL,
	[dp_d2id] [int] NOT NULL,
	[dp_index] [int] NOT NULL,
	[dp_type] [nvarchar](32) NOT NULL,
	[dp_value] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_dmdashparams] PRIMARY KEY CLUSTERED 
(
	[dp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdeal]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdeal](
	[de_id] [int] IDENTITY(1,1) NOT NULL,
	[de_for] [nvarchar](30) NOT NULL,
	[de_fornum] [int] NOT NULL,
	[de_forname] [nvarchar](60) NOT NULL,
	[de_on] [nvarchar](30) NOT NULL,
	[de_onnum] [int] NOT NULL,
	[de_onname] [nvarchar](30) NOT NULL,
	[de_type] [nvarchar](50) NOT NULL,
	[de_typenum] [numeric](17, 7) NOT NULL,
	[de_minimum] [numeric](17, 7) NOT NULL,
	[de_start] [datetime] NULL,
	[de_end] [datetime] NULL,
	[de_active] [bit] NOT NULL,
	[de_waid] [int] NOT NULL,
	[de_descrip] [nvarchar](60) NOT NULL,
	[de_override] [bit] NOT NULL,
	[de_basedon] [nvarchar](30) NOT NULL,
	[de_unid] [int] NOT NULL,
	[de_minbasis] [nvarchar](30) NOT NULL,
	[de_fcid] [int] NOT NULL,
	[de_frtcost] [numeric](17, 7) NOT NULL,
	[de_minunid] [int] NOT NULL,
	[de_expression] [nvarchar](max) NOT NULL,
	[de_table] [nvarchar](30) NOT NULL,
	[de_reid] [int] NOT NULL,
 CONSTRAINT [PK_dmdeal] PRIMARY KEY CLUSTERED 
(
	[de_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdgrp](
	[dg_name] [nvarchar](30) NOT NULL,
	[dg_id] [int] IDENTITY(1,1) NOT NULL,
	[dg_active] [bit] NOT NULL,
	[dg_default] [bit] NOT NULL,
	[dg_consolidate] [bit] NOT NULL,
	[dg_type] [nvarchar](30) NOT NULL,
	[dg_allpagenum] [bit] NOT NULL,
 CONSTRAINT [PK_dmdgrp] PRIMARY KEY CLUSTERED 
(
	[dg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdgrp2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdgrp2](
	[d2_id] [int] IDENTITY(1,1) NOT NULL,
	[d2_dgid] [int] NOT NULL,
	[d2_report] [nvarchar](30) NOT NULL,
	[d2_seq] [int] NOT NULL,
	[d2_partform] [nvarchar](30) NOT NULL,
	[d2_printwhen] [nvarchar](max) NOT NULL,
	[d2_dcid] [int] NOT NULL,
	[d2_attachedrec] [nvarchar](30) NOT NULL,
	[d2_ptid] [int] NOT NULL,
 CONSTRAINT [PK_dmdgrp2] PRIMARY KEY CLUSTERED 
(
	[d2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdngr]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdngr](
	[dn_id] [int] IDENTITY(1,1) NOT NULL,
	[dn_name] [nvarchar](30) NOT NULL,
	[dn_hazard] [nvarchar](30) NOT NULL,
	[dn_packgroup] [nvarchar](5) NOT NULL,
	[dn_piid] [int] NOT NULL,
	[dn_regnum] [nvarchar](10) NOT NULL,
	[dn_shipname] [nvarchar](155) NOT NULL,
	[dn_active] [bit] NOT NULL,
	[dn_subrisk] [nvarchar](30) NOT NULL,
	[dn_techname] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_dmdngr] PRIMARY KEY CLUSTERED 
(
	[dn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdoccat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdoccat](
	[dc_id] [int] IDENTITY(1,1) NOT NULL,
	[dc_name] [nvarchar](60) NOT NULL,
	[dc_active] [bit] NOT NULL,
	[dc_default] [bit] NOT NULL,
	[dc_esigrequired] [bit] NOT NULL,
 CONSTRAINT [PK_dmdoccat] PRIMARY KEY CLUSTERED 
(
	[dc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdoccat2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdoccat2](
	[d2_access] [bit] NOT NULL,
	[d2_dcid] [int] NOT NULL,
	[d2_id] [int] IDENTITY(1,1) NOT NULL,
	[d2_ugid] [int] NOT NULL,
	[d2_usid] [int] NOT NULL,
 CONSTRAINT [PK_dmdoccat2] PRIMARY KEY CLUSTERED 
(
	[d2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdock]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdock](
	[do_id] [int] IDENTITY(1,1) NOT NULL,
	[do_name] [nvarchar](30) NOT NULL,
	[do_active] [bit] NOT NULL,
	[do_waid] [int] NOT NULL,
	[do_trantype] [nvarchar](30) NOT NULL,
	[do_reid] [int] NOT NULL,
 CONSTRAINT [PK_dmdock] PRIMARY KEY CLUSTERED 
(
	[do_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmdockloc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmdockloc](
	[dl_id] [int] IDENTITY(1,1) NOT NULL,
	[dl_loid] [int] NOT NULL,
	[dl_seq] [int] NOT NULL,
	[dl_doid] [int] NOT NULL,
	[dl_anchor] [bit] NOT NULL,
 CONSTRAINT [PK_dmdockloc] PRIMARY KEY CLUSTERED 
(
	[dl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmecommdoccat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmecommdoccat](
	[ed_id] [int] IDENTITY(1,1) NOT NULL,
	[ed_dcid] [int] NOT NULL,
	[ed_type] [nvarchar](60) NOT NULL,
	[ed_csid] [int] NOT NULL,
 CONSTRAINT [PK_dmecommdoccat] PRIMARY KEY CLUSTERED 
(
	[ed_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmecommprod]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmecommprod](
	[ep_id] [int] IDENTITY(1,1) NOT NULL,
	[ep_name] [nvarchar](60) NOT NULL,
	[ep_descrip] [nvarchar](60) NOT NULL,
	[ep_csid] [int] NOT NULL,
	[ep_notes] [nvarchar](max) NOT NULL,
	[ep_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmecommprod] PRIMARY KEY CLUSTERED 
(
	[ep_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmedi]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmedi](
	[ed_id] [int] IDENTITY(1,1) NOT NULL,
	[ed_name] [nvarchar](30) NOT NULL,
	[ed_ordtype] [nvarchar](1) NOT NULL,
	[ed_auto] [bit] NOT NULL,
	[ed_freq] [numeric](4, 0) NOT NULL,
	[ed_srcpath] [nvarchar](254) NOT NULL,
	[ed_active] [bit] NOT NULL,
	[ed_flddel] [nvarchar](1) NOT NULL,
	[ed_linedel] [nvarchar](1) NOT NULL,
	[ed_fldother] [nvarchar](3) NOT NULL,
	[ed_lineother] [nvarchar](3) NOT NULL,
	[ed_sample] [nvarchar](254) NOT NULL,
	[ed_neword] [nvarchar](max) NOT NULL,
	[ed_newline] [nvarchar](max) NOT NULL,
	[ed_template] [bit] NOT NULL,
	[ed_condtype] [nvarchar](1) NOT NULL,
	[ed_dstpath] [nvarchar](254) NOT NULL,
	[ed_skipline] [nvarchar](max) NOT NULL,
	[ed_ftpserver] [nvarchar](60) NOT NULL,
	[ed_ftpuser] [nvarchar](30) NOT NULL,
	[ed_ftppass] [nvarchar](250) NOT NULL,
	[ed_failpath] [nvarchar](254) NOT NULL,
	[ed_invssl] [bit] NOT NULL,
	[ed_copyheader] [bit] NOT NULL,
	[ed_binary] [bit] NOT NULL,
	[ed_partialprocess] [bit] NOT NULL,
	[ed_sftp] [bit] NOT NULL,
	[ed_skipblanklines] [bit] NOT NULL,
	[ed_type] [nvarchar](1) NOT NULL,
	[ed_ftpport] [int] NOT NULL,
	[ed_deleteline] [nvarchar](max) NOT NULL,
	[ed_notes] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmedi] PRIMARY KEY CLUSTERED 
(
	[ed_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmedi2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmedi2](
	[e2_id] [int] IDENTITY(1,1) NOT NULL,
	[e2_edid] [int] NOT NULL,
	[e2_ifstate] [nvarchar](max) NOT NULL,
	[e2_parsecode] [nvarchar](max) NOT NULL,
	[e2_fldname] [nvarchar](30) NOT NULL,
	[e2_exprtype] [nvarchar](1) NOT NULL,
	[e2_table] [nvarchar](30) NOT NULL,
	[e2_lookexpr] [nvarchar](max) NOT NULL,
	[e2_sameas] [int] NOT NULL,
 CONSTRAINT [PK_dmedi2] PRIMARY KEY CLUSTERED 
(
	[e2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmedi3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmedi3](
	[e3_id] [int] IDENTITY(1,1) NOT NULL,
	[e3_date] [datetime] NULL,
	[e3_time] [numeric](4, 0) NOT NULL,
	[e3_file] [nvarchar](100) NOT NULL,
	[e3_result] [bit] NOT NULL,
	[e3_error] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmedi3] PRIMARY KEY CLUSTERED 
(
	[e3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmemail]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmemail](
	[em_name] [nvarchar](30) NOT NULL,
	[em_active] [bit] NOT NULL,
	[em_subject] [nvarchar](100) NOT NULL,
	[em_body] [nvarchar](max) NOT NULL,
	[em_id] [int] IDENTITY(1,1) NOT NULL,
	[em_html] [bit] NOT NULL,
	[em_footer] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmemail] PRIMARY KEY CLUSTERED 
(
	[em_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmemail2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmemail2](
	[e2_id] [int] IDENTITY(1,1) NOT NULL,
	[e2_emid] [int] NOT NULL,
	[e2_piid] [int] NOT NULL,
	[e2_seq] [int] NOT NULL,
 CONSTRAINT [PK_dmemail2] PRIMARY KEY CLUSTERED 
(
	[e2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmeng]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmeng](
	[en_id] [int] IDENTITY(1,1) NOT NULL,
	[en_name] [nvarchar](30) NOT NULL,
	[en_active] [bit] NOT NULL,
	[en_default] [bit] NOT NULL,
	[en_path] [nvarchar](254) NOT NULL,
	[en_labcalc] [nvarchar](max) NOT NULL,
	[en_burden] [numeric](4, 0) NOT NULL,
	[en_type] [nvarchar](30) NOT NULL,
	[en_database] [nvarchar](60) NOT NULL,
	[en_engpkg] [nvarchar](30) NOT NULL,
	[en_prid] [int] NOT NULL,
	[en_groupby] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmeng] PRIMARY KEY CLUSTERED 
(
	[en_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmengfields]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmengfields](
	[ef_fieldname] [nvarchar](60) NOT NULL,
	[ef_userfield] [nvarchar](60) NOT NULL,
	[ef_enid] [int] NOT NULL,
	[ef_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dmengfields] PRIMARY KEY CLUSTERED 
(
	[ef_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmexai]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmexai](
	[ex_id] [int] IDENTITY(1,1) NOT NULL,
	[ex_active] [bit] NOT NULL,
	[ex_ai] [int] NOT NULL,
	[ex_form] [nvarchar](30) NOT NULL,
	[ex_type] [nvarchar](30) NOT NULL,
	[ex_toai] [int] NOT NULL,
	[ex_table] [nvarchar](30) NOT NULL,
	[ex_recid] [int] NOT NULL,
	[ex_unid] [int] NOT NULL,
 CONSTRAINT [PK_dmexai] PRIMARY KEY CLUSTERED 
(
	[ex_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmexcl]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmexcl](
	[ex_id] [int] IDENTITY(1,1) NOT NULL,
	[ex_name] [nvarchar](30) NOT NULL,
	[ex_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmexcl] PRIMARY KEY CLUSTERED 
(
	[ex_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmexcl2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmexcl2](
	[e2_id] [int] IDENTITY(1,1) NOT NULL,
	[e2_exid] [int] NOT NULL,
	[e2_prid] [int] NOT NULL,
 CONSTRAINT [PK_dmexcl2] PRIMARY KEY CLUSTERED 
(
	[e2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmexpprof]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmexpprof](
	[ep_id] [int] IDENTITY(1,1) NOT NULL,
	[ep_name] [nvarchar](30) NOT NULL,
	[ep_type] [int] NOT NULL,
	[ep_active] [bit] NOT NULL,
	[ep_default] [bit] NOT NULL,
	[ep_dsttype] [int] NOT NULL,
	[ep_dstpath] [nvarchar](250) NOT NULL,
	[ep_dstfile] [nvarchar](max) NOT NULL,
	[ep_details] [bit] NOT NULL,
	[ep_formattype] [int] NOT NULL,
	[ep_format] [nvarchar](max) NOT NULL,
	[ep_formatid] [int] NOT NULL,
	[ep_server] [nvarchar](250) NOT NULL,
	[ep_port] [nvarchar](30) NOT NULL,
	[ep_username] [nvarchar](250) NOT NULL,
	[ep_password] [nvarchar](250) NOT NULL,
 CONSTRAINT [PK_dmexpprof] PRIMARY KEY CLUSTERED 
(
	[ep_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfactran]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfactran](
	[ft_id] [int] IDENTITY(1,1) NOT NULL,
	[ft_waid1] [int] NOT NULL,
	[ft_waid2] [int] NOT NULL,
	[ft_leaddays] [int] NOT NULL,
	[ft_useleaddays] [bit] NOT NULL,
	[ft_elimcredit] [int] NOT NULL,
	[ft_elimdebit] [int] NOT NULL,
	[ft_active] [bit] NOT NULL,
	[ft_seq] [int] NOT NULL,
	[ft_for] [nvarchar](30) NOT NULL,
	[ft_fornum] [int] NOT NULL,
	[ft_icxmrp] [nvarchar](30) NOT NULL,
	[ft_crossrevict] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmfactran] PRIMARY KEY CLUSTERED 
(
	[ft_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfcur]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfcur](
	[fc_id] [int] IDENTITY(1,1) NOT NULL,
	[fc_name] [nvarchar](30) NOT NULL,
	[fc_rate] [numeric](17, 7) NOT NULL,
	[fc_active] [bit] NOT NULL,
	[fc_default] [bit] NOT NULL,
	[fc_symbol] [nvarchar](30) NOT NULL,
	[fc_prtsay] [nvarchar](30) NOT NULL,
	[fc_currgain] [int] NOT NULL,
	[fc_autoconv] [bit] NOT NULL,
 CONSTRAINT [PK_dmfcur] PRIMARY KEY CLUSTERED 
(
	[fc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfcur2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfcur2](
	[f2_fcid] [int] NOT NULL,
	[f2_id] [int] IDENTITY(1,1) NOT NULL,
	[f2_rate] [numeric](17, 7) NOT NULL,
	[f2_date] [datetime] NULL,
 CONSTRAINT [PK_dmfcur2] PRIMARY KEY CLUSTERED 
(
	[f2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfeat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfeat](
	[fe_id] [int] IDENTITY(1,1) NOT NULL,
	[fe_name] [nvarchar](60) NOT NULL,
	[fe_active] [bit] NOT NULL,
	[fe_quant] [numeric](17, 7) NOT NULL,
	[fe_endpt] [bit] NOT NULL,
	[fe_price] [numeric](17, 7) NOT NULL,
	[fe_notes] [nvarchar](max) NOT NULL,
	[fe_multiple] [bit] NOT NULL,
	[fe_comm] [bit] NOT NULL,
	[fe_usedeals] [bit] NOT NULL,
	[fe_usepromos] [bit] NOT NULL,
	[fe_required] [bit] NOT NULL,
	[fe_suffix] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_dmfeat] PRIMARY KEY CLUSTERED 
(
	[fe_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfeat2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfeat2](
	[f2_id] [int] IDENTITY(1,1) NOT NULL,
	[f2_parent] [int] NOT NULL,
	[f2_child] [int] NOT NULL,
	[f2_prid] [int] NOT NULL,
	[f2_seq] [numeric](10, 0) NOT NULL,
	[f2_prid2] [int] NOT NULL,
	[f2_caid] [int] NOT NULL,
	[f2_c2id] [int] NOT NULL,
	[f2_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmfeat2] PRIMARY KEY CLUSTERED 
(
	[f2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfeat3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfeat3](
	[f3_id] [int] IDENTITY(1,1) NOT NULL,
	[f3_prid] [int] NOT NULL,
	[f3_feid] [int] NOT NULL,
 CONSTRAINT [PK_dmfeat3] PRIMARY KEY CLUSTERED 
(
	[f3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfeat4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfeat4](
	[f4_id] [int] IDENTITY(1,1) NOT NULL,
	[f4_parent] [int] NOT NULL,
	[f4_child] [int] NOT NULL,
	[f4_childvalue] [int] NOT NULL,
	[f4_parentvalue] [int] NOT NULL,
	[f4_exclude] [bit] NOT NULL,
	[f4_nocost] [bit] NOT NULL,
	[f4_caid] [int] NOT NULL,
	[f4_c2id] [int] NOT NULL,
	[f4_prid] [int] NOT NULL,
 CONSTRAINT [PK_dmfeat4] PRIMARY KEY CLUSTERED 
(
	[f4_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfeat5]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfeat5](
	[f5_id] [int] IDENTITY(1,1) NOT NULL,
	[f5_table] [nvarchar](30) NOT NULL,
	[f5_recid] [int] NOT NULL,
	[f5_feid] [int] NOT NULL,
	[f5_feid2] [int] NOT NULL,
 CONSTRAINT [PK_dmfeat5] PRIMARY KEY CLUSTERED 
(
	[f5_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfeat6]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfeat6](
	[f6_id] [int] IDENTITY(1,1) NOT NULL,
	[f6_prid] [int] NOT NULL,
	[f6_price] [numeric](17, 7) NOT NULL,
	[f6_avail] [nvarchar](30) NOT NULL,
	[f6_quant] [numeric](17, 7) NOT NULL,
	[f6_notes] [nvarchar](max) NOT NULL,
	[f6_f2id] [int] NOT NULL,
	[f6_parent] [int] NOT NULL,
	[f6_caid] [int] NOT NULL,
	[f6_c2id] [int] NOT NULL,
	[f6_comm] [bit] NOT NULL,
	[f6_activeover] [int] NOT NULL,
	[f6_start] [datetime] NULL,
	[f6_end] [datetime] NULL,
 CONSTRAINT [PK_dmfeat6] PRIMARY KEY CLUSTERED 
(
	[f6_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfilt]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfilt](
	[fi_id] [int] IDENTITY(1,1) NOT NULL,
	[fi_name] [nvarchar](30) NOT NULL,
	[fi_usid] [int] NOT NULL,
	[fi_layout] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmfilt] PRIMARY KEY CLUSTERED 
(
	[fi_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfilt2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfilt2](
	[f2_id] [int] IDENTITY(1,1) NOT NULL,
	[f2_field] [nvarchar](30) NOT NULL,
	[f2_logical] [nvarchar](3) NOT NULL,
	[f2_oper] [nvarchar](15) NOT NULL,
	[f2_value] [nvarchar](254) NOT NULL,
	[f2_fiid] [int] NOT NULL,
	[f2_type] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmfilt2] PRIMARY KEY CLUSTERED 
(
	[f2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfiltsort]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfiltsort](
	[fs_id] [int] IDENTITY(1,1) NOT NULL,
	[fs_field] [nvarchar](30) NOT NULL,
	[fs_order] [nvarchar](4) NOT NULL,
	[fs_fiid] [int] NOT NULL,
	[fs_seq] [int] NOT NULL,
 CONSTRAINT [PK_dmfiltsort] PRIMARY KEY CLUSTERED 
(
	[fs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfin]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfin](
	[fi_id] [int] IDENTITY(1,1) NOT NULL,
	[fi_name] [nvarchar](30) NOT NULL,
	[fi_active] [bit] NOT NULL,
	[fi_header] [nvarchar](max) NOT NULL,
	[fi_report] [nvarchar](30) NOT NULL,
	[fi_type] [nvarchar](30) NOT NULL,
	[fi_display] [nvarchar](1) NOT NULL,
	[fi_fgid] [int] NOT NULL,
	[fi_mask] [nvarchar](30) NOT NULL,
	[fi_footer] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmfin] PRIMARY KEY CLUSTERED 
(
	[fi_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfin2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfin2](
	[f2_id] [int] IDENTITY(1,1) NOT NULL,
	[f2_fiid] [int] NOT NULL,
	[f2_title] [nvarchar](100) NOT NULL,
	[f2_sorter] [numeric](10, 0) NOT NULL,
	[f2_format] [nvarchar](30) NOT NULL,
	[f2_extra] [numeric](1, 0) NOT NULL,
	[f2_indent] [numeric](2, 0) NOT NULL,
	[f2_reverse] [bit] NOT NULL,
	[f2_account] [nvarchar](max) NOT NULL,
	[f2_currsign] [bit] NOT NULL,
	[f2_calcname] [nvarchar](30) NOT NULL,
	[f2_calcexpr] [nvarchar](30) NOT NULL,
	[f2_visible] [bit] NOT NULL,
	[f2_hidezero] [bit] NOT NULL,
	[f2_pos] [numeric](10, 0) NOT NULL,
	[f2_posval] [nvarchar](max) NOT NULL,
	[f2_bold] [bit] NOT NULL,
	[f2_baltype] [nvarchar](1) NOT NULL,
	[f2_underline] [nvarchar](30) NOT NULL,
	[f2_expression] [nvarchar](max) NOT NULL,
	[f2_display] [nvarchar](30) NOT NULL,
	[f2_mask] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmfin2] PRIMARY KEY CLUSTERED 
(
	[f2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfingrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfingrp](
	[fg_id] [int] IDENTITY(1,1) NOT NULL,
	[fg_name] [nvarchar](30) NOT NULL,
	[fg_active] [bit] NOT NULL,
	[fg_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmfingrp] PRIMARY KEY CLUSTERED 
(
	[fg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfingrp2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfingrp2](
	[f2_id] [int] IDENTITY(1,1) NOT NULL,
	[f2_fgid] [int] NOT NULL,
	[f2_ugid] [int] NOT NULL,
	[f2_access] [bit] NOT NULL,
	[f2_usid] [int] NOT NULL,
 CONSTRAINT [PK_dmfingrp2] PRIMARY KEY CLUSTERED 
(
	[f2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmforecast]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmforecast](
	[fo_id] [int] IDENTITY(1,1) NOT NULL,
	[fo_name] [nvarchar](30) NOT NULL,
	[fo_notes] [nvarchar](max) NOT NULL,
	[fo_active] [bit] NOT NULL,
	[fo_usid] [int] NOT NULL,
	[fo_bucktype] [nvarchar](30) NOT NULL,
	[fo_fcid] [int] NOT NULL,
	[fo_fcrate] [numeric](17, 7) NOT NULL,
	[fo_mrpbucktype] [nvarchar](30) NOT NULL,
	[fo_mrpbuckdate] [nvarchar](30) NOT NULL,
	[fo_exmrp] [bit] NOT NULL,
	[fo_created] [datetime] NULL,
	[fo_incmrp] [bit] NOT NULL,
	[fo_bucketcount] [int] NOT NULL,
 CONSTRAINT [PK_dmforecast] PRIMARY KEY CLUSTERED 
(
	[fo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmforecast2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmforecast2](
	[f2_id] [int] IDENTITY(1,1) NOT NULL,
	[f2_foid] [int] NOT NULL,
	[f2_date] [datetime] NULL,
	[f2_quant] [numeric](17, 7) NOT NULL,
	[f2_prid] [int] NOT NULL,
	[f2_biid] [int] NOT NULL,
	[f2_shid] [int] NOT NULL,
	[f2_waid] [int] NOT NULL,
	[f2_price] [numeric](17, 7) NOT NULL,
	[f2_origquant] [numeric](17, 7) NOT NULL,
	[f2_stderr] [numeric](17, 7) NOT NULL,
	[f2_historical] [bit] NOT NULL,
 CONSTRAINT [PK_dmforecast2] PRIMARY KEY CLUSTERED 
(
	[f2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmforecastdateex]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmforecastdateex](
	[fd_date] [datetime] NULL,
	[fd_day] [nvarchar](30) NOT NULL,
	[fd_id] [int] IDENTITY(1,1) NOT NULL,
	[fd_foid] [int] NOT NULL,
 CONSTRAINT [PK_dmforecastdateex] PRIMARY KEY CLUSTERED 
(
	[fd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmform]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmform](
	[fo_name] [nvarchar](30) NOT NULL,
	[fo_id] [int] IDENTITY(1,1) NOT NULL,
	[fo_active] [bit] NOT NULL,
	[fo_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmform] PRIMARY KEY CLUSTERED 
(
	[fo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfrominv]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfrominv](
	[fr_frominvprid] [int] NOT NULL,
	[fr_id] [int] IDENTITY(1,1) NOT NULL,
	[fr_prid] [int] NOT NULL,
	[fr_type] [nvarchar](30) NOT NULL,
	[fr_markup] [numeric](17, 7) NOT NULL,
	[fr_quantexpr] [nvarchar](max) NOT NULL,
	[fr_facilityfilter] [int] NOT NULL,
	[fr_catchwgt] [nvarchar](30) NOT NULL,
	[fr_notesexpr] [nvarchar](max) NOT NULL,
	[fr_bymasterlot] [bit] NOT NULL,
 CONSTRAINT [PK_dmfrominv] PRIMARY KEY CLUSTERED 
(
	[fr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmfrt]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmfrt](
	[fr_id] [int] IDENTITY(1,1) NOT NULL,
	[fr_name] [nvarchar](30) NOT NULL,
	[fr_dfltar] [bit] NOT NULL,
	[fr_dfltap] [bit] NOT NULL,
	[fr_active] [bit] NOT NULL,
	[fr_arap] [nvarchar](10) NOT NULL,
	[fr_retain] [bit] NOT NULL,
	[fr_easypost] [bit] NOT NULL,
	[fr_easypostsig] [bit] NOT NULL,
	[fr_easypostprompt] [nvarchar](30) NOT NULL,
	[fr_easypostemail] [bit] NOT NULL,
	[fr_easypostsms] [bit] NOT NULL,
	[fr_easypostexpr] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmfrt] PRIMARY KEY CLUSTERED 
(
	[fr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmgiftcard]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmgiftcard](
	[gc_amount] [numeric](17, 7) NOT NULL,
	[gc_id] [int] IDENTITY(1,1) NOT NULL,
	[gc_number] [numeric](30, 0) NOT NULL,
	[gc_created] [datetime] NULL,
	[gc_closed] [datetime] NULL,
 CONSTRAINT [PK_dmgiftcard] PRIMARY KEY CLUSTERED 
(
	[gc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmgraph]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmgraph](
	[gr_id] [int] IDENTITY(1,1) NOT NULL,
	[gr_usid] [int] NOT NULL,
	[gr_type] [int] NOT NULL,
	[gr_sumtitle] [nvarchar](30) NOT NULL,
	[gr_groupontitle] [nvarchar](30) NOT NULL,
	[gr_groupby] [nvarchar](30) NOT NULL,
	[gr_pgid] [int] NOT NULL,
	[gr_graphbytitle] [nvarchar](30) NOT NULL,
	[gr_d2id] [int] NOT NULL,
	[gr_name] [nvarchar](30) NOT NULL,
	[gr_sumsmask] [nvarchar](30) NOT NULL,
	[gr_graphbyfield] [nvarchar](30) NOT NULL,
	[gr_sumfield] [nvarchar](30) NOT NULL,
	[gr_grouponfield] [nvarchar](30) NOT NULL,
	[gr_numfinperiods] [int] NOT NULL,
	[gr_thresholdred] [numeric](17, 7) NOT NULL,
	[gr_thresholdylw] [numeric](17, 7) NOT NULL,
	[gr_sortby] [nvarchar](30) NOT NULL,
	[gr_calc] [nvarchar](max) NOT NULL,
	[gr_futfinperiods] [int] NOT NULL,
	[gr_graphbyexp] [nvarchar](max) NOT NULL,
	[gr_grouponexp] [nvarchar](max) NOT NULL,
	[gr_cutoutpercent] [int] NOT NULL,
	[gr_swapaxes] [bit] NOT NULL,
	[gr_trendlines] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmgraph] PRIMARY KEY CLUSTERED 
(
	[gr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmgrp](
	[gr_id] [int] IDENTITY(1,1) NOT NULL,
	[gr_name] [nvarchar](30) NOT NULL,
	[gr_active] [bit] NOT NULL,
	[gr_default] [bit] NOT NULL,
	[gr_pastday] [numeric](10, 0) NOT NULL,
	[gr_exday] [numeric](10, 0) NOT NULL,
	[gr_credlim] [numeric](12, 0) NOT NULL,
	[gr_exceed] [numeric](10, 0) NOT NULL,
	[gr_credhld] [datetime] NULL,
	[gr_collect] [nvarchar](max) NOT NULL,
	[gr_lastcred] [datetime] NULL,
	[gr_credflag] [bit] NOT NULL,
	[gr_creddueshipdays] [int] NOT NULL,
 CONSTRAINT [PK_dmgrp] PRIMARY KEY CLUSTERED 
(
	[gr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmimpgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmimpgrp](
	[ig_id] [int] IDENTITY(1,1) NOT NULL,
	[ig_name] [nvarchar](30) NOT NULL,
	[ig_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmimpgrp] PRIMARY KEY CLUSTERED 
(
	[ig_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmimpgrp2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmimpgrp2](
	[g2_id] [int] IDENTITY(1,1) NOT NULL,
	[g2_imid] [int] NOT NULL,
	[g2_igid] [int] NOT NULL,
	[g2_sort] [int] NOT NULL,
 CONSTRAINT [PK_dmimpgrp2] PRIMARY KEY CLUSTERED 
(
	[g2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmimport]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmimport](
	[im_id] [int] IDENTITY(1,1) NOT NULL,
	[im_name] [nvarchar](60) NOT NULL,
	[im_srcfile] [nvarchar](max) NOT NULL,
	[im_srctype] [nvarchar](30) NOT NULL,
	[im_dsttbl] [nvarchar](30) NOT NULL,
	[im_srctbl] [nvarchar](100) NOT NULL,
	[im_condition] [nvarchar](max) NOT NULL,
	[im_dbpass] [nvarchar](255) NOT NULL,
	[im_dbserver] [nvarchar](30) NOT NULL,
	[im_dbname] [nvarchar](30) NOT NULL,
	[im_dbuser] [nvarchar](30) NOT NULL,
	[im_update] [nvarchar](10) NOT NULL,
	[im_expires] [datetime] NULL,
	[im_active] [bit] NOT NULL,
	[im_freq] [int] NOT NULL,
	[im_notes] [nvarchar](max) NOT NULL,
	[im_seq] [int] NOT NULL,
 CONSTRAINT [PK_dmimport] PRIMARY KEY CLUSTERED 
(
	[im_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmimport2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmimport2](
	[i2_id] [int] IDENTITY(1,1) NOT NULL,
	[i2_dstfld] [nvarchar](30) NOT NULL,
	[i2_fldexpr] [nvarchar](max) NOT NULL,
	[i2_imid] [int] NOT NULL,
	[i2_reqd] [bit] NOT NULL,
	[i2_desig] [bit] NOT NULL,
	[i2_relfld] [nvarchar](30) NOT NULL,
	[i2_addrec] [bit] NOT NULL,
	[i2_skip] [bit] NOT NULL,
 CONSTRAINT [PK_dmimport2] PRIMARY KEY CLUSTERED 
(
	[i2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmimport3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmimport3](
	[i3_dbname] [nvarchar](60) NOT NULL,
	[i3_dbpass] [nvarchar](255) NOT NULL,
	[i3_dbserver] [nvarchar](30) NOT NULL,
	[i3_dbuser] [nvarchar](30) NOT NULL,
	[i3_id] [int] IDENTITY(1,1) NOT NULL,
	[i3_imid] [int] NOT NULL,
	[i3_srcfile] [nvarchar](max) NOT NULL,
	[i3_srctbl] [nvarchar](100) NOT NULL,
	[i3_srctype] [nvarchar](30) NOT NULL,
	[i3_mapfrom] [nvarchar](max) NOT NULL,
	[i3_mapto] [nvarchar](max) NOT NULL,
	[i3_maptable] [nvarchar](30) NOT NULL,
	[i3_sql] [nvarchar](max) NOT NULL,
	[i3_notes] [nvarchar](max) NOT NULL,
	[i3_dbtable] [nvarchar](max) NOT NULL,
	[i3_sheet] [int] NOT NULL,
	[i3_dstpath] [nvarchar](254) NOT NULL,
	[i3_srcpath] [nvarchar](254) NOT NULL,
 CONSTRAINT [PK_dmimport3] PRIMARY KEY CLUSTERED 
(
	[i3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmimportsched]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmimportsched](
	[is_id] [int] IDENTITY(1,1) NOT NULL,
	[is_active] [bit] NOT NULL,
	[is_lastrun] [datetime] NULL,
	[is_imid] [int] NOT NULL,
	[is_name] [nvarchar](60) NOT NULL,
	[is_type] [nvarchar](10) NOT NULL,
	[is_day] [int] NOT NULL,
	[is_time] [nvarchar](8) NOT NULL,
	[is_nextrun] [datetime] NULL,
	[is_schedtype] [nvarchar](30) NOT NULL,
	[is_minutes] [numeric](4, 0) NOT NULL,
	[is_recid] [int] NOT NULL,
	[is_seq] [int] NOT NULL,
 CONSTRAINT [PK_dmimportsched] PRIMARY KEY CLUSTERED 
(
	[is_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmjcat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmjcat](
	[jc_id] [int] IDENTITY(1,1) NOT NULL,
	[jc_name] [nvarchar](30) NOT NULL,
	[jc_active] [bit] NOT NULL,
	[jc_default] [bit] NOT NULL,
	[jc_issuetype] [nvarchar](30) NOT NULL,
	[jc_jobstage] [int] NOT NULL,
	[jc_esigtype] [nvarchar](30) NOT NULL,
	[jc_issuejobfin] [bit] NOT NULL,
	[jc_esigcounts] [int] NOT NULL,
 CONSTRAINT [PK_dmjcat] PRIMARY KEY CLUSTERED 
(
	[jc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmlab]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmlab](
	[la_id] [int] IDENTITY(1,1) NOT NULL,
	[la_name] [nvarchar](30) NOT NULL,
	[la_active] [bit] NOT NULL,
	[la_weekot] [numeric](3, 0) NOT NULL,
	[la_dayot] [numeric](3, 0) NOT NULL,
	[la_otfactr] [numeric](5, 2) NOT NULL,
	[la_earlyin] [numeric](4, 0) NOT NULL,
	[la_earlyout] [numeric](4, 0) NOT NULL,
	[la_latein] [numeric](4, 0) NOT NULL,
	[la_lateout] [numeric](4, 0) NOT NULL,
	[la_mealin3] [numeric](4, 0) NOT NULL,
	[la_mealin] [numeric](4, 0) NOT NULL,
	[la_mealin2] [numeric](4, 0) NOT NULL,
	[la_mealin4] [numeric](4, 0) NOT NULL,
	[la_nostart] [numeric](4, 0) NOT NULL,
	[la_actin] [numeric](4, 0) NOT NULL,
	[la_actout] [numeric](4, 0) NOT NULL,
	[la_actin2] [numeric](4, 0) NOT NULL,
	[la_actin3] [numeric](4, 0) NOT NULL,
	[la_actin4] [numeric](4, 0) NOT NULL,
	[la_actin5] [numeric](4, 0) NOT NULL,
	[la_actout2] [numeric](4, 0) NOT NULL,
	[la_actout3] [numeric](4, 0) NOT NULL,
	[la_actout4] [numeric](4, 0) NOT NULL,
	[la_actout5] [numeric](4, 0) NOT NULL,
	[la_mealin5] [numeric](4, 0) NOT NULL,
	[la_earlyin2] [numeric](4, 0) NOT NULL,
	[la_earlyin3] [numeric](4, 0) NOT NULL,
	[la_earlyin4] [numeric](4, 0) NOT NULL,
	[la_earlyin5] [numeric](4, 0) NOT NULL,
	[la_earlyout2] [numeric](4, 0) NOT NULL,
	[la_earlyout3] [numeric](4, 0) NOT NULL,
	[la_earlyout4] [numeric](4, 0) NOT NULL,
	[la_earlyout5] [numeric](4, 0) NOT NULL,
	[la_latein2] [numeric](4, 0) NOT NULL,
	[la_latein3] [numeric](4, 0) NOT NULL,
	[la_latein4] [numeric](4, 0) NOT NULL,
	[la_latein5] [numeric](4, 0) NOT NULL,
	[la_lateout2] [numeric](4, 0) NOT NULL,
	[la_lateout3] [numeric](4, 0) NOT NULL,
	[la_lateout4] [numeric](4, 0) NOT NULL,
	[la_lateout5] [numeric](4, 0) NOT NULL,
	[la_actin6] [numeric](4, 0) NOT NULL,
	[la_actin7] [numeric](4, 0) NOT NULL,
	[la_actout6] [numeric](4, 0) NOT NULL,
	[la_actout7] [numeric](4, 0) NOT NULL,
	[la_earlyin6] [numeric](4, 0) NOT NULL,
	[la_earlyin7] [numeric](4, 0) NOT NULL,
	[la_earlyout6] [numeric](4, 0) NOT NULL,
	[la_earlyout7] [numeric](4, 0) NOT NULL,
	[la_latein6] [numeric](4, 0) NOT NULL,
	[la_latein7] [numeric](4, 0) NOT NULL,
	[la_lateout6] [numeric](4, 0) NOT NULL,
	[la_lateout7] [numeric](4, 0) NOT NULL,
	[la_mealin6] [numeric](4, 0) NOT NULL,
	[la_mealin7] [numeric](4, 0) NOT NULL,
	[la_mealout] [numeric](4, 0) NOT NULL,
	[la_mealout2] [numeric](4, 0) NOT NULL,
	[la_mealout3] [numeric](4, 0) NOT NULL,
	[la_mealout4] [numeric](4, 0) NOT NULL,
	[la_mealout5] [numeric](4, 0) NOT NULL,
	[la_mealout6] [numeric](4, 0) NOT NULL,
	[la_mealout7] [numeric](4, 0) NOT NULL,
	[la_nostart2] [numeric](4, 0) NOT NULL,
	[la_nostart3] [numeric](4, 0) NOT NULL,
	[la_nostart4] [numeric](4, 0) NOT NULL,
	[la_nostart5] [numeric](4, 0) NOT NULL,
	[la_nostart6] [numeric](4, 0) NOT NULL,
	[la_nostart7] [numeric](4, 0) NOT NULL,
	[la_frominvprid] [int] NOT NULL,
	[la_ceid] [int] NOT NULL,
	[la_opid] [int] NOT NULL,
	[la_joid] [int] NOT NULL,
	[la_autologout] [numeric](10, 2) NOT NULL,
	[la_otchid] [int] NOT NULL,
 CONSTRAINT [PK_dmlab] PRIMARY KEY CLUSTERED 
(
	[la_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmlabel]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmlabel](
	[la_id] [int] IDENTITY(1,1) NOT NULL,
	[la_prid] [int] NOT NULL,
	[la_rdid] [int] NOT NULL,
	[la_type] [nvarchar](30) NOT NULL,
	[la_printlabel] [nvarchar](30) NOT NULL,
	[la_userexpr] [nvarchar](max) NOT NULL,
	[la_parttype] [int] NOT NULL,
	[la_copies] [int] NOT NULL,
	[la_app] [nvarchar](13) NOT NULL,
	[la_prtdfltqty] [bit] NOT NULL,
 CONSTRAINT [PK_dmlabel] PRIMARY KEY CLUSTERED 
(
	[la_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmlatlng]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmlatlng](
	[ll_id] [int] IDENTITY(1,1) NOT NULL,
	[ll_address] [nvarchar](255) NOT NULL,
	[ll_lat] [numeric](17, 7) NOT NULL,
	[ll_lng] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dmlatlng] PRIMARY KEY CLUSTERED 
(
	[ll_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmletter]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmletter](
	[le_id] [int] IDENTITY(1,1) NOT NULL,
	[le_name] [nvarchar](250) NOT NULL,
	[le_doc] [nvarchar](max) NOT NULL,
	[le_table] [nvarchar](30) NOT NULL,
	[le_active] [bit] NOT NULL,
	[le_reid] [int] NOT NULL,
 CONSTRAINT [PK_dmletter] PRIMARY KEY CLUSTERED 
(
	[le_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmlinkdoc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmlinkdoc](
	[li_id] [int] IDENTITY(1,1) NOT NULL,
	[li_active] [bit] NOT NULL,
	[li_sourcepath] [nvarchar](254) NOT NULL,
	[li_destpath] [nvarchar](254) NOT NULL,
	[li_failpath] [nvarchar](254) NOT NULL,
	[li_freq] [int] NOT NULL,
	[li_name] [nvarchar](30) NOT NULL,
	[li_dcid] [int] NOT NULL,
	[li_table] [nvarchar](30) NOT NULL,
	[li_field] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmlinkdoc] PRIMARY KEY CLUSTERED 
(
	[li_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmloc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmloc](
	[lo_id] [int] IDENTITY(1,1) NOT NULL,
	[lo_name] [nvarchar](30) NOT NULL,
	[lo_active] [bit] NOT NULL,
	[lo_ltid] [int] NOT NULL,
	[lo_default] [bit] NOT NULL,
	[lo_capacity] [numeric](17, 7) NOT NULL,
	[lo_capunid] [int] NOT NULL,
	[lo_haltposting] [bit] NOT NULL,
	[lo_seq] [int] NOT NULL,
	[lo_descrip] [nvarchar](100) NOT NULL,
	[lo_repmin] [numeric](17, 7) NOT NULL,
	[lo_counted] [datetime] NULL,
 CONSTRAINT [PK_dmloc] PRIMARY KEY CLUSTERED 
(
	[lo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmlocsort]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmlocsort](
	[ls_id] [int] IDENTITY(1,1) NOT NULL,
	[ls_pyid] [int] NOT NULL,
	[ls_loid] [int] NOT NULL,
	[ls_seq] [int] NOT NULL,
	[ls_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmlocsort] PRIMARY KEY CLUSTERED 
(
	[ls_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmloctype]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmloctype](
	[lt_id] [int] IDENTITY(1,1) NOT NULL,
	[lt_name] [nvarchar](30) NOT NULL,
	[lt_active] [bit] NOT NULL,
	[lt_default] [bit] NOT NULL,
	[lt_waid] [int] NOT NULL,
	[lt_neginv] [nvarchar](30) NOT NULL,
	[lt_haltposting] [bit] NOT NULL,
 CONSTRAINT [PK_dmloctype] PRIMARY KEY CLUSTERED 
(
	[lt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmmarkets]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmmarkets](
	[ma_id] [int] IDENTITY(1,1) NOT NULL,
	[ma_name] [nvarchar](120) NOT NULL,
	[ma_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmmarkets] PRIMARY KEY CLUSTERED 
(
	[ma_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmmarketsubs]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmmarketsubs](
	[ms_id] [int] IDENTITY(1,1) NOT NULL,
	[ms_maid] [int] NOT NULL,
	[ms_name] [nvarchar](120) NOT NULL,
	[ms_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmmarketsubs] PRIMARY KEY CLUSTERED 
(
	[ms_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmmoverule]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmmoverule](
	[mr_id] [int] IDENTITY(1,1) NOT NULL,
	[mr_name] [nvarchar](60) NOT NULL,
	[mr_active] [bit] NOT NULL,
	[mr_waid] [int] NOT NULL,
	[mr_trantype] [nvarchar](30) NOT NULL,
	[mr_fromzone] [int] NOT NULL,
	[mr_zonerestrict] [bit] NOT NULL,
	[mr_singleso] [bit] NOT NULL,
 CONSTRAINT [PK_dmmoverule] PRIMARY KEY CLUSTERED 
(
	[mr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmmoverulesort]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmmoverulesort](
	[rs_id] [int] IDENTITY(1,1) NOT NULL,
	[rs_mrid] [int] NOT NULL,
	[rs_seq] [int] NOT NULL,
	[rs_sort] [nvarchar](60) NOT NULL,
	[rs_expression] [nvarchar](max) NOT NULL,
	[rs_sortorder] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmmoverulesort] PRIMARY KEY CLUSTERED 
(
	[rs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmmrogrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmmrogrp](
	[mg_id] [int] IDENTITY(1,1) NOT NULL,
	[mg_name] [nvarchar](30) NOT NULL,
	[mg_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmmrogrp] PRIMARY KEY CLUSTERED 
(
	[mg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmmrpgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmmrpgrp](
	[mg_id] [int] IDENTITY(1,1) NOT NULL,
	[mg_name] [nvarchar](30) NOT NULL,
	[mg_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmmrpgrp] PRIMARY KEY CLUSTERED 
(
	[mg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmnote]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmnote](
	[no_id] [int] IDENTITY(1,1) NOT NULL,
	[no_name] [nvarchar](30) NOT NULL,
	[no_note] [nvarchar](max) NOT NULL,
	[no_active] [bit] NOT NULL,
	[no_category] [nvarchar](30) NOT NULL,
	[no_newline] [bit] NOT NULL,
 CONSTRAINT [PK_dmnote] PRIMARY KEY CLUSTERED 
(
	[no_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmop]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmop](
	[op_id] [int] IDENTITY(1,1) NOT NULL,
	[op_name] [nvarchar](30) NOT NULL,
	[op_workcnt] [numeric](12, 2) NOT NULL,
	[op_pieces] [numeric](17, 7) NOT NULL,
	[op_hours] [numeric](10, 3) NOT NULL,
	[op_active] [bit] NOT NULL,
	[op_rate] [numeric](17, 7) NOT NULL,
	[op_chid] [int] NOT NULL,
	[op_otchid] [int] NOT NULL,
	[op_wip] [bit] NOT NULL,
	[op_default] [bit] NOT NULL,
	[op_burden] [numeric](17, 7) NOT NULL,
	[op_burchid] [int] NOT NULL,
	[op_finlab] [int] NOT NULL,
	[op_finbur] [int] NOT NULL,
	[op_certreqd] [bit] NOT NULL,
 CONSTRAINT [PK_dmop] PRIMARY KEY CLUSTERED 
(
	[op_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmover]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmover](
	[ov_id] [int] IDENTITY(1,1) NOT NULL,
	[ov_table] [nvarchar](30) NOT NULL,
	[ov_recid] [int] NOT NULL,
	[ov_pos] [int] NOT NULL,
	[ov_override] [int] NOT NULL,
 CONSTRAINT [PK_dmover] PRIMARY KEY CLUSTERED 
(
	[ov_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpackinst]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpackinst](
	[pi_id] [int] IDENTITY(1,1) NOT NULL,
	[pi_active] [bit] NOT NULL,
	[pi_conttype] [nvarchar](60) NOT NULL,
	[pi_detail] [nvarchar](30) NOT NULL,
	[pi_diquant] [numeric](17, 7) NOT NULL,
	[pi_dryice] [bit] NOT NULL,
	[pi_name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmpackinst] PRIMARY KEY CLUSTERED 
(
	[pi_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpayevent]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpayevent](
	[pe_id] [int] IDENTITY(1,1) NOT NULL,
	[pe_name] [nvarchar](30) NOT NULL,
	[pe_active] [bit] NOT NULL,
	[pe_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmpayevent] PRIMARY KEY CLUSTERED 
(
	[pe_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpcat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpcat](
	[pc_id] [int] IDENTITY(1,1) NOT NULL,
	[pc_name] [nvarchar](30) NOT NULL,
	[pc_active] [bit] NOT NULL,
	[pc_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmpcat] PRIMARY KEY CLUSTERED 
(
	[pc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmper]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmper](
	[pe_id] [int] IDENTITY(1,1) NOT NULL,
	[pe_name] [nvarchar](10) NOT NULL,
	[pe_active] [bit] NOT NULL,
	[pe_pgid] [int] NOT NULL,
	[pe_trailingmonths] [int] NOT NULL,
 CONSTRAINT [PK_dmper] PRIMARY KEY CLUSTERED 
(
	[pe_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmper2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmper2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_peid] [int] NOT NULL,
	[p2_name] [nvarchar](30) NOT NULL,
	[p2_start] [datetime] NULL,
	[p2_end] [datetime] NULL,
	[p2_quarter] [int] NOT NULL,
 CONSTRAINT [PK_dmper2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpergrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpergrp](
	[pg_id] [int] IDENTITY(1,1) NOT NULL,
	[pg_name] [nvarchar](30) NOT NULL,
	[pg_active] [bit] NOT NULL,
	[pg_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmpergrp] PRIMARY KEY CLUSTERED 
(
	[pg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmphas]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmphas](
	[ph_id] [int] IDENTITY(1,1) NOT NULL,
	[ph_name] [nvarchar](30) NOT NULL,
	[ph_active] [bit] NOT NULL,
	[ph_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmphas] PRIMARY KEY CLUSTERED 
(
	[ph_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpo1]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpo1](
	[p1_id] [int] IDENTITY(1,1) NOT NULL,
	[p1_name] [nvarchar](30) NOT NULL,
	[p1_active] [bit] NOT NULL,
	[p1_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmpo1] PRIMARY KEY CLUSTERED 
(
	[p1_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpo2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpo2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_name] [nvarchar](30) NOT NULL,
	[p2_active] [bit] NOT NULL,
	[p2_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmpo2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpos]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpos](
	[po_number] [numeric](10, 0) NOT NULL,
	[po_mask] [numeric](20, 0) NOT NULL,
	[po_name] [nvarchar](30) NOT NULL,
	[po_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dmpos] PRIMARY KEY CLUSTERED 
(
	[po_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmposbutton]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmposbutton](
	[pb_id] [int] IDENTITY(1,1) NOT NULL,
	[pb_function] [nvarchar](30) NOT NULL,
	[pb_overc2id] [int] NOT NULL,
	[pb_caid] [int] NOT NULL,
	[pb_c2id] [int] NOT NULL,
	[pb_seq] [int] NOT NULL,
	[pb_active] [bit] NOT NULL,
	[pb_overc2guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dmposbutton] PRIMARY KEY CLUSTERED 
(
	[pb_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmposname]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmposname](
	[pn_id] [int] IDENTITY(1,1) NOT NULL,
	[pn_poid] [int] NOT NULL,
	[pn_name] [nvarchar](60) NOT NULL,
	[pn_value] [numeric](20, 0) NOT NULL,
 CONSTRAINT [PK_dmposname] PRIMARY KEY CLUSTERED 
(
	[pn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmposset]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmposset](
	[ps_id] [int] IDENTITY(1,1) NOT NULL,
	[ps_mac] [nvarchar](30) NOT NULL,
	[ps_comport] [int] NOT NULL,
	[ps_terminalid] [nvarchar](30) NOT NULL,
	[ps_securedevice] [nvarchar](100) NOT NULL,
	[ps_sequenceno] [nvarchar](30) NOT NULL,
	[ps_listenerport] [int] NOT NULL,
	[ps_ccid] [int] NOT NULL,
	[ps_usid] [int] NOT NULL,
 CONSTRAINT [PK_dmposset] PRIMARY KEY CLUSTERED 
(
	[ps_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpr1]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpr1](
	[p1_name] [nvarchar](30) NOT NULL,
	[p1_id] [int] IDENTITY(1,1) NOT NULL,
	[p1_active] [bit] NOT NULL,
	[p1_default] [bit] NOT NULL,
	[p1_restricted] [bit] NOT NULL,
 CONSTRAINT [PK_dmpr1] PRIMARY KEY CLUSTERED 
(
	[p1_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpr2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpr2](
	[p2_name] [nvarchar](30) NOT NULL,
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_active] [bit] NOT NULL,
	[p2_default] [bit] NOT NULL,
	[p2_restricted] [bit] NOT NULL,
 CONSTRAINT [PK_dmpr2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpr3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpr3](
	[p3_id] [int] IDENTITY(1,1) NOT NULL,
	[p3_name] [nvarchar](30) NOT NULL,
	[p3_active] [bit] NOT NULL,
	[p3_default] [bit] NOT NULL,
	[p3_restricted] [bit] NOT NULL,
 CONSTRAINT [PK_dmpr3] PRIMARY KEY CLUSTERED 
(
	[p3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpr4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpr4](
	[p4_id] [int] IDENTITY(1,1) NOT NULL,
	[p4_name] [nvarchar](30) NOT NULL,
	[p4_active] [bit] NOT NULL,
	[p4_default] [bit] NOT NULL,
	[p4_restricted] [bit] NOT NULL,
 CONSTRAINT [PK_dmpr4] PRIMARY KEY CLUSTERED 
(
	[p4_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpr5]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpr5](
	[p5_id] [int] IDENTITY(1,1) NOT NULL,
	[p5_name] [nvarchar](30) NOT NULL,
	[p5_active] [bit] NOT NULL,
	[p5_default] [bit] NOT NULL,
	[p5_restricted] [bit] NOT NULL,
 CONSTRAINT [PK_dmpr5] PRIMARY KEY CLUSTERED 
(
	[p5_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpref]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpref](
	[pr_id] [int] IDENTITY(1,1) NOT NULL,
	[pr_name] [nvarchar](30) NOT NULL,
	[pr_usid] [int] NOT NULL,
	[pr_descrip] [nvarchar](30) NOT NULL,
	[pr_default] [bit] NOT NULL,
	[pr_fiid] [int] NOT NULL,
 CONSTRAINT [PK_dmpref] PRIMARY KEY CLUSTERED 
(
	[pr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpref2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpref2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_field] [nvarchar](30) NOT NULL,
	[p2_value] [nvarchar](30) NOT NULL,
	[p2_prid] [int] NOT NULL,
	[p2_oper] [nvarchar](10) NOT NULL,
	[p2_logical] [nvarchar](3) NOT NULL,
 CONSTRAINT [PK_dmpref2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprod]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprod](
	[pr_id] [int] IDENTITY(1,1) NOT NULL,
	[pr_codenum] [nvarchar](30) NOT NULL,
	[pr_descrip] [nvarchar](200) NOT NULL,
	[pr_level] [numeric](3, 0) NOT NULL,
	[pr_buid] [int] NOT NULL,
	[pr_caid] [int] NOT NULL,
	[pr_lispric] [numeric](17, 7) NOT NULL,
	[pr_stanlab] [numeric](17, 7) NOT NULL,
	[pr_stanmat] [numeric](17, 7) NOT NULL,
	[pr_stantot] [numeric](17, 7) NOT NULL,
	[pr_active] [bit] NOT NULL,
	[pr_taxable] [bit] NOT NULL,
	[pr_unitwgt] [numeric](20, 10) NOT NULL,
	[pr_ware1] [nvarchar](30) NOT NULL,
	[pr_control] [bit] NOT NULL,
	[pr_drwcode] [nvarchar](30) NOT NULL,
	[pr_reorder] [numeric](17, 7) NOT NULL,
	[pr_salable] [bit] NOT NULL,
	[pr_purable] [bit] NOT NULL,
	[pr_stocked] [bit] NOT NULL,
	[pr_abc] [nvarchar](1) NOT NULL,
	[pr_user1] [nvarchar](40) NOT NULL,
	[pr_user2] [nvarchar](40) NOT NULL,
	[pr_user3] [nvarchar](40) NOT NULL,
	[pr_user4] [nvarchar](40) NOT NULL,
	[pr_notes] [nvarchar](max) NOT NULL,
	[pr_make] [bit] NOT NULL,
	[pr_ordtype] [nvarchar](1) NOT NULL,
	[pr_frtclas] [nvarchar](30) NOT NULL,
	[pr_retail] [nvarchar](30) NOT NULL,
	[pr_burden] [numeric](17, 7) NOT NULL,
	[pr_prunid] [int] NOT NULL,
	[pr_prfact] [numeric](17, 7) NOT NULL,
	[pr_scrap] [numeric](17, 7) NOT NULL,
	[pr_purpric] [numeric](17, 7) NOT NULL,
	[pr_c2id] [int] NOT NULL,
	[pr_discoun] [bit] NOT NULL,
	[pr_unquant] [numeric](17, 7) NOT NULL,
	[pr_singord] [bit] NOT NULL,
	[pr_chid] [int] NOT NULL,
	[pr_invchid] [int] NOT NULL,
	[pr_matexp] [int] NOT NULL,
	[pr_invadj] [int] NOT NULL,
	[pr_cogpro] [int] NOT NULL,
	[pr_rdid] [int] NOT NULL,
	[pr_unitvol] [numeric](20, 10) NOT NULL,
	[pr_unitcub] [numeric](20, 10) NOT NULL,
	[pr_reorder2] [numeric](17, 7) NOT NULL,
	[pr_puradj] [int] NOT NULL,
	[pr_hazard] [nvarchar](30) NOT NULL,
	[pr_matbur] [numeric](17, 7) NOT NULL,
	[pr_buracct] [int] NOT NULL,
	[pr_salunid] [int] NOT NULL,
	[pr_salfact] [numeric](17, 7) NOT NULL,
	[pr_finmat] [int] NOT NULL,
	[pr_finlab] [int] NOT NULL,
	[pr_finbur] [int] NOT NULL,
	[pr_specpar] [int] NOT NULL,
	[pr_density] [numeric](12, 4) NOT NULL,
	[pr_counted] [datetime] NULL,
	[pr_cntflag] [bit] NOT NULL,
	[pr_fixstan] [numeric](17, 7) NOT NULL,
	[pr_invgain] [int] NOT NULL,
	[pr_user5] [int] NOT NULL,
	[pr_user6] [int] NOT NULL,
	[pr_neginv] [nvarchar](10) NOT NULL,
	[pr_maxquan1] [numeric](17, 7) NOT NULL,
	[pr_maxquan2] [numeric](17, 7) NOT NULL,
	[pr_fixmat] [numeric](17, 7) NOT NULL,
	[pr_fixlab] [numeric](17, 7) NOT NULL,
	[pr_fixbur] [numeric](17, 7) NOT NULL,
	[pr_fixmbur] [numeric](17, 7) NOT NULL,
	[pr_fixupdt] [datetime] NULL,
	[pr_mrp] [bit] NOT NULL,
	[pr_catch] [bit] NOT NULL,
	[pr_catchwgt] [numeric](17, 7) NOT NULL,
	[pr_tranvar] [int] NOT NULL,
	[pr_xferexp] [bit] NOT NULL,
	[pr_loadcalc1] [nvarchar](60) NOT NULL,
	[pr_loadcalc2] [nvarchar](60) NOT NULL,
	[pr_loadcalc3] [nvarchar](60) NOT NULL,
	[pr_burcalc] [nvarchar](150) NOT NULL,
	[pr_matburcalc] [nvarchar](150) NOT NULL,
	[pr_purtype] [nvarchar](30) NOT NULL,
	[pr_taxpo] [bit] NOT NULL,
	[pr_popso] [nvarchar](max) NOT NULL,
	[pr_poppo] [nvarchar](max) NOT NULL,
	[pr_custinv] [bit] NOT NULL,
	[pr_qcid] [int] NOT NULL,
	[pr_quota] [numeric](10, 0) NOT NULL,
	[pr_lifocost] [numeric](17, 7) NOT NULL,
	[pr_tgid] [int] NOT NULL,
	[pr_user7] [int] NOT NULL,
	[pr_user8] [int] NOT NULL,
	[pr_user9] [int] NOT NULL,
	[pr_rdid2] [int] NOT NULL,
	[pr_secure] [bit] NOT NULL,
	[pr_hazflag] [bit] NOT NULL,
	[pr_stanfrt] [numeric](17, 7) NOT NULL,
	[pr_fixfrt] [numeric](17, 7) NOT NULL,
	[pr_frtchid] [int] NOT NULL,
	[pr_phid] [int] NOT NULL,
	[pr_shelf] [numeric](10, 0) NOT NULL,
	[pr_commable] [bit] NOT NULL,
	[pr_finwip] [bit] NOT NULL,
	[pr_custreq] [bit] NOT NULL,
	[pr_poquan] [numeric](17, 7) NOT NULL,
	[pr_soquan] [numeric](17, 7) NOT NULL,
	[pr_jobquan] [numeric](17, 7) NOT NULL,
	[pr_makeord] [bit] NOT NULL,
	[pr_inherit] [bit] NOT NULL,
	[pr_minmar] [numeric](12, 2) NOT NULL,
	[pr_tarmar] [numeric](12, 2) NOT NULL,
	[pr_msfactor] [numeric](17, 7) NOT NULL,
	[pr_allowbom] [bit] NOT NULL,
	[pr_prtlabel] [nvarchar](30) NOT NULL,
	[pr_futmat] [numeric](17, 7) NOT NULL,
	[pr_futlab] [numeric](17, 7) NOT NULL,
	[pr_futbur] [numeric](17, 7) NOT NULL,
	[pr_futmbur] [numeric](17, 7) NOT NULL,
	[pr_futfrt] [numeric](17, 7) NOT NULL,
	[pr_futstan] [numeric](17, 7) NOT NULL,
	[pr_timemrp] [bit] NOT NULL,
	[pr_nosub] [bit] NOT NULL,
	[pr_finpart] [bit] NOT NULL,
	[pr_purunid] [int] NOT NULL,
	[pr_unid] [int] NOT NULL,
	[pr_lotreqd] [bit] NOT NULL,
	[pr_orddays] [numeric](10, 0) NOT NULL,
	[pr_qcfreq] [int] NOT NULL,
	[pr_lotrecv] [bit] NOT NULL,
	[pr_vendreq] [bit] NOT NULL,
	[pr_cofaid] [int] NOT NULL,
	[pr_polabid] [int] NOT NULL,
	[pr_solabid] [int] NOT NULL,
	[pr_itemlabid] [int] NOT NULL,
	[pr_msdsid] [int] NOT NULL,
	[pr_joblabid] [int] NOT NULL,
	[pr_finback] [bit] NOT NULL,
	[pr_lotlabid] [int] NOT NULL,
	[pr_markup] [numeric](5, 2) NOT NULL,
	[pr_xfermarkchid] [int] NOT NULL,
	[pr_stanupdt] [datetime] NULL,
	[pr_futupdt] [datetime] NULL,
	[pr_psid] [int] NOT NULL,
	[pr_serial] [bit] NOT NULL,
	[pr_featcost] [numeric](17, 7) NOT NULL,
	[pr_reqfacility] [bit] NOT NULL,
	[pr_routing] [bit] NOT NULL,
	[pr_issueoverlimit] [numeric](17, 7) NOT NULL,
	[pr_issuelimitenforce] [bit] NOT NULL,
	[pr_porecvlimit] [numeric](17, 7) NOT NULL,
	[pr_porecvlimitenforce] [bit] NOT NULL,
	[pr_secureprice] [bit] NOT NULL,
	[pr_xfercost] [numeric](17, 7) NOT NULL,
	[pr_s1id] [int] NOT NULL,
	[pr_s2id] [int] NOT NULL,
	[pr_backjob] [bit] NOT NULL,
	[pr_splitjobs] [bit] NOT NULL,
	[pr_overissue] [numeric](17, 7) NOT NULL,
	[pr_unitlen] [numeric](20, 10) NOT NULL,
	[pr_loid] [int] NOT NULL,
	[pr_jobmin] [numeric](17, 7) NOT NULL,
	[pr_ltid] [int] NOT NULL,
	[pr_qclead] [int] NOT NULL,
	[pr_trakid] [int] NOT NULL,
	[pr_trak2id] [int] NOT NULL,
	[pr_minquant] [numeric](17, 7) NOT NULL,
	[pr_qcfreqtype] [nvarchar](30) NOT NULL,
	[pr_serialcont] [bit] NOT NULL,
	[pr_jobmgid] [int] NOT NULL,
	[pr_separatejobs] [bit] NOT NULL,
	[pr_rollupmats] [bit] NOT NULL,
	[pr_rolluplabor] [bit] NOT NULL,
	[pr_rollupburden] [bit] NOT NULL,
	[pr_tarewgt] [numeric](17, 7) NOT NULL,
	[pr_finasissued] [bit] NOT NULL,
	[pr_countunid] [int] NOT NULL,
	[pr_palunid] [int] NOT NULL,
	[pr_picture] [int] NOT NULL,
	[pr_popjob] [nvarchar](max) NOT NULL,
	[pr_routesale] [bit] NOT NULL,
	[pr_contprid] [int] NOT NULL,
	[pr_finmatwiploc] [bit] NOT NULL,
	[pr_scrapcost] [numeric](17, 7) NOT NULL,
	[pr_rollupwgt] [bit] NOT NULL,
	[pr_xferchid] [int] NOT NULL,
	[pr_measured] [bit] NOT NULL,
	[pr_creditcost] [bit] NOT NULL,
	[pr_routereturn] [bit] NOT NULL,
	[pr_combinepos] [bit] NOT NULL,
	[pr_definqty] [numeric](20, 7) NOT NULL,
	[pr_incquant] [numeric](17, 7) NOT NULL,
	[pr_shoprel] [bit] NOT NULL,
	[pr_frominvprid] [int] NOT NULL,
	[pr_minsale] [numeric](17, 7) NOT NULL,
	[pr_incsale] [numeric](17, 7) NOT NULL,
	[pr_separatepos] [bit] NOT NULL,
	[pr_splitpos] [bit] NOT NULL,
	[pr_recatrisk] [bit] NOT NULL,
	[pr_shipquan] [nvarchar](30) NOT NULL,
	[pr_salediscchid] [int] NOT NULL,
	[pr_mrpjobsubasm] [bit] NOT NULL,
	[pr_taretype] [nvarchar](1) NOT NULL,
	[pr_tareexp] [nvarchar](max) NOT NULL,
	[pr_rollupvol] [bit] NOT NULL,
	[pr_minwgt] [numeric](17, 7) NOT NULL,
	[pr_maxwgt] [numeric](17, 7) NOT NULL,
	[pr_haltposting] [bit] NOT NULL,
	[pr_contunid] [int] NOT NULL,
	[pr_commexp] [int] NOT NULL,
	[pr_zoneput] [bit] NOT NULL,
	[pr_frtexpchid] [int] NOT NULL,
	[pr_jobinc] [numeric](17, 7) NOT NULL,
	[pr_dnid] [int] NOT NULL,
	[pr_safedays] [int] NOT NULL,
	[pr_prtjobpl] [bit] NOT NULL,
	[pr_restrictjobquant] [bit] NOT NULL,
	[pr_frtrevchid] [int] NOT NULL,
	[pr_qcmrpjobplan] [bit] NOT NULL,
	[pr_reqexpdate] [bit] NOT NULL,
	[pr_minpallet] [int] NOT NULL,
	[pr_qcid2] [int] NOT NULL,
	[pr_pickorder] [nvarchar](30) NOT NULL,
	[pr_wipinv] [int] NOT NULL,
	[pr_splitposby] [nvarchar](30) NOT NULL,
	[pr_issueunderlimit] [numeric](17, 7) NOT NULL,
	[pr_issueunderenforce] [bit] NOT NULL,
	[pr_iataunit] [nvarchar](30) NOT NULL,
	[pr_roundupbom] [bit] NOT NULL,
	[pr_finseqstage] [bit] NOT NULL,
	[pr_recalcbomcalcs] [bit] NOT NULL,
	[pr_subordjob] [bit] NOT NULL,
	[pr_suggestbefore] [numeric](10, 0) NOT NULL,
	[pr_dockrel] [bit] NOT NULL,
	[pr_restrictjobinc] [bit] NOT NULL,
	[pr_deresqty] [numeric](20, 7) NOT NULL,
	[pr_restrictloc] [bit] NOT NULL,
	[pr_forecastback] [numeric](10, 0) NOT NULL,
	[pr_forecastforward] [numeric](10, 0) NOT NULL,
	[pr_backordpo] [bit] NOT NULL,
	[pr_pickunit] [int] NOT NULL,
	[pr_leadmins] [int] NOT NULL,
	[pr_makemlfinish] [bit] NOT NULL,
	[pr_xfacmarkchid] [int] NOT NULL,
	[pr_custreqxfer] [bit] NOT NULL,
	[pr_backordso] [bit] NOT NULL,
	[pr_finishltid] [int] NOT NULL,
	[pr_finishloid] [int] NOT NULL,
	[pr_receiveloid] [int] NOT NULL,
	[pr_receiveltid] [int] NOT NULL,
	[pr_autofinunid] [int] NOT NULL,
	[pr_autofinish] [bit] NOT NULL,
	[pr_rolluprstypes] [bit] NOT NULL,
	[pr_purdis] [int] NOT NULL,
	[pr_splitjobson] [nvarchar](30) NOT NULL,
	[pr_bomunid] [int] NOT NULL,
	[pr_separateicxfers] [bit] NOT NULL,
	[pr_poallocatable] [bit] NOT NULL,
	[pr_autoaltwgt] [nvarchar](30) NOT NULL,
	[pr_totalcatchml] [bit] NOT NULL,
	[pr_dfltreserveloc] [int] NOT NULL,
	[pr_autolinkmrpjobs] [bit] NOT NULL,
	[pr_makemlreceive] [bit] NOT NULL,
	[pr_allowlistprice] [bit] NOT NULL,
 CONSTRAINT [PK_dmprod] PRIMARY KEY CLUSTERED 
(
	[pr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprod2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprod2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_prid] [int] NOT NULL,
	[p2_veid] [int] NOT NULL,
	[p2_vndcode] [nvarchar](30) NOT NULL,
	[p2_vnddesc] [nvarchar](200) NOT NULL,
	[p2_orddays] [numeric](10, 0) NOT NULL,
	[p2_unquant] [numeric](17, 7) NOT NULL,
	[p2_totcost] [numeric](17, 7) NOT NULL,
	[p2_active] [bit] NOT NULL,
	[p2_vndunid] [int] NOT NULL,
	[p2_prunid] [int] NOT NULL,
	[p2_prfact] [numeric](17, 7) NOT NULL,
	[p2_notes] [nvarchar](max) NOT NULL,
	[p2_retail] [nvarchar](30) NOT NULL,
	[p2_prefer] [bit] NOT NULL,
	[p2_shelf] [numeric](10, 0) NOT NULL,
	[p2_waid] [int] NOT NULL,
	[p2_qcid] [int] NOT NULL,
	[p2_qcexpires] [datetime] NULL,
	[p2_poquan] [numeric](17, 7) NOT NULL,
	[p2_minquant] [numeric](17, 7) NOT NULL,
	[p2_incquant] [numeric](17, 7) NOT NULL,
	[p2_usemrp] [bit] NOT NULL,
	[p2_approvalexpires] [datetime] NULL,
	[p2_contunid] [int] NOT NULL,
 CONSTRAINT [PK_dmprod2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprod3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprod3](
	[p3_id] [int] IDENTITY(1,1) NOT NULL,
	[p3_prid] [int] NOT NULL,
	[p3_waid] [int] NOT NULL,
	[p3_reorder] [numeric](17, 7) NOT NULL,
	[p3_reorder2] [numeric](17, 7) NOT NULL,
	[p3_maxquan1] [numeric](17, 7) NOT NULL,
	[p3_maxquan2] [numeric](17, 7) NOT NULL,
	[p3_lispric] [numeric](17, 7) NOT NULL,
	[p3_stanmat] [numeric](17, 7) NOT NULL,
	[p3_stanlab] [numeric](17, 7) NOT NULL,
	[p3_burden] [numeric](17, 7) NOT NULL,
	[p3_matbur] [numeric](17, 7) NOT NULL,
	[p3_purpric] [numeric](17, 7) NOT NULL,
	[p3_fixmat] [numeric](17, 7) NOT NULL,
	[p3_fixlab] [numeric](17, 7) NOT NULL,
	[p3_fixbur] [numeric](17, 7) NOT NULL,
	[p3_fixmbur] [numeric](17, 7) NOT NULL,
	[p3_fixstan] [numeric](17, 7) NOT NULL,
	[p3_fixupdt] [datetime] NULL,
	[p3_usecosts] [bit] NOT NULL,
	[p3_usereorder] [bit] NOT NULL,
	[p3_stantot] [numeric](17, 7) NOT NULL,
	[p3_useprices] [bit] NOT NULL,
	[p3_stanfrt] [numeric](17, 7) NOT NULL,
	[p3_fixfrt] [numeric](17, 7) NOT NULL,
	[p3_useflags] [bit] NOT NULL,
	[p3_purable] [bit] NOT NULL,
	[p3_salable] [bit] NOT NULL,
	[p3_poquan] [numeric](17, 7) NOT NULL,
	[p3_soquan] [numeric](17, 7) NOT NULL,
	[p3_jobquan] [numeric](17, 7) NOT NULL,
	[p3_ware1] [nvarchar](30) NOT NULL,
	[p3_futmat] [numeric](17, 7) NOT NULL,
	[p3_futlab] [numeric](17, 7) NOT NULL,
	[p3_futbur] [numeric](17, 7) NOT NULL,
	[p3_futmbur] [numeric](17, 7) NOT NULL,
	[p3_futfrt] [numeric](17, 7) NOT NULL,
	[p3_futstan] [numeric](17, 7) NOT NULL,
	[p3_orddays] [numeric](10, 0) NOT NULL,
	[p3_make] [bit] NOT NULL,
	[p3_abc] [nvarchar](1) NOT NULL,
	[p3_hazard] [nvarchar](30) NOT NULL,
	[p3_hazflag] [bit] NOT NULL,
	[p3_xfercost] [numeric](17, 7) NOT NULL,
	[p3_loid] [int] NOT NULL,
	[p3_jobmin] [numeric](17, 7) NOT NULL,
	[p3_minquant] [numeric](17, 7) NOT NULL,
	[p3_ltid] [int] NOT NULL,
	[p3_incquant] [numeric](17, 7) NOT NULL,
	[p3_minsale] [numeric](17, 7) NOT NULL,
	[p3_incsale] [numeric](17, 7) NOT NULL,
	[p3_jobinc] [numeric](17, 7) NOT NULL,
	[p3_zoid] [int] NOT NULL,
	[p3_scrapissueoverride] [bit] NOT NULL,
	[p3_scrap] [numeric](17, 7) NOT NULL,
	[p3_scrapcost] [numeric](17, 7) NOT NULL,
	[p3_overissue] [numeric](17, 7) NOT NULL,
	[p3_cntflag] [bit] NOT NULL,
	[p3_counted] [datetime] NULL,
	[p3_incict] [numeric](17, 7) NOT NULL,
	[p3_minict] [numeric](17, 7) NOT NULL,
	[p3_suggestbefore] [numeric](10, 0) NOT NULL,
	[p3_forecastback] [numeric](10, 0) NOT NULL,
	[p3_forecastforward] [numeric](10, 0) NOT NULL,
	[p3_definqty] [numeric](20, 7) NOT NULL,
	[p3_leadmins] [int] NOT NULL,
	[p3_usephyscyclesettings] [bit] NOT NULL,
	[p3_finishltid] [int] NOT NULL,
	[p3_finishloid] [int] NOT NULL,
	[p3_receiveltid] [int] NOT NULL,
	[p3_receiveloid] [int] NOT NULL,
	[p3_mrpjobsubasm] [bit] NOT NULL,
	[p3_subordjob] [bit] NOT NULL,
	[p3_recalcbomcalcs] [bit] NOT NULL,
	[p3_dfltreserveloc] [int] NOT NULL,
	[p3_haltposting] [bit] NOT NULL,
	[p3_lotreqd] [nvarchar](30) NOT NULL,
	[p3_lotrecv] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmprod3] PRIMARY KEY CLUSTERED 
(
	[p3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprod4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprod4](
	[p4_id] [int] IDENTITY(1,1) NOT NULL,
	[p4_prid] [int] NOT NULL,
	[p4_codenum] [nvarchar](30) NOT NULL,
	[p4_descrip] [nvarchar](30) NOT NULL,
	[p4_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmprod4] PRIMARY KEY CLUSTERED 
(
	[p4_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprod5]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprod5](
	[p5_id] [int] IDENTITY(1,1) NOT NULL,
	[p5_prid] [int] NOT NULL,
	[p5_veid] [int] NOT NULL,
	[p5_quant] [numeric](17, 7) NOT NULL,
	[p5_price] [numeric](17, 7) NOT NULL,
	[p5_start] [datetime] NULL,
	[p5_end] [datetime] NULL,
	[p5_p2id] [int] NOT NULL,
	[p5_frtcost] [numeric](17, 7) NOT NULL,
	[p5_datebasedon] [nvarchar](max) NOT NULL,
	[p5_matbur] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dmprod5] PRIMARY KEY CLUSTERED 
(
	[p5_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprog]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprog](
	[pg_prognum] [numeric](10, 0) NOT NULL,
	[pg_descrip] [nvarchar](30) NOT NULL,
	[pg_date] [datetime] NULL,
	[pg_active] [bit] NOT NULL,
	[pg_pcid] [int] NOT NULL,
	[pg_notes] [nvarchar](max) NOT NULL,
	[pg_biid] [int] NOT NULL,
	[pg_shid] [int] NOT NULL,
	[pg_complete] [datetime] NULL,
	[pg_waid] [int] NOT NULL,
	[pg_teid] [int] NOT NULL,
	[pg_billpo] [nvarchar](30) NOT NULL,
	[pg_estmarg] [numeric](12, 2) NOT NULL,
	[pg_basedon] [numeric](15, 0) NOT NULL,
	[pg_fcid] [int] NOT NULL,
	[pg_fcrate] [numeric](17, 7) NOT NULL,
	[pg_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dmprog] PRIMARY KEY CLUSTERED 
(
	[pg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprog2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprog2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_seq] [int] NOT NULL,
	[p2_prid] [int] NOT NULL,
	[p2_amount] [numeric](12, 2) NOT NULL,
	[p2_sched] [datetime] NULL,
	[p2_pjid] [int] NOT NULL,
	[p2_billed] [numeric](12, 2) NOT NULL,
	[p2_notes] [nvarchar](max) NOT NULL,
	[p2_retper] [numeric](12, 2) NOT NULL,
	[p2_rettot] [numeric](12, 2) NOT NULL,
	[p2_pgid] [int] NOT NULL,
 CONSTRAINT [PK_dmprog2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprojnotetype]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprojnotetype](
	[pe_active] [bit] NOT NULL,
	[pe_default] [bit] NOT NULL,
	[pe_id] [int] IDENTITY(1,1) NOT NULL,
	[pe_name] [nvarchar](30) NOT NULL,
	[pe_noid] [int] NOT NULL,
 CONSTRAINT [PK_dmprojnotetype] PRIMARY KEY CLUSTERED 
(
	[pe_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpromo]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpromo](
	[pm_id] [int] IDENTITY(1,1) NOT NULL,
	[pm_prid] [int] NOT NULL,
	[pm_descrip] [nvarchar](60) NOT NULL,
	[pm_active] [bit] NOT NULL,
	[pm_for] [nvarchar](30) NOT NULL,
	[pm_forname] [nvarchar](60) NOT NULL,
	[pm_fornum] [int] NOT NULL,
	[pm_minimum] [numeric](17, 7) NOT NULL,
	[pm_on] [nvarchar](30) NOT NULL,
	[pm_onname] [nvarchar](30) NOT NULL,
	[pm_onnum] [int] NOT NULL,
	[pm_type] [nvarchar](30) NOT NULL,
	[pm_typenum] [numeric](12, 4) NOT NULL,
	[pm_waid] [int] NOT NULL,
	[pm_start] [datetime] NULL,
	[pm_end] [datetime] NULL,
	[pm_limitorder] [bit] NOT NULL,
	[pm_limitcat] [bit] NOT NULL,
	[pm_flexible] [bit] NOT NULL,
	[pm_auto] [bit] NOT NULL,
	[pm_buyqty] [numeric](10, 0) NOT NULL,
	[pm_freeqty] [numeric](10, 0) NOT NULL,
	[pm_unid] [int] NOT NULL,
	[pm_mintype] [nvarchar](30) NOT NULL,
	[pm_minnum] [int] NOT NULL,
	[pm_minname] [nvarchar](30) NOT NULL,
	[pm_quantsbasedon] [nvarchar](20) NOT NULL,
	[pm_sorttobottom] [bit] NOT NULL,
	[pm_basedon] [nvarchar](30) NOT NULL,
	[pm_line] [bit] NOT NULL,
	[pm_edicode] [nvarchar](30) NOT NULL,
	[pm_inventory] [nvarchar](30) NOT NULL,
	[pm_linetype] [nvarchar](30) NOT NULL,
	[pm_trantype] [nvarchar](30) NOT NULL,
	[pm_countinpricingorder] [bit] NOT NULL,
	[pm_expression] [nvarchar](max) NOT NULL,
	[pm_appliedon] [nvarchar](30) NOT NULL,
	[pm_limitcust] [bit] NOT NULL,
	[pm_includenegatives] [bit] NOT NULL,
	[pm_backord] [bit] NOT NULL,
	[pm_minimumtype] [nvarchar](30) NOT NULL,
	[pm_uselinequant] [bit] NOT NULL,
	[pm_forecastlift] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dmpromo] PRIMARY KEY CLUSTERED 
(
	[pm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprt]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprt](
	[pt_id] [int] IDENTITY(1,1) NOT NULL,
	[pt_name] [nvarchar](30) NOT NULL,
	[pt_notes] [nvarchar](max) NOT NULL,
	[pt_report] [nvarchar](30) NOT NULL,
	[pt_type] [nvarchar](30) NOT NULL,
	[pt_default] [bit] NOT NULL,
	[pt_user] [nvarchar](30) NOT NULL,
	[pt_printer] [nvarchar](100) NOT NULL,
	[pt_archive] [nvarchar](30) NOT NULL,
	[pt_sortexp] [nvarchar](max) NOT NULL,
	[pt_attached] [bit] NOT NULL,
	[pt_language] [int] NOT NULL,
	[pt_pdid] [int] NOT NULL,
	[pt_emailexp] [nvarchar](max) NOT NULL,
	[pt_emailsubexp] [nvarchar](max) NOT NULL,
	[pt_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmprt] PRIMARY KEY CLUSTERED 
(
	[pt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprt2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprt2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_ptid] [int] NOT NULL,
	[p2_copy] [numeric](10, 0) NOT NULL,
	[p2_say] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmprt2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprtdest]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprtdest](
	[pd_id] [int] IDENTITY(1,1) NOT NULL,
	[pd_name] [nvarchar](30) NOT NULL,
	[pd_printer] [nvarchar](100) NOT NULL,
	[pd_active] [bit] NOT NULL,
	[pd_useroverride] [bit] NOT NULL,
 CONSTRAINT [PK_dmprtdest] PRIMARY KEY CLUSTERED 
(
	[pd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprtdestover]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprtdestover](
	[po_id] [int] IDENTITY(1,1) NOT NULL,
	[po_pdid] [int] NOT NULL,
	[po_table] [nvarchar](30) NOT NULL,
	[po_recid] [int] NOT NULL,
	[po_printer] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_dmprtdestover] PRIMARY KEY CLUSTERED 
(
	[po_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprtdsd]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprtdsd](
	[pd_name] [nvarchar](30) NOT NULL,
	[pd_active] [bit] NOT NULL,
	[pd_default] [bit] NOT NULL,
	[pd_report] [nvarchar](max) NOT NULL,
	[pd_id] [int] IDENTITY(1,1) NOT NULL,
	[pd_reporttype] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmprtdsd] PRIMARY KEY CLUSTERED 
(
	[pd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprtsub]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprtsub](
	[ps_id] [int] IDENTITY(1,1) NOT NULL,
	[ps_name] [nvarchar](30) NOT NULL,
	[ps_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmprtsub] PRIMARY KEY CLUSTERED 
(
	[ps_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmprtsub2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmprtsub2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_psid] [int] NOT NULL,
	[p2_subtype] [nvarchar](30) NOT NULL,
	[p2_baserep] [nvarchar](30) NOT NULL,
	[p2_subrep] [nvarchar](30) NOT NULL,
	[p2_baseform] [int] NOT NULL,
	[p2_subform] [int] NOT NULL,
	[p2_basecat] [int] NOT NULL,
	[p2_subcat] [int] NOT NULL,
	[p2_ptid] [int] NOT NULL,
 CONSTRAINT [PK_dmprtsub2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmpsize]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmpsize](
	[ps_id] [int] IDENTITY(1,1) NOT NULL,
	[ps_name] [nvarchar](30) NOT NULL,
	[ps_width] [numeric](7, 3) NOT NULL,
	[ps_height] [numeric](7, 3) NOT NULL,
	[ps_default] [bit] NOT NULL,
	[ps_active] [bit] NOT NULL,
	[ps_partform] [bit] NOT NULL,
	[ps_defaultpf] [bit] NOT NULL,
 CONSTRAINT [PK_dmpsize] PRIMARY KEY CLUSTERED 
(
	[ps_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmputaway]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmputaway](
	[py_id] [int] IDENTITY(1,1) NOT NULL,
	[py_fortype] [nvarchar](30) NOT NULL,
	[py_for] [int] NOT NULL,
	[py_totype] [nvarchar](30) NOT NULL,
	[py_to] [int] NOT NULL,
	[py_captype] [nvarchar](30) NOT NULL,
	[py_capunid] [int] NOT NULL,
	[py_capacity] [numeric](17, 7) NOT NULL,
	[py_sort] [nvarchar](30) NOT NULL,
	[py_existinginv] [nvarchar](30) NOT NULL,
	[py_invtype] [nvarchar](30) NOT NULL,
	[py_qcstatus] [nvarchar](30) NOT NULL,
	[py_lot] [nvarchar](30) NOT NULL,
	[py_active] [bit] NOT NULL,
	[py_fillpartialloc] [bit] NOT NULL,
 CONSTRAINT [PK_dmputaway] PRIMARY KEY CLUSTERED 
(
	[py_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmqc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmqc](
	[qc_name] [nvarchar](100) NOT NULL,
	[qc_id] [int] IDENTITY(1,1) NOT NULL,
	[qc_active] [bit] NOT NULL,
	[qc_default] [bit] NOT NULL,
	[qc_status] [nvarchar](1) NOT NULL,
	[qc_saved] [datetime] NULL,
	[qc_savetime] [nvarchar](8) NOT NULL,
	[qc_approval] [bit] NOT NULL,
	[qc_afterprod] [bit] NOT NULL,
	[qc_daysopen] [int] NOT NULL,
	[qc_esig] [bit] NOT NULL,
	[qc_groupnum] [numeric](5, 0) NOT NULL,
	[qc_completeempty] [bit] NOT NULL,
	[qc_copyqc] [bit] NOT NULL,
	[qc_failtoquar] [bit] NOT NULL,
	[qc_approvaltype] [int] NOT NULL,
	[qc_esigforresult] [bit] NOT NULL,
	[qc_esigapprovaltype] [nvarchar](30) NOT NULL,
	[qc_trakid] [int] NOT NULL,
	[qc_trak2id] [int] NOT NULL,
	[qc_esigcounts] [int] NOT NULL,
	[qc_resultsesigcounts] [int] NOT NULL,
 CONSTRAINT [PK_dmqc] PRIMARY KEY CLUSTERED 
(
	[qc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmqc2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmqc2](
	[q2_id] [int] IDENTITY(1,1) NOT NULL,
	[q2_qcid] [int] NOT NULL,
	[q2_d1id] [int] NOT NULL,
	[q2_seq] [int] NOT NULL,
	[q2_min] [numeric](20, 7) NOT NULL,
	[q2_max] [numeric](20, 7) NOT NULL,
	[q2_target] [nvarchar](120) NOT NULL,
	[q2_notes] [nvarchar](max) NOT NULL,
	[q2_name] [nvarchar](200) NOT NULL,
	[q2_picture] [nvarchar](30) NOT NULL,
	[q2_required] [bit] NOT NULL,
	[q2_q3id] [int] NOT NULL,
	[q2_mustpass] [bit] NOT NULL,
	[q2_print] [bit] NOT NULL,
	[q2_formcalc] [nvarchar](30) NOT NULL,
	[q2_printpo] [bit] NOT NULL,
	[q2_qgid] [int] NOT NULL,
	[q2_mindet] [numeric](17, 7) NOT NULL,
	[q2_requirenotes] [bit] NOT NULL,
	[q2_defaultvalue] [nvarchar](120) NOT NULL,
	[q2_printmask] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmqc2] PRIMARY KEY CLUSTERED 
(
	[q2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmqc3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmqc3](
	[q3_id] [int] IDENTITY(1,1) NOT NULL,
	[q3_active] [bit] NOT NULL,
	[q3_name] [nvarchar](60) NOT NULL,
	[q3_method] [nvarchar](120) NOT NULL,
	[q3_unid] [int] NOT NULL,
	[q3_combineresults] [nvarchar](120) NOT NULL,
	[q3_picture] [nvarchar](30) NOT NULL,
	[q3_printmask] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmqc3] PRIMARY KEY CLUSTERED 
(
	[q3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmqc6]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmqc6](
	[q6_id] [int] IDENTITY(1,1) NOT NULL,
	[q6_table] [nvarchar](30) NOT NULL,
	[q6_recid] [int] NOT NULL,
	[q6_freqtype] [nvarchar](30) NOT NULL,
	[q6_frequency] [int] NOT NULL,
	[q6_qcid] [int] NOT NULL,
	[q6_stabdays] [int] NOT NULL,
	[q6_seq] [int] NOT NULL,
	[q6_ordtype] [nvarchar](30) NOT NULL,
	[q6_offset] [int] NOT NULL,
	[q6_offsetfromqfid] [int] NOT NULL,
	[q6_qcfreqlottype] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmqc6] PRIMARY KEY CLUSTERED 
(
	[q6_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmqcgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmqcgrp](
	[qg_id] [int] IDENTITY(1,1) NOT NULL,
	[qg_name] [nvarchar](30) NOT NULL,
	[qg_active] [bit] NOT NULL,
	[qg_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmqcgrp] PRIMARY KEY CLUSTERED 
(
	[qg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmqcgrp2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmqcgrp2](
	[q2_access] [bit] NOT NULL,
	[q2_qgid] [int] NOT NULL,
	[q2_id] [int] IDENTITY(1,1) NOT NULL,
	[q2_ugid] [int] NOT NULL,
	[q2_usid] [int] NOT NULL,
 CONSTRAINT [PK_dmqcgrp2] PRIMARY KEY CLUSTERED 
(
	[q2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmquery]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmquery](
	[qu_id] [int] IDENTITY(1,1) NOT NULL,
	[qu_usid] [int] NOT NULL,
	[qu_name] [nvarchar](30) NOT NULL,
	[qu_default] [bit] NOT NULL,
	[qu_query] [nvarchar](max) NOT NULL,
	[qu_prefilter] [nvarchar](max) NOT NULL,
	[qu_publish] [bit] NOT NULL,
 CONSTRAINT [PK_dmquery] PRIMARY KEY CLUSTERED 
(
	[qu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrdoc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrdoc](
	[rd_id] [int] IDENTITY(1,1) NOT NULL,
	[rd_name] [nvarchar](30) NOT NULL,
	[rd_active] [bit] NOT NULL,
	[rd_printer] [nvarchar](100) NOT NULL,
	[rd_doc] [nvarchar](max) NOT NULL,
	[rd_deftype] [nvarchar](30) NOT NULL,
	[rd_reid] [int] NOT NULL,
	[rd_printmethod] [nvarchar](30) NOT NULL,
	[rd_zebraform] [nvarchar](max) NOT NULL,
	[rd_language] [int] NOT NULL,
	[rd_printertype] [nvarchar](30) NOT NULL,
	[rd_prtdfltqty] [bit] NOT NULL,
	[rd_pdid] [int] NOT NULL,
 CONSTRAINT [PK_dmrdoc] PRIMARY KEY CLUSTERED 
(
	[rd_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrdoctag]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrdoctag](
	[rt_id] [int] IDENTITY(1,1) NOT NULL,
	[rt_name] [nvarchar](30) NOT NULL,
	[rt_active] [bit] NOT NULL,
	[rt_basetag] [nvarchar](30) NOT NULL,
	[rt_filter] [nvarchar](max) NOT NULL,
	[rt_sort] [nvarchar](max) NOT NULL,
	[rt_fields] [nvarchar](max) NOT NULL,
	[rt_distinct] [bit] NOT NULL,
	[rt_separator] [nvarchar](30) NOT NULL,
	[rt_groupby] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmrdoctag] PRIMARY KEY CLUSTERED 
(
	[rt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreas]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreas](
	[re_id] [int] IDENTITY(1,1) NOT NULL,
	[re_name] [nvarchar](30) NOT NULL,
	[re_active] [bit] NOT NULL,
	[re_default] [bit] NOT NULL,
	[re_invadj] [int] NOT NULL,
 CONSTRAINT [PK_dmreas] PRIMARY KEY CLUSTERED 
(
	[re_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreg]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreg](
	[re_id] [int] IDENTITY(1,1) NOT NULL,
	[re_name] [nvarchar](30) NOT NULL,
	[re_active] [bit] NOT NULL,
	[re_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmreg] PRIMARY KEY CLUSTERED 
(
	[re_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreggrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreggrp](
	[rg_id] [int] IDENTITY(1,1) NOT NULL,
	[rg_name] [nvarchar](30) NOT NULL,
	[rg_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmreggrp] PRIMARY KEY CLUSTERED 
(
	[rg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreggrp2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreggrp2](
	[r2_id] [int] IDENTITY(1,1) NOT NULL,
	[r2_rgid] [int] NOT NULL,
	[r2_shid] [int] NOT NULL,
	[r2_rdid] [int] NOT NULL,
	[r2_report] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmreggrp2] PRIMARY KEY CLUSTERED 
(
	[r2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmregister]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmregister](
	[rg_id] [int] IDENTITY(1,1) NOT NULL,
	[rg_name] [nvarchar](30) NOT NULL,
	[rg_active] [bit] NOT NULL,
	[rg_default] [bit] NOT NULL,
	[rg_printer] [nvarchar](100) NOT NULL,
	[rg_waid] [int] NOT NULL,
	[rg_terminalid] [nvarchar](30) NOT NULL,
	[rg_ccid] [int] NOT NULL,
 CONSTRAINT [PK_dmregister] PRIMARY KEY CLUSTERED 
(
	[rg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmregisterprinter]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmregisterprinter](
	[rp_id] [int] IDENTITY(1,1) NOT NULL,
	[rp_rgid] [int] NOT NULL,
	[rp_printer] [nvarchar](60) NOT NULL,
	[rp_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmregisterprinter] PRIMARY KEY CLUSTERED 
(
	[rp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmregisterscale]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmregisterscale](
	[rs_id] [int] IDENTITY(1,1) NOT NULL,
	[rs_rgid] [int] NOT NULL,
	[rs_smid] [int] NOT NULL,
	[rs_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmregisterscale] PRIMARY KEY CLUSTERED 
(
	[rs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreport]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreport](
	[re_id] [int] IDENTITY(1,1) NOT NULL,
	[re_name] [nvarchar](30) NOT NULL,
	[re_type] [nvarchar](30) NOT NULL,
	[re_width] [numeric](7, 3) NOT NULL,
	[re_mtop] [numeric](7, 3) NOT NULL,
	[re_mright] [numeric](7, 3) NOT NULL,
	[re_mbottom] [numeric](7, 3) NOT NULL,
	[re_mleft] [numeric](7, 3) NOT NULL,
	[re_system] [bit] NOT NULL,
	[re_orient] [nvarchar](10) NOT NULL,
	[re_orderby] [nvarchar](255) NOT NULL,
	[re_psid] [int] NOT NULL,
	[re_sumnewpage] [bit] NOT NULL,
	[re_includeheadsum] [bit] NOT NULL,
	[re_includefootsum] [bit] NOT NULL,
	[re_clientrender] [bit] NOT NULL,
	[re_backimage] [nvarchar](max) NOT NULL,
	[re_backimagename] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_dmreport] PRIMARY KEY CLUSTERED 
(
	[re_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreportband]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreportband](
	[rb_id] [int] IDENTITY(1,1) NOT NULL,
	[rb_reid] [int] NOT NULL,
	[rb_rgid] [int] NOT NULL,
	[rb_height] [numeric](7, 3) NOT NULL,
	[rb_type] [nvarchar](30) NOT NULL,
	[rb_pagethresh] [numeric](7, 3) NOT NULL,
	[rb_remove] [bit] NOT NULL,
 CONSTRAINT [PK_dmreportband] PRIMARY KEY CLUSTERED 
(
	[rb_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreportgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreportgrp](
	[rg_id] [int] IDENTITY(1,1) NOT NULL,
	[rg_level] [int] NOT NULL,
	[rg_name] [nvarchar](30) NOT NULL,
	[rg_expression] [nvarchar](max) NOT NULL,
	[rg_reid] [int] NOT NULL,
 CONSTRAINT [PK_dmreportgrp] PRIMARY KEY CLUSTERED 
(
	[rg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreportobj]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreportobj](
	[ro_id] [int] IDENTITY(1,1) NOT NULL,
	[ro_reid] [int] NOT NULL,
	[ro_rbid] [int] NOT NULL,
	[ro_class] [nvarchar](30) NOT NULL,
	[ro_width] [numeric](7, 3) NOT NULL,
	[ro_height] [numeric](7, 3) NOT NULL,
	[ro_top] [numeric](7, 3) NOT NULL,
	[ro_left] [numeric](7, 3) NOT NULL,
	[ro_borderstyle] [nvarchar](30) NOT NULL,
	[ro_bordercolor] [int] NOT NULL,
	[ro_borderweight] [int] NOT NULL,
	[ro_printwhen] [nvarchar](max) NOT NULL,
	[ro_bgcolor] [int] NOT NULL,
	[ro_printrep] [bit] NOT NULL,
	[ro_corners] [numeric](7, 3) NOT NULL,
	[ro_hshadow] [numeric](7, 3) NOT NULL,
	[ro_vshadow] [numeric](7, 3) NOT NULL,
	[ro_shadowblur] [numeric](7, 3) NOT NULL,
	[ro_shadowcolor] [int] NOT NULL,
	[ro_zindex] [int] NOT NULL,
	[ro_align] [nvarchar](30) NOT NULL,
	[ro_font] [nvarchar](60) NOT NULL,
	[ro_fontsize] [numeric](7, 3) NOT NULL,
	[ro_fieldtype] [nvarchar](30) NOT NULL,
	[ro_expression] [nvarchar](max) NOT NULL,
	[ro_c2id] [int] NOT NULL,
	[ro_fgcolor] [int] NOT NULL,
	[ro_grow] [bit] NOT NULL,
	[ro_position] [nvarchar](30) NOT NULL,
	[ro_format] [nvarchar](30) NOT NULL,
	[ro_backimage] [nvarchar](max) NOT NULL,
	[ro_backimagename] [nvarchar](60) NOT NULL,
	[ro_blocktype] [nvarchar](30) NOT NULL,
	[ro_rbeid] [int] NOT NULL,
	[ro_remove] [bit] NOT NULL,
	[ro_encoding] [nvarchar](30) NOT NULL,
	[ro_bcheight] [int] NOT NULL,
	[ro_imgtable] [nvarchar](30) NOT NULL,
	[ro_imgrecidex] [nvarchar](max) NOT NULL,
	[ro_imgdescripex] [nvarchar](max) NOT NULL,
	[ro_rotation] [int] NOT NULL,
	[ro_split] [bit] NOT NULL,
	[ro_systemlogo] [bit] NOT NULL,
	[ro_righttoleft] [bit] NOT NULL,
	[ro_textspacing] [numeric](3, 2) NOT NULL,
	[ro_limitposition] [bit] NOT NULL,
	[ro_c2guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dmreportobj] PRIMARY KEY CLUSTERED 
(
	[ro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreportorderby]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreportorderby](
	[ry_id] [int] IDENTITY(1,1) NOT NULL,
	[ry_reid] [int] NOT NULL,
	[ry_orderby] [nvarchar](60) NOT NULL,
	[ry_seq] [int] NOT NULL,
	[ry_descending] [bit] NOT NULL,
 CONSTRAINT [PK_dmreportorderby] PRIMARY KEY CLUSTERED 
(
	[ry_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmreportvar]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmreportvar](
	[rv_id] [int] IDENTITY(1,1) NOT NULL,
	[rv_reid] [int] NOT NULL,
	[rv_expression] [nvarchar](max) NOT NULL,
	[rv_name] [nvarchar](30) NOT NULL,
	[rv_reset] [nvarchar](30) NOT NULL,
	[rv_sequence] [int] NOT NULL,
	[rv_calctype] [nvarchar](30) NOT NULL,
	[rv_initvalue] [nvarchar](max) NOT NULL,
	[rv_min] [numeric](16, 4) NOT NULL,
	[rv_max] [numeric](16, 4) NOT NULL,
	[rv_parametertype] [nvarchar](30) NOT NULL,
	[rv_required] [bit] NOT NULL,
 CONSTRAINT [PK_dmreportvar] PRIMARY KEY CLUSTERED 
(
	[rv_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmretreas]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmretreas](
	[rt_id] [int] IDENTITY(1,1) NOT NULL,
	[rt_name] [nvarchar](30) NOT NULL,
	[rt_moveto] [nvarchar](30) NOT NULL,
	[rt_active] [bit] NOT NULL,
	[rt_noinv] [bit] NOT NULL,
 CONSTRAINT [PK_dmretreas] PRIMARY KEY CLUSTERED 
(
	[rt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrev]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrev](
	[re_id] [int] IDENTITY(1,1) NOT NULL,
	[re_name] [nvarchar](30) NOT NULL,
	[re_date] [datetime] NULL,
	[re_notes] [nvarchar](max) NOT NULL,
	[re_default] [bit] NOT NULL,
	[re_prid] [int] NOT NULL,
	[re_active] [bit] NOT NULL,
	[re_userid] [int] NOT NULL,
	[re_history] [nvarchar](max) NOT NULL,
	[re_yield] [numeric](20, 10) NOT NULL,
	[re_private] [bit] NOT NULL,
	[re_lastrev] [datetime] NULL,
	[re_qcid] [int] NOT NULL,
	[re_batyld] [nvarchar](30) NOT NULL,
	[re_regulat] [bit] NOT NULL,
	[re_status] [nvarchar](1) NOT NULL,
	[re_saved] [datetime] NULL,
	[re_savetime] [nvarchar](8) NOT NULL,
	[re_foid] [int] NOT NULL,
	[re_trakid] [int] NOT NULL,
	[re_trak2id] [int] NOT NULL,
	[re_unid] [int] NOT NULL,
	[re_shid] [int] NOT NULL,
	[re_revnum] [int] NOT NULL,
	[re_finatrisk] [bit] NOT NULL,
	[re_waid] [int] NOT NULL,
	[re_jcid] [int] NOT NULL,
	[re_dflttrakid] [int] NOT NULL,
	[re_subtype] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_dmrev] PRIMARY KEY CLUSTERED 
(
	[re_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrev2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrev2](
	[r2_prid] [int] NOT NULL,
	[r2_reid] [int] NOT NULL,
	[r2_id] [int] IDENTITY(1,1) NOT NULL,
	[r2_unid] [int] NOT NULL,
	[r2_notes] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmrev2] PRIMARY KEY CLUSTERED 
(
	[r2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrevconstraint]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrevconstraint](
	[rc_reid] [int] NOT NULL,
	[rc_constraint] [nvarchar](60) NOT NULL,
	[rc_source] [nvarchar](30) NOT NULL,
	[rc_forid] [int] NOT NULL,
	[rc_min] [numeric](17, 7) NOT NULL,
	[rc_max] [numeric](17, 7) NOT NULL,
	[rc_id] [int] IDENTITY(1,1) NOT NULL,
	[rc_d1id] [int] NOT NULL,
	[rc_q3id] [int] NOT NULL,
 CONSTRAINT [PK_dmrevconstraint] PRIMARY KEY CLUSTERED 
(
	[rc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrevsec]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrevsec](
	[rs_id] [int] IDENTITY(1,1) NOT NULL,
	[rs_ugid] [int] NOT NULL,
	[rs_waid] [int] NOT NULL,
	[rs_security] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmrevsec] PRIMARY KEY CLUSTERED 
(
	[rs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrnd]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrnd](
	[rn_id] [int] IDENTITY(1,1) NOT NULL,
	[rn_active] [bit] NOT NULL,
	[rn_min] [numeric](12, 2) NOT NULL,
	[rn_max] [numeric](12, 2) NOT NULL,
	[rn_rndpt] [numeric](12, 2) NOT NULL,
	[rn_downpt] [numeric](12, 2) NOT NULL,
	[rn_rndto] [numeric](12, 2) NOT NULL,
 CONSTRAINT [PK_dmrnd] PRIMARY KEY CLUSTERED 
(
	[rn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrout]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrout](
	[ro_id] [int] IDENTITY(1,1) NOT NULL,
	[ro_name] [nvarchar](30) NOT NULL,
	[ro_active] [bit] NOT NULL,
	[ro_status] [nvarchar](1) NOT NULL,
	[ro_size] [numeric](17, 7) NOT NULL,
	[ro_recalcbatchlab] [bit] NOT NULL,
	[ro_waid] [int] NOT NULL,
	[ro_usemrp] [bit] NOT NULL,
	[ro_jobmin] [numeric](17, 7) NOT NULL,
	[ro_jobquan] [numeric](17, 7) NOT NULL,
	[ro_jobinc] [numeric](17, 7) NOT NULL,
	[ro_continuous] [bit] NOT NULL,
 CONSTRAINT [PK_dmrout] PRIMARY KEY CLUSTERED 
(
	[ro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrout2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrout2](
	[r2_id] [int] IDENTITY(1,1) NOT NULL,
	[r2_prid] [int] NOT NULL,
	[r2_seq] [numeric](10, 0) NOT NULL,
	[r2_opid] [int] NOT NULL,
	[r2_ceid] [int] NOT NULL,
	[r2_pieces] [numeric](17, 7) NOT NULL,
	[r2_hours] [numeric](10, 3) NOT NULL,
	[r2_workers] [numeric](12, 2) NOT NULL,
	[r2_notes] [nvarchar](max) NOT NULL,
	[r2_batch] [bit] NOT NULL,
	[r2_roid] [int] NOT NULL,
	[r2_multiday] [bit] NOT NULL,
	[r2_leadtime] [numeric](12, 2) NOT NULL,
	[r2_crid] [int] NOT NULL,
	[r2_woid] [int] NOT NULL,
	[r2_finish] [bit] NOT NULL,
	[r2_leadtype] [nvarchar](30) NOT NULL,
	[r2_restrict] [nvarchar](30) NOT NULL,
	[r2_includeoptimize] [bit] NOT NULL,
	[r2_unavailnextseq] [bit] NOT NULL,
	[r2_zerocost] [bit] NOT NULL,
	[r2_schedblackout] [bit] NOT NULL,
 CONSTRAINT [PK_dmrout2] PRIMARY KEY CLUSTERED 
(
	[r2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrout2cent]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrout2cent](
	[rc_id] [int] IDENTITY(1,1) NOT NULL,
	[rc_r2id] [int] NOT NULL,
	[rc_ceid] [int] NOT NULL,
	[rc_seq] [numeric](10, 0) NOT NULL,
	[rc_pieces] [numeric](17, 7) NOT NULL,
	[rc_hours] [numeric](10, 3) NOT NULL,
	[rc_workers] [numeric](12, 2) NOT NULL,
	[rc_notes] [nvarchar](max) NOT NULL,
	[rc_leadtime] [numeric](12, 2) NOT NULL,
	[rc_leadtype] [nvarchar](30) NOT NULL,
	[rc_multiday] [bit] NOT NULL,
	[rc_inherit] [bit] NOT NULL,
	[rc_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmrout2cent] PRIMARY KEY CLUSTERED 
(
	[rc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrout3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrout3](
	[r3_id] [int] IDENTITY(1,1) NOT NULL,
	[r3_reid] [int] NOT NULL,
	[r3_roid] [int] NOT NULL,
	[r3_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmrout3] PRIMARY KEY CLUSTERED 
(
	[r3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrsellgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrsellgrp](
	[rs_id] [int] IDENTITY(1,1) NOT NULL,
	[rs_active] [bit] NOT NULL,
	[rs_name] [nvarchar](60) NOT NULL,
	[rs_start] [datetime] NULL,
	[rs_end] [datetime] NULL,
	[rs_interval] [int] NOT NULL,
	[rs_amount] [numeric](17, 7) NOT NULL,
	[rs_unid] [int] NOT NULL,
	[rs_basedon] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmrsellgrp] PRIMARY KEY CLUSTERED 
(
	[rs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrsellprod]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrsellprod](
	[rp_id] [int] IDENTITY(1,1) NOT NULL,
	[rp_rtid] [int] NOT NULL,
	[rp_prid] [int] NOT NULL,
	[rp_min] [numeric](17, 7) NOT NULL,
	[rp_max] [numeric](17, 7) NOT NULL,
	[rp_percentof] [numeric](10, 2) NOT NULL,
	[rp_waid] [int] NOT NULL,
 CONSTRAINT [PK_dmrsellprod] PRIMARY KEY CLUSTERED 
(
	[rp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmrselltype]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmrselltype](
	[rt_id] [int] IDENTITY(1,1) NOT NULL,
	[rt_name] [nvarchar](60) NOT NULL,
	[rt_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmrselltype] PRIMARY KEY CLUSTERED 
(
	[rt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsalut]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsalut](
	[sa_id] [int] IDENTITY(1,1) NOT NULL,
	[sa_name] [nvarchar](30) NOT NULL,
	[sa_active] [bit] NOT NULL,
	[sa_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmsalut] PRIMARY KEY CLUSTERED 
(
	[sa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmscalemodel]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmscalemodel](
	[sm_id] [int] IDENTITY(1,1) NOT NULL,
	[sm_name] [nvarchar](30) NOT NULL,
	[sm_active] [bit] NOT NULL,
	[sm_default] [bit] NOT NULL,
	[sm_baud] [int] NOT NULL,
	[sm_databits] [nvarchar](5) NOT NULL,
	[sm_stopbits] [nvarchar](5) NOT NULL,
	[sm_parity] [nvarchar](10) NOT NULL,
	[sm_handshake] [nvarchar](30) NOT NULL,
	[sm_mode] [nvarchar](30) NOT NULL,
	[sm_wgtmsgformat] [nvarchar](max) NOT NULL,
	[sm_intprecision] [nvarchar](5) NOT NULL,
	[sm_decprecision] [nvarchar](5) NOT NULL,
	[sm_decdelim] [nvarchar](5) NOT NULL,
	[sm_stabmsgformat] [nvarchar](max) NOT NULL,
	[sm_com] [nvarchar](5) NOT NULL,
	[sm_pollmsg] [nvarchar](30) NOT NULL,
	[sm_pollfreq] [int] NOT NULL,
	[sm_promptoverweight] [bit] NOT NULL,
	[sm_minwgt] [numeric](17, 7) NOT NULL,
	[sm_maxwgt] [numeric](17, 7) NOT NULL,
	[sm_noteexp] [nvarchar](max) NOT NULL,
	[sm_unid] [int] NOT NULL,
	[sm_taremsg] [nvarchar](max) NOT NULL,
	[sm_zeromsg] [nvarchar](max) NOT NULL,
	[sm_zerofinish] [bit] NOT NULL,
 CONSTRAINT [PK_dmscalemodel] PRIMARY KEY CLUSTERED 
(
	[sm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsched]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsched](
	[sc_active] [bit] NOT NULL,
	[sc_id] [int] IDENTITY(1,1) NOT NULL,
	[sc_monstart] [numeric](4, 0) NOT NULL,
	[sc_tuestart] [numeric](4, 0) NOT NULL,
	[sc_wedstart] [numeric](4, 0) NOT NULL,
	[sc_thustart] [numeric](4, 0) NOT NULL,
	[sc_fristart] [numeric](4, 0) NOT NULL,
	[sc_satstart] [numeric](4, 0) NOT NULL,
	[sc_sunstart] [numeric](4, 0) NOT NULL,
	[sc_monend] [numeric](4, 0) NOT NULL,
	[sc_tueend] [numeric](4, 0) NOT NULL,
	[sc_wedend] [numeric](4, 0) NOT NULL,
	[sc_thuend] [numeric](4, 0) NOT NULL,
	[sc_friend] [numeric](4, 0) NOT NULL,
	[sc_satend] [numeric](4, 0) NOT NULL,
	[sc_sunend] [numeric](4, 0) NOT NULL,
	[sc_type] [nvarchar](30) NOT NULL,
	[sc_typeid] [int] NOT NULL,
 CONSTRAINT [PK_dmsched] PRIMARY KEY CLUSTERED 
(
	[sc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsched2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsched2](
	[s2_id] [int] IDENTITY(1,1) NOT NULL,
	[s2_scid] [int] NOT NULL,
	[s2_dow] [int] NOT NULL,
	[s2_starttime] [int] NOT NULL,
	[s2_endtime] [int] NOT NULL,
	[s2_avail] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmsched2] PRIMARY KEY CLUSTERED 
(
	[s2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsched3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsched3](
	[s3_id] [int] IDENTITY(1,1) NOT NULL,
	[s3_type] [nvarchar](30) NOT NULL,
	[s3_typeid] [int] NOT NULL,
	[s3_start] [datetime] NULL,
	[s3_end] [datetime] NULL,
	[s3_active] [bit] NOT NULL,
	[s3_endtime] [numeric](4, 0) NOT NULL,
	[s3_starttime] [numeric](4, 0) NOT NULL,
	[s3_avail] [nvarchar](30) NOT NULL,
	[s3_name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmsched3] PRIMARY KEY CLUSTERED 
(
	[s3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmschedrule]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmschedrule](
	[sr_id] [int] IDENTITY(1,1) NOT NULL,
	[sr_name] [nvarchar](60) NOT NULL,
	[sr_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmschedrule] PRIMARY KEY CLUSTERED 
(
	[sr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmschedrulesort]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmschedrulesort](
	[ss_id] [int] IDENTITY(1,1) NOT NULL,
	[ss_srid] [int] NOT NULL,
	[ss_seq] [int] NOT NULL,
	[ss_opid] [int] NOT NULL,
	[ss_type] [nvarchar](60) NOT NULL,
	[ss_expression] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmschedrulesort] PRIMARY KEY CLUSTERED 
(
	[ss_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsecquest]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsecquest](
	[sq_id] [int] IDENTITY(1,1) NOT NULL,
	[sq_question] [nvarchar](60) NOT NULL,
	[sq_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmsecquest] PRIMARY KEY CLUSTERED 
(
	[sq_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsend]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsend](
	[se_id] [int] IDENTITY(1,1) NOT NULL,
	[se_name] [nvarchar](60) NOT NULL,
	[se_street] [nvarchar](40) NOT NULL,
	[se_street2] [nvarchar](40) NOT NULL,
	[se_city] [nvarchar](40) NOT NULL,
	[se_state] [nvarchar](40) NOT NULL,
	[se_zip] [nvarchar](40) NOT NULL,
	[se_phone] [nvarchar](30) NOT NULL,
	[se_fax] [nvarchar](30) NOT NULL,
	[se_contact] [nvarchar](30) NOT NULL,
	[se_default] [bit] NOT NULL,
	[se_active] [bit] NOT NULL,
	[se_phext] [nvarchar](30) NOT NULL,
	[se_shid] [int] NOT NULL,
	[se_ccode] [nvarchar](30) NOT NULL,
	[se_email] [nvarchar](60) NOT NULL,
	[se_country] [nvarchar](30) NOT NULL,
	[se_county] [nvarchar](30) NOT NULL,
	[se_tranwaid] [int] NOT NULL,
	[se_cyid] [int] NOT NULL,
	[se_street3] [nvarchar](40) NOT NULL,
	[se_dba] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_dmsend] PRIMARY KEY CLUSTERED 
(
	[se_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmseq1]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmseq1](
	[s1_id] [int] IDENTITY(1,1) NOT NULL,
	[s1_name] [nvarchar](30) NOT NULL,
	[s1_active] [bit] NOT NULL,
	[s1_seq] [int] NOT NULL,
 CONSTRAINT [PK_dmseq1] PRIMARY KEY CLUSTERED 
(
	[s1_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmseq2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmseq2](
	[s2_id] [int] IDENTITY(1,1) NOT NULL,
	[s2_name] [nvarchar](30) NOT NULL,
	[s2_active] [bit] NOT NULL,
	[s2_seq] [int] NOT NULL,
 CONSTRAINT [PK_dmseq2] PRIMARY KEY CLUSTERED 
(
	[s2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsgrp](
	[sg_id] [int] IDENTITY(1,1) NOT NULL,
	[sg_name] [nvarchar](30) NOT NULL,
	[sg_active] [bit] NOT NULL,
	[sg_default] [bit] NOT NULL,
	[sg_quota] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_dmsgrp] PRIMARY KEY CLUSTERED 
(
	[sg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmshift]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmshift](
	[sf_name] [nvarchar](30) NOT NULL,
	[sf_id] [int] IDENTITY(1,1) NOT NULL,
	[sf_active] [bit] NOT NULL,
	[sf_actualstart] [numeric](4, 0) NOT NULL,
	[sf_actualend] [numeric](4, 0) NOT NULL,
 CONSTRAINT [PK_dmshift] PRIMARY KEY CLUSTERED 
(
	[sf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmship]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmship](
	[sh_name] [nvarchar](60) NOT NULL,
	[sh_biid] [int] NOT NULL,
	[sh_id] [int] IDENTITY(1,1) NOT NULL,
	[sh_brid] [int] NOT NULL,
	[sh_s1id] [int] NOT NULL,
	[sh_s2id] [int] NOT NULL,
	[sh_smid] [int] NOT NULL,
	[sh_street] [nvarchar](60) NOT NULL,
	[sh_street2] [nvarchar](60) NOT NULL,
	[sh_city] [nvarchar](40) NOT NULL,
	[sh_state] [nvarchar](40) NOT NULL,
	[sh_zip] [nvarchar](40) NOT NULL,
	[sh_phone] [nvarchar](30) NOT NULL,
	[sh_fax] [nvarchar](30) NOT NULL,
	[sh_contact] [nvarchar](30) NOT NULL,
	[sh_trid] [int] NOT NULL,
	[sh_waid] [int] NOT NULL,
	[sh_active] [bit] NOT NULL,
	[sh_statax] [int] NOT NULL,
	[sh_loctax] [int] NOT NULL,
	[sh_notes] [nvarchar](max) NOT NULL,
	[sh_country] [nvarchar](40) NOT NULL,
	[sh_ccode] [nvarchar](30) NOT NULL,
	[sh_default] [bit] NOT NULL,
	[sh_county] [nvarchar](40) NOT NULL,
	[sh_custid] [nvarchar](30) NOT NULL,
	[sh_email] [nvarchar](max) NOT NULL,
	[sh_frid] [int] NOT NULL,
	[sh_s3id] [int] NOT NULL,
	[sh_webname] [nvarchar](30) NOT NULL,
	[sh_webpass] [nvarchar](100) NOT NULL,
	[sh_s4id] [int] NOT NULL,
	[sh_s5id] [int] NOT NULL,
	[sh_credlim] [numeric](12, 0) NOT NULL,
	[sh_pastday] [numeric](10, 0) NOT NULL,
	[sh_credhld] [datetime] NULL,
	[sh_collect] [nvarchar](max) NOT NULL,
	[sh_teid] [int] NOT NULL,
	[sh_phext] [nvarchar](30) NOT NULL,
	[sh_lastcred] [datetime] NULL,
	[sh_nextact] [nvarchar](30) NOT NULL,
	[sh_nextdate] [datetime] NULL,
	[sh_exid] [int] NOT NULL,
	[sh_dear] [nvarchar](30) NOT NULL,
	[sh_said] [int] NOT NULL,
	[sh_tranwaid] [int] NOT NULL,
	[sh_fcid] [int] NOT NULL,
	[sh_pjid] [int] NOT NULL,
	[sh_popup] [nvarchar](max) NOT NULL,
	[sh_quota] [numeric](10, 0) NOT NULL,
	[sh_exempt] [bit] NOT NULL,
	[sh_service] [bit] NOT NULL,
	[sh_exceed] [numeric](10, 0) NOT NULL,
	[sh_exday] [numeric](10, 0) NOT NULL,
	[sh_credflag] [bit] NOT NULL,
	[sh_dgid] [int] NOT NULL,
	[sh_psid] [int] NOT NULL,
	[sh_poreqd] [bit] NOT NULL,
	[sh_pomask] [nvarchar](30) NOT NULL,
	[sh_waretaxover] [bit] NOT NULL,
	[sh_shelfpct] [numeric](10, 0) NOT NULL,
	[sh_popupship] [nvarchar](max) NOT NULL,
	[sh_dba] [nvarchar](40) NOT NULL,
	[sh_trakid] [int] NOT NULL,
	[sh_trak2id] [int] NOT NULL,
	[sh_shelfdays] [numeric](10, 0) NOT NULL,
	[sh_sotrakid] [int] NOT NULL,
	[sh_prior] [int] NOT NULL,
	[sh_crosswaid] [int] NOT NULL,
	[sh_bomon] [int] NOT NULL,
	[sh_bofulltr] [bit] NOT NULL,
	[sh_bofullpl] [bit] NOT NULL,
	[sh_botue] [int] NOT NULL,
	[sh_bowed] [int] NOT NULL,
	[sh_bothu] [int] NOT NULL,
	[sh_bofri] [int] NOT NULL,
	[sh_bosat] [int] NOT NULL,
	[sh_bosun] [int] NOT NULL,
	[sh_exreserve] [bit] NOT NULL,
	[sh_routeacct] [bit] NOT NULL,
	[sh_latitude] [numeric](10, 5) NOT NULL,
	[sh_longitude] [numeric](10, 5) NOT NULL,
	[sh_shortship] [nvarchar](30) NOT NULL,
	[sh_reqdsdsig] [bit] NOT NULL,
	[sh_shipzone] [nvarchar](30) NOT NULL,
	[sh_reqcpart] [bit] NOT NULL,
	[sh_availall] [bit] NOT NULL,
	[sh_street3] [nvarchar](60) NOT NULL,
	[sh_ccid] [int] NOT NULL,
	[sh_prtdgrpto] [nvarchar](30) NOT NULL,
	[sh_caid] [int] NOT NULL,
	[sh_noinvdflt] [bit] NOT NULL,
	[sh_noreserve] [bit] NOT NULL,
	[sh_retattrib1] [bit] NOT NULL,
	[sh_retattrib2] [bit] NOT NULL,
	[sh_retattrib3] [bit] NOT NULL,
	[sh_retdates] [bit] NOT NULL,
	[sh_laststateprint] [datetime] NULL,
	[sh_creddueshipdays] [int] NOT NULL,
	[sh_ttid] [int] NOT NULL,
	[sh_addressvalid] [datetime] NULL,
	[sh_svctype] [nvarchar](60) NOT NULL,
	[sh_edishiptopo] [bit] NOT NULL,
	[sh_edishiptopodays] [int] NOT NULL,
	[sh_retainreservedbo] [bit] NOT NULL,
	[sh_exemptexpires] [datetime] NULL,
	[sh_linkedjobfinish] [nvarchar](30) NOT NULL,
	[sh_vatid] [nvarchar](30) NOT NULL,
	[sh_cyid] [int] NOT NULL,
	[sh_serializeonreserve] [bit] NOT NULL,
	[sh_taxexemptcode] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmship] PRIMARY KEY CLUSTERED 
(
	[sh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmshipacc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmshipacc](
	[sa_id] [int] IDENTITY(1,1) NOT NULL,
	[sa_shid] [int] NOT NULL,
	[sa_trid] [int] NOT NULL,
	[sa_active] [bit] NOT NULL,
	[sa_default] [bit] NOT NULL,
	[sa_descrip] [nvarchar](max) NOT NULL,
	[sa_name] [nvarchar](30) NOT NULL,
	[sa_account] [nvarchar](30) NOT NULL,
	[sa_svctype] [nvarchar](60) NOT NULL,
	[sa_svcprovider] [nvarchar](30) NOT NULL,
	[sa_biid] [int] NOT NULL,
	[sa_billtype] [bit] NOT NULL,
 CONSTRAINT [PK_dmshipacc] PRIMARY KEY CLUSTERED 
(
	[sa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmshipfacility]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmshipfacility](
	[sf_id] [int] IDENTITY(1,1) NOT NULL,
	[sf_shid] [int] NOT NULL,
	[sf_waid] [int] NOT NULL,
	[sf_s1id] [int] NOT NULL,
	[sf_s2id] [int] NOT NULL,
	[sf_s3id] [int] NOT NULL,
	[sf_s4id] [int] NOT NULL,
	[sf_s5id] [int] NOT NULL,
	[sf_brid] [int] NOT NULL,
	[sf_trid] [int] NOT NULL,
	[sf_frid] [int] NOT NULL,
	[sf_dgid] [int] NOT NULL,
	[sf_psid] [int] NOT NULL,
	[sf_sotrakid] [int] NOT NULL,
	[sf_pjid] [int] NOT NULL,
	[sf_fcid] [int] NOT NULL,
	[sf_shipzone] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_dmshipfacility] PRIMARY KEY CLUSTERED 
(
	[sf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmshop]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmshop](
	[sh_id] [int] IDENTITY(1,1) NOT NULL,
	[sh_name] [nvarchar](30) NOT NULL,
	[sh_active] [bit] NOT NULL,
	[sh_default] [bit] NOT NULL,
	[sh_waid] [int] NOT NULL,
 CONSTRAINT [PK_dmshop] PRIMARY KEY CLUSTERED 
(
	[sh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmshoploc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmshoploc](
	[sl_id] [int] IDENTITY(1,1) NOT NULL,
	[sl_loid] [int] NOT NULL,
	[sl_seq] [int] NOT NULL,
	[sl_shid] [int] NOT NULL,
 CONSTRAINT [PK_dmshoploc] PRIMARY KEY CLUSTERED 
(
	[sl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsman]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsman](
	[sm_id] [int] IDENTITY(1,1) NOT NULL,
	[sm_fname] [nvarchar](30) NOT NULL,
	[sm_lname] [nvarchar](60) NOT NULL,
	[sm_street] [nvarchar](40) NOT NULL,
	[sm_street2] [nvarchar](40) NOT NULL,
	[sm_city] [nvarchar](40) NOT NULL,
	[sm_state] [nvarchar](40) NOT NULL,
	[sm_zip] [nvarchar](40) NOT NULL,
	[sm_hphone] [nvarchar](30) NOT NULL,
	[sm_fax] [nvarchar](30) NOT NULL,
	[sm_cphone] [nvarchar](30) NOT NULL,
	[sm_beeper] [nvarchar](30) NOT NULL,
	[sm_active] [bit] NOT NULL,
	[sm_default] [bit] NOT NULL,
	[sm_webname] [nvarchar](30) NOT NULL,
	[sm_webpass] [nvarchar](100) NOT NULL,
	[sm_sgid] [int] NOT NULL,
	[sm_quota] [numeric](10, 0) NOT NULL,
	[sm_email] [nvarchar](60) NOT NULL,
	[sm_mobileid] [int] NOT NULL,
	[sm_eligible] [bit] NOT NULL,
	[sm_ccode] [nvarchar](30) NOT NULL,
	[sm_veid] [int] NOT NULL,
	[sm_cyid] [int] NOT NULL,
	[sm_repid] [nvarchar](30) NOT NULL,
	[sm_managersmid] [int] NOT NULL,
 CONSTRAINT [PK_dmsman] PRIMARY KEY CLUSTERED 
(
	[sm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsman2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsman2](
	[s2_id] [int] IDENTITY(1,1) NOT NULL,
	[s2_smid] [int] NOT NULL,
	[s2_pct] [numeric](10, 2) NOT NULL,
	[s2_table] [nvarchar](30) NOT NULL,
	[s2_recid] [int] NOT NULL,
	[s2_primary] [bit] NOT NULL,
	[s2_changeuser] [bit] NOT NULL,
	[s2_scid] [int] NOT NULL,
 CONSTRAINT [PK_dmsman2] PRIMARY KEY CLUSTERED 
(
	[s2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsman2cat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsman2cat](
	[sc_id] [int] IDENTITY(1,1) NOT NULL,
	[sc_name] [nvarchar](60) NOT NULL,
	[sc_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmsman2cat] PRIMARY KEY CLUSTERED 
(
	[sc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmso1]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmso1](
	[s1_id] [int] IDENTITY(1,1) NOT NULL,
	[s1_name] [nvarchar](30) NOT NULL,
	[s1_active] [bit] NOT NULL,
	[s1_default] [bit] NOT NULL,
	[s1_quota] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_dmso1] PRIMARY KEY CLUSTERED 
(
	[s1_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmso2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmso2](
	[s2_id] [int] IDENTITY(1,1) NOT NULL,
	[s2_active] [bit] NOT NULL,
	[s2_default] [bit] NOT NULL,
	[s2_name] [nvarchar](30) NOT NULL,
	[s2_quota] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_dmso2] PRIMARY KEY CLUSTERED 
(
	[s2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmso3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmso3](
	[s3_id] [int] IDENTITY(1,1) NOT NULL,
	[s3_name] [nvarchar](30) NOT NULL,
	[s3_active] [bit] NOT NULL,
	[s3_default] [bit] NOT NULL,
	[s3_quota] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_dmso3] PRIMARY KEY CLUSTERED 
(
	[s3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmso4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmso4](
	[s4_id] [int] IDENTITY(1,1) NOT NULL,
	[s4_active] [bit] NOT NULL,
	[s4_default] [bit] NOT NULL,
	[s4_name] [nvarchar](30) NOT NULL,
	[s4_quota] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_dmso4] PRIMARY KEY CLUSTERED 
(
	[s4_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmso5]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmso5](
	[s5_id] [int] IDENTITY(1,1) NOT NULL,
	[s5_active] [bit] NOT NULL,
	[s5_default] [bit] NOT NULL,
	[s5_name] [nvarchar](30) NOT NULL,
	[s5_quota] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_dmso5] PRIMARY KEY CLUSTERED 
(
	[s5_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmstability]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmstability](
	[st_id] [int] IDENTITY(1,1) NOT NULL,
	[st_reid] [int] NOT NULL,
	[st_qcid] [int] NOT NULL,
	[st_days] [int] NOT NULL,
	[st_freqtype] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmstability] PRIMARY KEY CLUSTERED 
(
	[st_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmstat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmstat](
	[st_id] [int] IDENTITY(1,1) NOT NULL,
	[st_active] [bit] NOT NULL,
	[st_default] [bit] NOT NULL,
	[st_name] [nvarchar](30) NOT NULL,
	[st_level] [int] NOT NULL,
	[st_dxnew] [bit] NOT NULL,
	[st_resolve] [bit] NOT NULL,
 CONSTRAINT [PK_dmstat] PRIMARY KEY CLUSTERED 
(
	[st_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsubs]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsubs](
	[su_id] [int] IDENTITY(1,1) NOT NULL,
	[su_child] [int] NOT NULL,
	[su_parent] [int] NOT NULL,
	[su_quant] [numeric](17, 7) NOT NULL,
	[su_factor] [numeric](17, 7) NOT NULL,
	[su_priority] [int] NOT NULL,
	[su_subtype] [nvarchar](30) NOT NULL,
	[su_table] [nvarchar](30) NOT NULL,
	[su_start] [datetime] NULL,
	[su_end] [datetime] NULL,
	[su_boid] [int] NOT NULL,
	[su_suball] [bit] NOT NULL,
	[su_recid] [int] NOT NULL,
 CONSTRAINT [PK_dmsubs] PRIMARY KEY CLUSTERED 
(
	[su_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsvccontract]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsvccontract](
	[sc_id] [int] IDENTITY(1,1) NOT NULL,
	[sc_active] [bit] NOT NULL,
	[sc_default] [bit] NOT NULL,
	[sc_name] [nvarchar](30) NOT NULL,
	[sc_descrip] [nvarchar](60) NOT NULL,
	[sc_priority] [int] NOT NULL,
 CONSTRAINT [PK_dmsvccontract] PRIMARY KEY CLUSTERED 
(
	[sc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsvcitem]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsvcitem](
	[si_id] [int] IDENTITY(1,1) NOT NULL,
	[si_name] [nvarchar](30) NOT NULL,
	[si_prid] [int] NOT NULL,
	[si_serial] [nvarchar](30) NOT NULL,
	[si_scid] [int] NOT NULL,
	[si_biid] [int] NOT NULL,
	[si_shid] [int] NOT NULL,
	[si_active] [bit] NOT NULL,
	[si_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmsvcitem] PRIMARY KEY CLUSTERED 
(
	[si_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmsvclabor]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmsvclabor](
	[sl_id] [int] IDENTITY(1,1) NOT NULL,
	[sl_name] [nvarchar](30) NOT NULL,
	[sl_opid] [int] NOT NULL,
	[sl_prid] [int] NOT NULL,
	[sl_table] [nvarchar](30) NOT NULL,
	[sl_recid] [int] NOT NULL,
 CONSTRAINT [PK_dmsvclabor] PRIMARY KEY CLUSTERED 
(
	[sl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtaskcat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtaskcat](
	[tc_active] [bit] NOT NULL,
	[tc_default] [bit] NOT NULL,
	[tc_id] [int] IDENTITY(1,1) NOT NULL,
	[tc_name] [nvarchar](60) NOT NULL,
	[tc_weight] [numeric](17, 2) NOT NULL,
 CONSTRAINT [PK_dmtaskcat] PRIMARY KEY CLUSTERED 
(
	[tc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtaskcatstat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtaskcatstat](
	[ts_active] [bit] NOT NULL,
	[ts_default] [bit] NOT NULL,
	[ts_id] [int] IDENTITY(1,1) NOT NULL,
	[ts_incperc] [bit] NOT NULL,
	[ts_name] [nvarchar](60) NOT NULL,
	[ts_percentage] [int] NOT NULL,
	[ts_tcid] [int] NOT NULL,
 CONSTRAINT [PK_dmtaskcatstat] PRIMARY KEY CLUSTERED 
(
	[ts_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtax]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtax](
	[ta_id] [int] IDENTITY(1,1) NOT NULL,
	[ta_name] [nvarchar](30) NOT NULL,
	[ta_chid] [int] NOT NULL,
	[ta_rate] [numeric](10, 4) NOT NULL,
	[ta_active] [bit] NOT NULL,
	[ta_default] [bit] NOT NULL,
	[ta_type] [nvarchar](30) NOT NULL,
	[ta_maxtax] [numeric](12, 2) NOT NULL,
	[ta_pochid] [int] NOT NULL,
	[ta_apply] [nvarchar](30) NOT NULL,
	[ta_notes] [nvarchar](max) NOT NULL,
	[ta_taxjar] [bit] NOT NULL,
 CONSTRAINT [PK_dmtax] PRIMARY KEY CLUSTERED 
(
	[ta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtaxlink]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtaxlink](
	[tl_id] [int] IDENTITY(1,1) NOT NULL,
	[tl_recid] [int] NOT NULL,
	[tl_table] [nvarchar](30) NOT NULL,
	[tl_taid] [int] NOT NULL,
	[tl_active] [bit] NOT NULL,
	[tl_rate] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dmtaxlink] PRIMARY KEY CLUSTERED 
(
	[tl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmterm]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmterm](
	[te_id] [int] IDENTITY(1,1) NOT NULL,
	[te_discoun] [numeric](7, 4) NOT NULL,
	[te_discday] [numeric](10, 0) NOT NULL,
	[te_active] [bit] NOT NULL,
	[te_endday] [numeric](2, 0) NOT NULL,
	[te_dueday] [numeric](10, 0) NOT NULL,
	[te_finchar] [numeric](10, 4) NOT NULL,
	[te_future] [bit] NOT NULL,
	[te_billtype] [nvarchar](30) NOT NULL,
	[te_duetype] [nvarchar](30) NOT NULL,
	[te_disctype] [nvarchar](30) NOT NULL,
	[te_name] [nvarchar](60) NOT NULL,
	[te_discmon] [numeric](10, 0) NOT NULL,
	[te_duemon] [numeric](10, 0) NOT NULL,
	[te_multipay] [bit] NOT NULL,
	[te_payments] [numeric](10, 0) NOT NULL,
	[te_reqauth] [bit] NOT NULL,
	[te_interest] [numeric](12, 2) NOT NULL,
	[te_notes] [nvarchar](max) NOT NULL,
	[te_ccprocess] [nvarchar](30) NOT NULL,
	[te_ccperc] [numeric](6, 2) NOT NULL,
	[te_discdayyear] [datetime] NULL,
	[te_duedayyear] [datetime] NULL,
	[te_prepay] [bit] NOT NULL,
	[te_multibackord] [bit] NOT NULL,
	[te_reauthbackord] [bit] NOT NULL,
 CONSTRAINT [PK_dmterm] PRIMARY KEY CLUSTERED 
(
	[te_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmterm2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmterm2](
	[t2_id] [int] IDENTITY(1,1) NOT NULL,
	[t2_teid] [int] NOT NULL,
	[t2_table] [nvarchar](30) NOT NULL,
	[t2_recid] [int] NOT NULL,
 CONSTRAINT [PK_dmterm2] PRIMARY KEY CLUSTERED 
(
	[t2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmterritory]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmterritory](
	[tt_id] [int] IDENTITY(1,1) NOT NULL,
	[tt_name] [nvarchar](60) NOT NULL,
	[tt_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmterritory] PRIMARY KEY CLUSTERED 
(
	[tt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmterritorygrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmterritorygrp](
	[tg_id] [int] IDENTITY(1,1) NOT NULL,
	[tg_name] [nvarchar](30) NOT NULL,
	[tg_active] [bit] NOT NULL,
	[tg_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmterritorygrp] PRIMARY KEY CLUSTERED 
(
	[tg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmterritorygrplink]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmterritorygrplink](
	[tl_id] [int] IDENTITY(1,1) NOT NULL,
	[tl_tgid] [int] NOT NULL,
	[tl_ttid] [int] NOT NULL,
 CONSTRAINT [PK_dmterritorygrplink] PRIMARY KEY CLUSTERED 
(
	[tl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtest]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtest](
	[te_id] [int] IDENTITY(1,1) NOT NULL,
	[te_tcid] [int] NOT NULL,
	[te_name] [nvarchar](30) NOT NULL,
	[te_valid] [nvarchar](max) NOT NULL,
	[te_usid] [int] NOT NULL,
	[te_active] [bit] NOT NULL,
	[te_code] [nvarchar](max) NOT NULL,
	[te_recurring] [bit] NOT NULL,
	[te_notes] [nvarchar](max) NOT NULL,
	[te_seq] [numeric](10, 0) NOT NULL,
	[te_impact] [nvarchar](30) NOT NULL,
	[te_stability] [nvarchar](30) NOT NULL,
	[te_ref] [nvarchar](100) NOT NULL,
	[te_tsid] [int] NOT NULL,
	[te_depends] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmtest] PRIMARY KEY CLUSTERED 
(
	[te_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtestcat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtestcat](
	[tc_id] [int] IDENTITY(1,1) NOT NULL,
	[tc_name] [nvarchar](60) NOT NULL,
	[tc_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmtestcat] PRIMARY KEY CLUSTERED 
(
	[tc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtestcatsub]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtestcatsub](
	[ts_name] [nvarchar](60) NOT NULL,
	[ts_tcid] [int] NOT NULL,
	[ts_active] [bit] NOT NULL,
	[ts_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dmtestcatsub] PRIMARY KEY CLUSTERED 
(
	[ts_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtgrp](
	[tg_id] [int] IDENTITY(1,1) NOT NULL,
	[tg_name] [nvarchar](30) NOT NULL,
	[tg_active] [bit] NOT NULL,
	[tg_default] [bit] NOT NULL,
	[tg_code] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmtgrp] PRIMARY KEY CLUSTERED 
(
	[tg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtgrp2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtgrp2](
	[t2_id] [int] IDENTITY(1,1) NOT NULL,
	[t2_tgid] [int] NOT NULL,
	[t2_shid] [int] NOT NULL,
	[t2_expires] [datetime] NULL,
 CONSTRAINT [PK_dmtgrp2] PRIMARY KEY CLUSTERED 
(
	[t2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmti1]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmti1](
	[t1_id] [int] IDENTITY(1,1) NOT NULL,
	[t1_name] [nvarchar](30) NOT NULL,
	[t1_active] [bit] NOT NULL,
	[t1_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmti1] PRIMARY KEY CLUSTERED 
(
	[t1_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmti2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmti2](
	[t2_id] [int] IDENTITY(1,1) NOT NULL,
	[t2_name] [nvarchar](30) NOT NULL,
	[t2_active] [bit] NOT NULL,
	[t2_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmti2] PRIMARY KEY CLUSTERED 
(
	[t2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmti3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmti3](
	[t3_id] [int] IDENTITY(1,1) NOT NULL,
	[t3_name] [nvarchar](30) NOT NULL,
	[t3_active] [bit] NOT NULL,
	[t3_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmti3] PRIMARY KEY CLUSTERED 
(
	[t3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmti4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmti4](
	[t4_id] [int] IDENTITY(1,1) NOT NULL,
	[t4_name] [nvarchar](30) NOT NULL,
	[t4_active] [bit] NOT NULL,
	[t4_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmti4] PRIMARY KEY CLUSTERED 
(
	[t4_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmti5]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmti5](
	[t5_id] [int] IDENTITY(1,1) NOT NULL,
	[t5_name] [nvarchar](30) NOT NULL,
	[t5_active] [bit] NOT NULL,
	[t5_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmti5] PRIMARY KEY CLUSTERED 
(
	[t5_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmticketcats]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmticketcats](
	[tc_id] [int] IDENTITY(1,1) NOT NULL,
	[tc_active] [bit] NOT NULL,
	[tc_name] [nvarchar](30) NOT NULL,
	[tc_default] [bit] NOT NULL,
 CONSTRAINT [PK_dmticketcats] PRIMARY KEY CLUSTERED 
(
	[tc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmticketcatsec]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmticketcatsec](
	[ts_id] [int] IDENTITY(1,1) NOT NULL,
	[ts_access] [nvarchar](30) NOT NULL,
	[ts_tcid] [int] NOT NULL,
	[ts_ugid] [int] NOT NULL,
 CONSTRAINT [PK_dmticketcatsec] PRIMARY KEY CLUSTERED 
(
	[ts_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmticknotetype]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmticknotetype](
	[te_active] [bit] NOT NULL,
	[te_default] [bit] NOT NULL,
	[te_name] [nvarchar](30) NOT NULL,
	[te_id] [int] IDENTITY(1,1) NOT NULL,
	[te_noid] [int] NOT NULL,
 CONSTRAINT [PK_dmticknotetype] PRIMARY KEY CLUSTERED 
(
	[te_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtruk]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtruk](
	[tr_id] [int] IDENTITY(1,1) NOT NULL,
	[tr_name] [nvarchar](50) NOT NULL,
	[tr_active] [bit] NOT NULL,
	[tr_default] [bit] NOT NULL,
	[tr_contact] [nvarchar](40) NOT NULL,
	[tr_street] [nvarchar](40) NOT NULL,
	[tr_street2] [nvarchar](40) NOT NULL,
	[tr_city] [nvarchar](40) NOT NULL,
	[tr_state] [nvarchar](40) NOT NULL,
	[tr_zip] [nvarchar](40) NOT NULL,
	[tr_phone] [nvarchar](30) NOT NULL,
	[tr_fax] [nvarchar](30) NOT NULL,
	[tr_email] [nvarchar](60) NOT NULL,
	[tr_maxwgt] [numeric](10, 0) NOT NULL,
	[tr_ccode] [nvarchar](30) NOT NULL,
	[tr_svctype] [nvarchar](50) NOT NULL,
	[tr_loadunid] [int] NOT NULL,
	[tr_loadsize] [numeric](17, 7) NOT NULL,
	[tr_splitload] [bit] NOT NULL,
	[tr_carcode] [nvarchar](10) NOT NULL,
	[tr_veid] [int] NOT NULL,
	[tr_cyid] [int] NOT NULL,
	[tr_packinstreq] [bit] NOT NULL,
	[tr_picktime] [numeric](4, 0) NOT NULL,
	[tr_pickday] [nvarchar](1) NOT NULL,
	[tr_shipday] [nvarchar](1) NOT NULL,
	[tr_delday] [nvarchar](1) NOT NULL,
	[tr_minord] [numeric](17, 7) NOT NULL,
	[tr_labor] [numeric](17, 7) NOT NULL,
	[tr_burden] [numeric](17, 7) NOT NULL,
	[tr_approvalreq] [bit] NOT NULL,
	[tr_dsdinvsync] [bit] NOT NULL,
	[tr_dsdinvsyncloc] [int] NOT NULL,
	[tr_svcprovider] [nvarchar](30) NOT NULL,
	[tr_shipdays] [int] NOT NULL,
	[tr_deliverydays] [int] NOT NULL,
	[tr_splitloadsize] [nvarchar](30) NOT NULL,
	[tr_country] [nvarchar](40) NOT NULL,
	[tr_deliverto] [bit] NOT NULL,
	[tr_dsdloid] [int] NOT NULL,
	[tr_dsdchid] [int] NOT NULL,
	[tr_ordtype] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmtruk] PRIMARY KEY CLUSTERED 
(
	[tr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtrukauth]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtrukauth](
	[ta_id] [int] IDENTITY(1,1) NOT NULL,
	[ta_shid] [int] NOT NULL,
	[ta_trid] [int] NOT NULL,
	[ta_waid] [int] NOT NULL,
	[ta_minord] [numeric](17, 7) NOT NULL,
	[ta_labor] [numeric](17, 7) NOT NULL,
	[ta_burden] [numeric](17, 7) NOT NULL,
	[ta_overridedefault] [bit] NOT NULL,
	[ta_seq] [int] NOT NULL,
 CONSTRAINT [PK_dmtrukauth] PRIMARY KEY CLUSTERED 
(
	[ta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtrukfacility]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtrukfacility](
	[tf_id] [int] IDENTITY(1,1) NOT NULL,
	[tf_trid] [int] NOT NULL,
	[tf_waid] [int] NOT NULL,
	[tf_ordtype] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmtrukfacility] PRIMARY KEY CLUSTERED 
(
	[tf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtrukpickdays]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtrukpickdays](
	[td_id] [int] IDENTITY(1,1) NOT NULL,
	[td_trid] [int] NOT NULL,
	[td_day] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmtrukpickdays] PRIMARY KEY CLUSTERED 
(
	[td_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmtype]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmtype](
	[ty_id] [int] IDENTITY(1,1) NOT NULL,
	[ty_name] [nvarchar](60) NOT NULL,
	[ty_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmtype] PRIMARY KEY CLUSTERED 
(
	[ty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmunit]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmunit](
	[un_id] [int] IDENTITY(1,1) NOT NULL,
	[un_name] [nvarchar](30) NOT NULL,
	[un_active] [bit] NOT NULL,
	[un_default] [bit] NOT NULL,
	[un_type] [nvarchar](1) NOT NULL,
	[un_base] [bit] NOT NULL,
	[un_factor] [numeric](20, 10) NOT NULL,
	[un_shipmins] [numeric](17, 7) NOT NULL,
	[un_recmins] [numeric](17, 7) NOT NULL,
	[un_restcontunid] [bit] NOT NULL,
	[un_fedexfactor] [numeric](20, 10) NOT NULL,
	[un_fedexunit] [nvarchar](5) NOT NULL,
	[un_edicode] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dmunit] PRIMARY KEY CLUSTERED 
(
	[un_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmunitmins]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmunitmins](
	[um_id] [int] IDENTITY(1,1) NOT NULL,
	[um_recid] [int] NOT NULL,
	[um_table] [nvarchar](30) NOT NULL,
	[um_unid] [int] NOT NULL,
	[um_recmins] [numeric](17, 7) NOT NULL,
	[um_shipmins] [numeric](17, 7) NOT NULL,
	[um_restrictreceiveunit] [bit] NOT NULL,
	[um_restrictcountunit] [bit] NOT NULL,
	[um_restrictedsalesunit] [bit] NOT NULL,
 CONSTRAINT [PK_dmunitmins] PRIMARY KEY CLUSTERED 
(
	[um_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmurst]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmurst](
	[ur_usid] [int] NOT NULL,
	[ur_waid] [int] NOT NULL,
	[ur_smid] [int] NOT NULL,
	[ur_foid] [int] NOT NULL,
	[ur_lgid] [int] NOT NULL,
	[ur_reid] [int] NOT NULL,
	[ur_allow] [bit] NOT NULL,
	[ur_id] [int] IDENTITY(1,1) NOT NULL,
	[ur_sgid] [int] NOT NULL,
	[ur_ordenter] [bit] NOT NULL,
	[ur_purenter] [bit] NOT NULL,
	[ur_daid] [int] NOT NULL,
	[ur_mobileid] [int] NOT NULL,
	[ur_buid] [int] NOT NULL,
	[ur_biid] [int] NOT NULL,
	[ur_brid] [int] NOT NULL,
	[ur_shid] [int] NOT NULL,
	[ur_veid] [int] NOT NULL,
	[ur_lastemailpull] [datetime] NULL,
	[ur_zoid] [int] NOT NULL,
	[ur_interface] [nvarchar](30) NOT NULL,
	[ur_coid] [int] NOT NULL,
	[ur_mrid] [int] NOT NULL,
	[ur_ttid] [int] NOT NULL,
	[ur_tgid] [int] NOT NULL,
	[ur_facpartsrestrict] [bit] NOT NULL,
 CONSTRAINT [PK_dmurst] PRIMARY KEY CLUSTERED 
(
	[ur_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmuserlayout]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmuserlayout](
	[ul_id] [int] IDENTITY(1,1) NOT NULL,
	[ul_class] [nvarchar](30) NOT NULL,
	[ul_descrip] [nvarchar](60) NOT NULL,
	[ul_fortype] [nvarchar](30) NOT NULL,
	[ul_c2id] [int] NOT NULL,
	[ul_forid] [bigint] NOT NULL,
	[ul_active] [bit] NOT NULL,
	[ul_device] [nvarchar](30) NOT NULL,
	[ul_c2guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dmuserlayout] PRIMARY KEY CLUSTERED 
(
	[ul_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmuserlayoutcontrol]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmuserlayoutcontrol](
	[uc_id] [int] IDENTITY(1,1) NOT NULL,
	[uc_type] [nvarchar](30) NOT NULL,
	[uc_function] [nvarchar](60) NOT NULL,
	[uc_parent] [int] NOT NULL,
	[uc_seq] [int] NOT NULL,
	[uc_column] [int] NOT NULL,
	[uc_disable] [bit] NOT NULL,
	[uc_hide] [bit] NOT NULL,
	[uc_require] [bit] NOT NULL,
	[uc_c2id] [int] NOT NULL,
	[uc_ulid] [bigint] NOT NULL,
	[uc_unique] [nvarchar](30) NOT NULL,
	[uc_defaultvalue] [nvarchar](60) NOT NULL,
	[uc_scaleinput] [bit] NOT NULL,
	[uc_searchboxoverride] [nvarchar](max) NOT NULL,
	[uc_srnumber] [int] NOT NULL,
	[uc_c2guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dmuserlayoutcontrol] PRIMARY KEY CLUSTERED 
(
	[uc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmuserlayoutdeletion]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmuserlayoutdeletion](
	[ud_id] [int] IDENTITY(1,1) NOT NULL,
	[ud_function] [nvarchar](60) NOT NULL,
	[ud_ulid] [int] NOT NULL,
 CONSTRAINT [PK_dmuserlayoutdeletion] PRIMARY KEY CLUSTERED 
(
	[ud_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmuserlayoutproperty]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmuserlayoutproperty](
	[up_id] [int] IDENTITY(1,1) NOT NULL,
	[up_ulid] [int] NOT NULL,
	[up_ucid] [int] NOT NULL,
	[up_property] [nvarchar](30) NOT NULL,
	[up_intval] [int] NOT NULL,
	[up_charval] [nvarchar](30) NOT NULL,
	[up_memoval] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmuserlayoutproperty] PRIMARY KEY CLUSTERED 
(
	[up_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmuserprtdest]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmuserprtdest](
	[ud_id] [int] IDENTITY(1,1) NOT NULL,
	[ud_pdid] [int] NOT NULL,
	[ud_printer] [nvarchar](100) NOT NULL,
	[ud_usid] [int] NOT NULL,
 CONSTRAINT [PK_dmuserprtdest] PRIMARY KEY CLUSTERED 
(
	[ud_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmvalid]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmvalid](
	[va_id] [int] IDENTITY(1,1) NOT NULL,
	[va_validnum] [nvarchar](30) NOT NULL,
	[va_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmvalid] PRIMARY KEY CLUSTERED 
(
	[va_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmvat]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmvat](
	[va_id] [int] IDENTITY(1,1) NOT NULL,
	[va_name] [nvarchar](60) NOT NULL,
	[va_type] [nvarchar](30) NOT NULL,
	[va_typeid] [int] NOT NULL,
	[va_on] [nvarchar](30) NOT NULL,
	[va_onid] [int] NOT NULL,
	[va_saleschid] [int] NOT NULL,
	[va_purchasechid] [int] NOT NULL,
 CONSTRAINT [PK_dmvat] PRIMARY KEY CLUSTERED 
(
	[va_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmvatrate]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmvatrate](
	[vr_id] [int] IDENTITY(1,1) NOT NULL,
	[vr_rate] [numeric](10, 7) NOT NULL,
	[vr_startdate] [datetime] NULL,
	[vr_enddate] [datetime] NULL,
	[vr_vaid] [int] NOT NULL,
 CONSTRAINT [PK_dmvatrate] PRIMARY KEY CLUSTERED 
(
	[vr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmvehicle]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmvehicle](
	[vc_id] [int] IDENTITY(1,1) NOT NULL,
	[vc_vehicle] [nvarchar](30) NOT NULL,
	[vc_active] [bit] NOT NULL,
	[vc_waid] [int] NOT NULL,
 CONSTRAINT [PK_dmvehicle] PRIMARY KEY CLUSTERED 
(
	[vc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmvend]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmvend](
	[ve_name] [nvarchar](60) NOT NULL,
	[ve_id] [int] IDENTITY(1,1) NOT NULL,
	[ve_street] [nvarchar](60) NOT NULL,
	[ve_street2] [nvarchar](60) NOT NULL,
	[ve_city] [nvarchar](40) NOT NULL,
	[ve_state] [nvarchar](40) NOT NULL,
	[ve_zip] [nvarchar](40) NOT NULL,
	[ve_contact] [nvarchar](30) NOT NULL,
	[ve_phone] [nvarchar](30) NOT NULL,
	[ve_fax] [nvarchar](30) NOT NULL,
	[ve_active] [bit] NOT NULL,
	[ve_teid] [int] NOT NULL,
	[ve_trid] [int] NOT NULL,
	[ve_taxid] [nvarchar](120) NOT NULL,
	[ve_socsec] [nvarchar](120) NOT NULL,
	[ve_1099] [bit] NOT NULL,
	[ve_edi] [bit] NOT NULL,
	[ve_notes] [nvarchar](max) NOT NULL,
	[ve_rname] [nvarchar](60) NOT NULL,
	[ve_rstreet] [nvarchar](60) NOT NULL,
	[ve_rstreet2] [nvarchar](60) NOT NULL,
	[ve_rcity] [nvarchar](40) NOT NULL,
	[ve_rstate] [nvarchar](40) NOT NULL,
	[ve_rzip] [nvarchar](40) NOT NULL,
	[ve_takedis] [bit] NOT NULL,
	[ve_highcrd] [numeric](12, 2) NOT NULL,
	[ve_potype] [nvarchar](10) NOT NULL,
	[ve_p1id] [int] NOT NULL,
	[ve_p2id] [int] NOT NULL,
	[ve_county] [nvarchar](40) NOT NULL,
	[ve_vendid] [nvarchar](30) NOT NULL,
	[ve_email] [nvarchar](max) NOT NULL,
	[ve_dfltinv] [nvarchar](30) NOT NULL,
	[ve_frid] [int] NOT NULL,
	[ve_dftchid] [int] NOT NULL,
	[ve_webname] [nvarchar](30) NOT NULL,
	[ve_webpass] [nvarchar](100) NOT NULL,
	[ve_vgid] [int] NOT NULL,
	[ve_backord] [bit] NOT NULL,
	[ve_rcontact] [nvarchar](30) NOT NULL,
	[ve_remail] [nvarchar](max) NOT NULL,
	[ve_rfax] [nvarchar](30) NOT NULL,
	[ve_rphone] [nvarchar](30) NOT NULL,
	[ve_phext] [nvarchar](30) NOT NULL,
	[ve_rphext] [nvarchar](30) NOT NULL,
	[ve_waid] [int] NOT NULL,
	[ve_taid1] [int] NOT NULL,
	[ve_taid2] [int] NOT NULL,
	[ve_fcid] [int] NOT NULL,
	[ve_autoinv] [bit] NOT NULL,
	[ve_popup] [nvarchar](max) NOT NULL,
	[ve_country] [nvarchar](40) NOT NULL,
	[ve_frtdisc] [bit] NOT NULL,
	[ve_ccode] [nvarchar](30) NOT NULL,
	[ve_apchid] [int] NOT NULL,
	[ve_mobileid] [int] NOT NULL,
	[ve_coid] [int] NOT NULL,
	[ve_popuprecv] [nvarchar](max) NOT NULL,
	[ve_rcountry] [nvarchar](30) NOT NULL,
	[ve_trakid] [int] NOT NULL,
	[ve_trak2id] [int] NOT NULL,
	[ve_potrakid] [int] NOT NULL,
	[ve_pricingbasedon] [nvarchar](30) NOT NULL,
	[ve_copyqc] [bit] NOT NULL,
	[ve_vendordate] [bit] NOT NULL,
	[ve_posuspchid] [int] NOT NULL,
	[ve_street3] [nvarchar](60) NOT NULL,
	[ve_rstreet3] [nvarchar](60) NOT NULL,
	[ve_routpo] [bit] NOT NULL,
	[ve_retainqc] [int] NOT NULL,
	[ve_retattrib1] [bit] NOT NULL,
	[ve_retattrib2] [bit] NOT NULL,
	[ve_retattrib3] [bit] NOT NULL,
	[ve_retdates] [bit] NOT NULL,
	[ve_minunid] [int] NOT NULL,
	[ve_minunit] [numeric](17, 7) NOT NULL,
	[ve_minext] [numeric](17, 7) NOT NULL,
	[ve_availall] [bit] NOT NULL,
	[ve_cyid] [int] NOT NULL,
	[ve_rcyid] [int] NOT NULL,
	[ve_caid] [int] NOT NULL,
	[ve_invuniquenum] [bit] NOT NULL,
	[ve_tyid] [int] NOT NULL,
	[ve_linkposearch] [bit] NOT NULL,
	[ve_pjid] [int] NOT NULL,
	[ve_c3id] [int] NOT NULL,
	[ve_requiremfgvendor] [bit] NOT NULL,
	[ve_approvalexpires] [datetime] NULL,
	[ve_1099type] [nvarchar](10) NOT NULL,
	[ve_psid] [int] NOT NULL,
	[ve_vendorhold] [bit] NOT NULL,
	[ve_invoicehold] [bit] NOT NULL,
	[ve_paymenthold] [bit] NOT NULL,
	[ve_vatid] [nvarchar](30) NOT NULL,
	[ve_brid] [int] NOT NULL,
	[ve_baid] [int] NOT NULL,
 CONSTRAINT [PK_dmvend] PRIMARY KEY CLUSTERED 
(
	[ve_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmvendfacility]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmvendfacility](
	[vf_id] [int] IDENTITY(1,1) NOT NULL,
	[vf_veid] [int] NOT NULL,
	[vf_waid] [int] NOT NULL,
	[vf_vgid] [int] NOT NULL,
	[vf_teid] [int] NOT NULL,
	[vf_frid] [int] NOT NULL,
	[vf_trid] [int] NOT NULL,
	[vf_p1id] [int] NOT NULL,
	[vf_p2id] [int] NOT NULL,
	[vf_coid] [int] NOT NULL,
	[vf_fcid] [int] NOT NULL,
	[vf_potrakid] [int] NOT NULL,
	[vf_potype] [nvarchar](30) NOT NULL,
	[vf_tyid] [int] NOT NULL,
	[vf_pricingbasedon] [nvarchar](30) NOT NULL,
	[vf_pjid] [int] NOT NULL,
	[vf_brid] [int] NOT NULL,
 CONSTRAINT [PK_dmvendfacility] PRIMARY KEY CLUSTERED 
(
	[vf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmvgrp]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmvgrp](
	[vg_id] [int] IDENTITY(1,1) NOT NULL,
	[vg_name] [nvarchar](30) NOT NULL,
	[vg_active] [bit] NOT NULL,
	[vg_street] [nvarchar](40) NOT NULL,
	[vg_street2] [nvarchar](40) NOT NULL,
	[vg_city] [nvarchar](40) NOT NULL,
	[vg_state] [nvarchar](40) NOT NULL,
	[vg_zip] [nvarchar](40) NOT NULL,
	[vg_street3] [nvarchar](40) NOT NULL,
	[vg_ccode] [nvarchar](30) NOT NULL,
	[vg_phone] [nvarchar](30) NOT NULL,
	[vg_fax] [nvarchar](30) NOT NULL,
	[vg_remitname] [nvarchar](30) NOT NULL,
	[vg_baid] [int] NOT NULL,
	[vg_country] [nvarchar](40) NOT NULL,
	[vg_email] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dmvgrp] PRIMARY KEY CLUSTERED 
(
	[vg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmware]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmware](
	[wa_id] [int] IDENTITY(1,1) NOT NULL,
	[wa_name] [nvarchar](30) NOT NULL,
	[wa_active] [bit] NOT NULL,
	[wa_default] [bit] NOT NULL,
	[wa_exid] [int] NOT NULL,
	[wa_taid1] [int] NOT NULL,
	[wa_taid2] [int] NOT NULL,
	[wa_neginv] [nvarchar](30) NOT NULL,
	[wa_reid] [int] NOT NULL,
	[wa_icxfer] [bit] NOT NULL,
	[wa_street] [nvarchar](40) NOT NULL,
	[wa_street2] [nvarchar](40) NOT NULL,
	[wa_city] [nvarchar](40) NOT NULL,
	[wa_state] [nvarchar](40) NOT NULL,
	[wa_zip] [nvarchar](40) NOT NULL,
	[wa_phone] [nvarchar](30) NOT NULL,
	[wa_fax] [nvarchar](30) NOT NULL,
	[wa_reqid] [bit] NOT NULL,
	[wa_psid] [int] NOT NULL,
	[wa_markup] [numeric](5, 2) NOT NULL,
	[wa_marktype] [nvarchar](30) NOT NULL,
	[wa_biid] [int] NOT NULL,
	[wa_ccode] [nvarchar](30) NOT NULL,
	[wa_haltposting] [bit] NOT NULL,
	[wa_lottrackdsd] [bit] NOT NULL,
	[wa_prodrel] [nvarchar](max) NOT NULL,
	[wa_shiponsave] [bit] NOT NULL,
	[wa_comport] [nvarchar](30) NOT NULL,
	[wa_baudrate] [nvarchar](30) NOT NULL,
	[wa_stopbits] [nvarchar](30) NOT NULL,
	[wa_parity] [nvarchar](30) NOT NULL,
	[wa_handshake] [nvarchar](30) NOT NULL,
	[wa_databits] [nvarchar](30) NOT NULL,
	[wa_custfirst] [bit] NOT NULL,
	[wa_retainicloc] [bit] NOT NULL,
	[wa_finlinkjob] [bit] NOT NULL,
	[wa_addthandle] [nvarchar](max) NOT NULL,
	[wa_emergency] [nvarchar](30) NOT NULL,
	[wa_ictautoreceive] [bit] NOT NULL,
	[wa_cyid] [int] NOT NULL,
	[wa_country] [nvarchar](30) NOT NULL,
	[wa_gln] [nvarchar](30) NOT NULL,
	[wa_fcid] [int] NOT NULL,
	[wa_tranholdlotcont] [bit] NOT NULL,
	[wa_overissueprompt] [bit] NOT NULL,
	[wa_overreserveprompt] [bit] NOT NULL,
	[wa_wmsincreserve] [nvarchar](30) NOT NULL,
	[wa_wmsincissue] [nvarchar](30) NOT NULL,
	[wa_underissueprompt] [bit] NOT NULL,
	[wa_restrictop] [bit] NOT NULL,
	[wa_taxjaroverride] [bit] NOT NULL,
	[wa_issuinggroupby] [bit] NOT NULL,
	[wa_ictrecqty] [nvarchar](10) NOT NULL,
	[wa_linkedsoallocate] [bit] NOT NULL,
	[wa_splitmrojobs] [bit] NOT NULL,
	[wa_fedacc] [nvarchar](100) NOT NULL,
	[wa_fedpass] [nvarchar](255) NOT NULL,
	[wa_fedauth] [nvarchar](255) NOT NULL,
	[wa_fedmeternum] [nvarchar](255) NOT NULL,
	[wa_fedshipacc] [nvarchar](255) NOT NULL,
	[wa_fedtest] [bit] NOT NULL,
	[wa_fedusefacility] [bit] NOT NULL,
	[wa_upsacc] [nvarchar](100) NOT NULL,
	[wa_upspass] [nvarchar](255) NOT NULL,
	[wa_upsauthkey] [nvarchar](255) NOT NULL,
	[wa_upsshipnum] [nvarchar](255) NOT NULL,
	[wa_upstest] [bit] NOT NULL,
	[wa_upsusefacility] [bit] NOT NULL,
	[wa_ecomminv] [bit] NOT NULL,
	[wa_ccprocid] [int] NOT NULL,
	[wa_taxtype] [nvarchar](120) NOT NULL,
	[wa_tjkey] [nvarchar](200) NOT NULL,
	[wa_taxuser] [nvarchar](60) NOT NULL,
	[wa_taxpass] [nvarchar](max) NOT NULL,
	[wa_tjname] [nvarchar](60) NOT NULL,
	[wa_taxsandboxmode] [bit] NOT NULL,
	[wa_taxexemptapis] [bit] NOT NULL,
	[wa_easypostapikey] [nvarchar](200) NOT NULL,
	[wa_taxcompcode] [nvarchar](60) NOT NULL,
	[wa_shipquan] [nvarchar](30) NOT NULL,
	[wa_defissquan] [nvarchar](30) NOT NULL,
	[wa_fedacclegacy] [nvarchar](max) NOT NULL,
	[wa_fedpasslegacy] [nvarchar](max) NOT NULL,
	[wa_fedauthlegacy] [nvarchar](max) NOT NULL,
	[wa_fedshipacclegacy] [nvarchar](max) NOT NULL,
	[wa_fedmeternumlegacy] [nvarchar](max) NOT NULL,
	[wa_retainlotcost] [bit] NOT NULL,
	[wa_xfercostexp] [nvarchar](max) NOT NULL,
	[wa_recmarkupover] [bit] NOT NULL,
 CONSTRAINT [PK_dmware] PRIMARY KEY CLUSTERED 
(
	[wa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmware2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmware2](
	[w2_id] [int] IDENTITY(1,1) NOT NULL,
	[w2_pos] [int] NOT NULL,
	[w2_override] [int] NOT NULL,
	[w2_waid] [int] NOT NULL,
 CONSTRAINT [PK_dmware2] PRIMARY KEY CLUSTERED 
(
	[w2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmware3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmware3](
	[w3_id] [int] IDENTITY(1,1) NOT NULL,
	[w3_waid] [int] NOT NULL,
	[w3_reid] [int] NOT NULL,
 CONSTRAINT [PK_dmware3] PRIMARY KEY CLUSTERED 
(
	[w3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmwmslayout]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmwmslayout](
	[wm_id] [int] IDENTITY(1,1) NOT NULL,
	[wm_usid] [int] NOT NULL,
	[wm_ugid] [int] NOT NULL,
	[wm_name] [nvarchar](30) NOT NULL,
	[wm_visible] [bit] NOT NULL,
	[wm_form] [nvarchar](30) NOT NULL,
	[wm_order] [int] NOT NULL,
	[wm_default] [bit] NOT NULL,
	[wm_defaultvalue] [nvarchar](30) NOT NULL,
	[wm_commitonscan] [bit] NOT NULL,
	[wm_bfid] [int] NOT NULL,
	[wm_savetype] [nvarchar](30) NOT NULL,
	[wm_formfor] [nvarchar](30) NOT NULL,
	[wm_formid] [int] NOT NULL,
	[wm_dupscan] [bit] NOT NULL,
	[wm_readprompts] [bit] NOT NULL,
	[wm_voiceoutput] [bit] NOT NULL,
	[wm_voiceconfirm] [bit] NOT NULL,
 CONSTRAINT [PK_dmwmslayout] PRIMARY KEY CLUSTERED 
(
	[wm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmwork]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmwork](
	[wo_id] [int] IDENTITY(1,1) NOT NULL,
	[wo_fname] [nvarchar](30) NOT NULL,
	[wo_lname] [nvarchar](30) NOT NULL,
	[wo_laid] [numeric](10, 0) NOT NULL,
	[wo_street] [nvarchar](40) NOT NULL,
	[wo_street2] [nvarchar](40) NOT NULL,
	[wo_city] [nvarchar](40) NOT NULL,
	[wo_state] [nvarchar](40) NOT NULL,
	[wo_zip] [nvarchar](40) NOT NULL,
	[wo_phone] [nvarchar](30) NOT NULL,
	[wo_active] [bit] NOT NULL,
	[wo_rate] [numeric](17, 7) NOT NULL,
	[wo_burden] [numeric](10, 2) NOT NULL,
	[wo_salary] [numeric](10, 2) NOT NULL,
	[wo_socsec] [nvarchar](65) NOT NULL,
	[wo_usid] [int] NOT NULL,
	[wo_weekot] [numeric](3, 0) NOT NULL,
	[wo_dayot] [numeric](3, 0) NOT NULL,
	[wo_hired] [datetime] NULL,
	[wo_otfactr] [numeric](5, 2) NOT NULL,
	[wo_user1] [nvarchar](30) NOT NULL,
	[wo_default] [bit] NOT NULL,
	[wo_birth] [datetime] NULL,
	[wo_nostart] [numeric](4, 0) NOT NULL,
	[wo_earlyin] [numeric](4, 0) NOT NULL,
	[wo_earlyout] [numeric](4, 0) NOT NULL,
	[wo_latein] [numeric](4, 0) NOT NULL,
	[wo_lateout] [numeric](4, 0) NOT NULL,
	[wo_mealin2] [numeric](4, 0) NOT NULL,
	[wo_mealin] [numeric](4, 0) NOT NULL,
	[wo_mealout2] [numeric](4, 0) NOT NULL,
	[wo_mealout] [numeric](4, 0) NOT NULL,
	[wo_actin] [numeric](4, 0) NOT NULL,
	[wo_actin2] [numeric](4, 0) NOT NULL,
	[wo_actin3] [numeric](4, 0) NOT NULL,
	[wo_actin4] [numeric](4, 0) NOT NULL,
	[wo_actin5] [numeric](4, 0) NOT NULL,
	[wo_actout] [numeric](4, 0) NOT NULL,
	[wo_actout2] [numeric](4, 0) NOT NULL,
	[wo_actout3] [numeric](4, 0) NOT NULL,
	[wo_actout4] [numeric](4, 0) NOT NULL,
	[wo_actout5] [numeric](4, 0) NOT NULL,
	[wo_actin6] [numeric](4, 0) NOT NULL,
	[wo_actin7] [numeric](4, 0) NOT NULL,
	[wo_actout6] [numeric](4, 0) NOT NULL,
	[wo_actout7] [numeric](4, 0) NOT NULL,
	[wo_earlyin2] [numeric](4, 0) NOT NULL,
	[wo_earlyin3] [numeric](4, 0) NOT NULL,
	[wo_earlyin4] [numeric](4, 0) NOT NULL,
	[wo_earlyin5] [numeric](4, 0) NOT NULL,
	[wo_earlyin6] [numeric](4, 0) NOT NULL,
	[wo_earlyin7] [numeric](4, 0) NOT NULL,
	[wo_earlyout2] [numeric](4, 0) NOT NULL,
	[wo_earlyout3] [numeric](4, 0) NOT NULL,
	[wo_earlyout4] [numeric](4, 0) NOT NULL,
	[wo_earlyout5] [numeric](4, 0) NOT NULL,
	[wo_earlyout6] [numeric](4, 0) NOT NULL,
	[wo_earlyout7] [numeric](4, 0) NOT NULL,
	[wo_latein2] [numeric](4, 0) NOT NULL,
	[wo_latein3] [numeric](4, 0) NOT NULL,
	[wo_latein4] [numeric](4, 0) NOT NULL,
	[wo_latein5] [numeric](4, 0) NOT NULL,
	[wo_latein6] [numeric](4, 0) NOT NULL,
	[wo_latein7] [numeric](4, 0) NOT NULL,
	[wo_lateout2] [numeric](4, 0) NOT NULL,
	[wo_lateout3] [numeric](4, 0) NOT NULL,
	[wo_lateout4] [numeric](4, 0) NOT NULL,
	[wo_lateout5] [numeric](4, 0) NOT NULL,
	[wo_lateout6] [numeric](4, 0) NOT NULL,
	[wo_lateout7] [numeric](4, 0) NOT NULL,
	[wo_mealin3] [numeric](4, 0) NOT NULL,
	[wo_mealin4] [numeric](4, 0) NOT NULL,
	[wo_mealin5] [numeric](4, 0) NOT NULL,
	[wo_mealin6] [numeric](4, 0) NOT NULL,
	[wo_mealin7] [numeric](4, 0) NOT NULL,
	[wo_mealout3] [numeric](4, 0) NOT NULL,
	[wo_mealout4] [numeric](4, 0) NOT NULL,
	[wo_mealout5] [numeric](4, 0) NOT NULL,
	[wo_mealout6] [numeric](4, 0) NOT NULL,
	[wo_mealout7] [numeric](4, 0) NOT NULL,
	[wo_nostart2] [numeric](4, 0) NOT NULL,
	[wo_nostart3] [numeric](4, 0) NOT NULL,
	[wo_nostart4] [numeric](4, 0) NOT NULL,
	[wo_nostart5] [numeric](4, 0) NOT NULL,
	[wo_nostart6] [numeric](4, 0) NOT NULL,
	[wo_nostart7] [numeric](4, 0) NOT NULL,
	[wo_ccode] [nvarchar](30) NOT NULL,
	[wo_birthday] [nvarchar](65) NOT NULL,
	[wo_ceid] [int] NOT NULL,
	[wo_crid] [int] NOT NULL,
	[wo_cyid] [int] NOT NULL,
	[wo_inactivityjob] [int] NOT NULL,
	[wo_waid] [int] NOT NULL,
	[wo_opid] [int] NOT NULL,
	[wo_seq] [int] NOT NULL,
	[wo_scheddaysweek] [int] NOT NULL,
	[wo_schedconsecdays] [int] NOT NULL,
 CONSTRAINT [PK_dmwork] PRIMARY KEY CLUSTERED 
(
	[wo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmworkcert]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmworkcert](
	[wc_id] [int] IDENTITY(1,1) NOT NULL,
	[wc_woid] [int] NOT NULL,
	[wc_opid] [int] NOT NULL,
 CONSTRAINT [PK_dmworkcert] PRIMARY KEY CLUSTERED 
(
	[wc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmzip]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmzip](
	[zi_id] [int] IDENTITY(1,1) NOT NULL,
	[zi_zipcode] [nvarchar](30) NOT NULL,
	[zi_taid1] [int] NOT NULL,
	[zi_taid2] [int] NOT NULL,
	[zi_active] [bit] NOT NULL,
 CONSTRAINT [PK_dmzip] PRIMARY KEY CLUSTERED 
(
	[zi_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmzone]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmzone](
	[zo_id] [int] IDENTITY(1,1) NOT NULL,
	[zo_name] [nvarchar](30) NOT NULL,
	[zo_active] [bit] NOT NULL,
	[zo_default] [bit] NOT NULL,
	[zo_waid] [int] NOT NULL,
	[zo_haltposting] [bit] NOT NULL,
	[zo_distinct] [bit] NOT NULL,
	[zo_prid] [int] NOT NULL,
 CONSTRAINT [PK_dmzone] PRIMARY KEY CLUSTERED 
(
	[zo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmzoneloc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmzoneloc](
	[zl_id] [int] IDENTITY(1,1) NOT NULL,
	[zl_zoid] [int] NOT NULL,
	[zl_loid] [int] NOT NULL,
 CONSTRAINT [PK_dmzoneloc] PRIMARY KEY CLUSTERED 
(
	[zl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtap]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtap](
	[ap_id] [int] IDENTITY(1,1) NOT NULL,
	[ap_purnum] [numeric](15, 0) NOT NULL,
	[ap_chid] [int] NOT NULL,
	[ap_debits] [numeric](12, 2) NOT NULL,
	[ap_credits] [numeric](12, 2) NOT NULL,
 CONSTRAINT [PK_dtap] PRIMARY KEY CLUSTERED 
(
	[ap_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtautofinish]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtautofinish](
	[af_attrib1] [nvarchar](60) NOT NULL,
	[af_attrib2] [nvarchar](60) NOT NULL,
	[af_attrib3] [nvarchar](60) NOT NULL,
	[af_cancel] [bit] NOT NULL,
	[af_container] [nvarchar](30) NOT NULL,
	[af_density] [numeric](17, 7) NOT NULL,
	[af_error] [nvarchar](max) NOT NULL,
	[af_expires] [datetime] NULL,
	[af_id] [int] IDENTITY(1,1) NOT NULL,
	[af_iscatch] [bit] NOT NULL,
	[af_iscontainer] [bit] NOT NULL,
	[af_isserial] [bit] NOT NULL,
	[af_quantity] [numeric](17, 7) NOT NULL,
	[af_recdate] [datetime] NULL,
	[af_retry] [bit] NOT NULL,
	[af_apname] [nvarchar](30) NOT NULL,
	[af_arname] [nvarchar](30) NOT NULL,
	[af_serial] [nvarchar](30) NOT NULL,
	[af_source] [nvarchar](15) NOT NULL,
	[af_status] [int] NOT NULL,
	[af_weight] [numeric](17, 7) NOT NULL,
	[af_validate] [bit] NOT NULL,
	[af_finweight] [numeric](10, 7) NOT NULL,
 CONSTRAINT [PK_dtautofinish] PRIMARY KEY CLUSTERED 
(
	[af_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtautopallet]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtautopallet](
	[ap_id] [int] IDENTITY(1,1) NOT NULL,
	[ap_name] [nvarchar](30) NOT NULL,
	[ap_source] [nvarchar](15) NOT NULL,
	[ap_arname] [nvarchar](30) NOT NULL,
	[ap_palnum] [int] NOT NULL,
	[ap_recdate] [datetime] NULL,
	[ap_quantity] [numeric](17, 7) NOT NULL,
	[ap_weight] [numeric](17, 7) NOT NULL,
	[ap_first] [nvarchar](30) NOT NULL,
	[ap_last] [nvarchar](30) NOT NULL,
	[ap_masterlot] [int] NOT NULL,
	[ap_printlabel] [bit] NOT NULL,
	[ap_status] [int] NOT NULL,
	[ap_error] [nvarchar](max) NOT NULL,
	[ap_cancel] [bit] NOT NULL,
	[ap_retry] [bit] NOT NULL,
	[ap_validate] [bit] NOT NULL,
	[ap_mlid] [int] NOT NULL,
 CONSTRAINT [PK_dtautopallet] PRIMARY KEY CLUSTERED 
(
	[ap_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtautorun]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtautorun](
	[ar_closejob] [bit] NOT NULL,
	[ar_codenum] [nvarchar](30) NOT NULL,
	[ar_end] [datetime] NULL,
	[ar_id] [int] IDENTITY(1,1) NOT NULL,
	[ar_jobnum] [numeric](15, 0) NOT NULL,
	[ar_linenum] [numeric](10, 0) NOT NULL,
	[ar_loid] [int] NOT NULL,
	[ar_loname] [nvarchar](30) NOT NULL,
	[ar_lotdate] [datetime] NULL,
	[ar_ltname] [nvarchar](30) NOT NULL,
	[ar_name] [nvarchar](30) NOT NULL,
	[ar_printer] [nvarchar](30) NOT NULL,
	[ar_quantity] [numeric](17, 7) NOT NULL,
	[ar_rellab] [bit] NOT NULL,
	[ar_relmat] [bit] NOT NULL,
	[ar_seq] [int] NOT NULL,
	[ar_source] [nvarchar](15) NOT NULL,
	[ar_start] [datetime] NULL,
	[ar_userlot] [nvarchar](60) NOT NULL,
	[ar_waid] [int] NOT NULL,
 CONSTRAINT [PK_dtautorun] PRIMARY KEY CLUSTERED 
(
	[ar_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtbom2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtbom2](
	[b2_orid] [int] NOT NULL,
	[b2_prid] [int] NOT NULL,
	[b2_quant] [numeric](20, 10) NOT NULL,
	[b2_ljid] [int] NOT NULL,
	[b2_id] [int] IDENTITY(1,1) NOT NULL,
	[b2_unid] [int] NOT NULL,
	[b2_boid] [int] NOT NULL,
	[b2_source] [nvarchar](30) NOT NULL,
	[b2_estcost] [numeric](17, 7) NOT NULL,
	[b2_seq] [int] NOT NULL,
	[b2_scrap] [numeric](17, 7) NOT NULL,
	[b2_overissue] [numeric](10, 4) NOT NULL,
	[b2_nonprop] [bit] NOT NULL,
	[b2_byproduct] [bit] NOT NULL,
	[b2_subid] [int] NOT NULL,
	[b2_active] [bit] NOT NULL,
	[b2_group] [int] NOT NULL,
	[b2_balance] [numeric](17, 7) NOT NULL,
	[b2_factor] [numeric](17, 7) NOT NULL,
	[b2_reqseq] [bit] NOT NULL,
	[b2_groupby] [nvarchar](max) NOT NULL,
	[b2_uselot] [bit] NOT NULL,
	[b2_suball] [bit] NOT NULL,
	[b2_notes] [nvarchar](max) NOT NULL,
	[b2_issueunid] [int] NOT NULL,
 CONSTRAINT [PK_dtbom2] PRIMARY KEY CLUSTERED 
(
	[b2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcalcs]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcalcs](
	[cs_value] [nvarchar](160) NOT NULL,
	[cs_id] [int] IDENTITY(1,1) NOT NULL,
	[cs_caid] [int] NOT NULL,
	[cs_numval] [numeric](17, 7) NOT NULL,
	[cs_dateval] [datetime] NULL,
	[cs_table] [nvarchar](30) NOT NULL,
	[cs_recid] [int] NOT NULL,
	[cs_memo] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dtcalcs] PRIMARY KEY CLUSTERED 
(
	[cs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcash]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcash](
	[ca_date] [datetime] NULL,
	[ca_arap] [nvarchar](2) NOT NULL,
	[ca_postref] [nvarchar](30) NOT NULL,
	[ca_c3id] [int] NOT NULL,
	[ca_check] [nvarchar](60) NOT NULL,
	[ca_cashamt] [numeric](12, 2) NOT NULL,
	[ca_totamt] [numeric](12, 2) NOT NULL,
	[ca_compnum] [int] NOT NULL,
	[ca_chid] [int] NOT NULL,
	[ca_vgid] [int] NOT NULL,
	[ca_id] [int] IDENTITY(1,1) NOT NULL,
	[ca_fcid] [int] NOT NULL,
	[ca_fcrate] [numeric](17, 7) NOT NULL,
	[ca_cashsale] [bit] NOT NULL,
	[ca_validnum] [nvarchar](30) NOT NULL,
	[ca_usid] [int] NOT NULL,
	[ca_recdate] [datetime] NULL,
	[ca_fccashamt] [numeric](12, 2) NOT NULL,
	[ca_fctotamt] [numeric](12, 2) NOT NULL,
	[ca_depositnum] [nvarchar](30) NOT NULL,
	[ca_name] [nvarchar](60) NOT NULL,
	[ca_street] [nvarchar](40) NOT NULL,
	[ca_street2] [nvarchar](40) NOT NULL,
	[ca_city] [nvarchar](40) NOT NULL,
	[ca_state] [nvarchar](40) NOT NULL,
	[ca_zip] [nvarchar](40) NOT NULL,
	[ca_emv] [bit] NOT NULL,
	[ca_processdata] [nvarchar](200) NOT NULL,
	[ca_acqrefdata] [nvarchar](200) NOT NULL,
	[ca_refno] [nvarchar](200) NOT NULL,
	[ca_acctno] [nvarchar](100) NOT NULL,
	[ca_applabel] [nvarchar](30) NOT NULL,
	[ca_authcode] [nvarchar](30) NOT NULL,
	[ca_captstat] [nvarchar](30) NOT NULL,
	[ca_cardtype] [nvarchar](30) NOT NULL,
	[ca_emvdate] [nvarchar](12) NOT NULL,
	[ca_entrymethod] [nvarchar](30) NOT NULL,
	[ca_invoiceno] [nvarchar](30) NOT NULL,
	[ca_merchid] [nvarchar](30) NOT NULL,
	[ca_opid] [nvarchar](30) NOT NULL,
	[ca_terminalid] [nvarchar](30) NOT NULL,
	[ca_emvtime] [nvarchar](10) NOT NULL,
	[ca_trancode] [nvarchar](30) NOT NULL,
	[ca_emvpurchase] [nvarchar](30) NOT NULL,
	[ca_emvauthorized] [nvarchar](30) NOT NULL,
	[ca_aid] [nvarchar](30) NOT NULL,
	[ca_tvr] [nvarchar](30) NOT NULL,
	[ca_iad] [nvarchar](30) NOT NULL,
	[ca_tsi] [nvarchar](30) NOT NULL,
	[ca_arc] [nvarchar](30) NOT NULL,
	[ca_cvm] [nvarchar](30) NOT NULL,
	[ca_notes] [nvarchar](max) NOT NULL,
	[ca_gcid] [int] NOT NULL,
	[ca_last4] [nvarchar](4) NOT NULL,
	[ca_street3] [nvarchar](60) NOT NULL,
	[ca_country] [nvarchar](40) NOT NULL,
	[ca_email] [nvarchar](max) NOT NULL,
	[ca_phone] [nvarchar](30) NOT NULL,
	[ca_fax] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dtcash] PRIMARY KEY CLUSTERED 
(
	[ca_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcash2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcash2](
	[c2_postref] [nvarchar](60) NOT NULL,
	[c2_ordnum] [numeric](15, 0) NOT NULL,
	[c2_chid] [int] NOT NULL,
	[c2_debits] [numeric](12, 2) NOT NULL,
	[c2_credits] [numeric](12, 2) NOT NULL,
	[c2_id] [int] IDENTITY(1,1) NOT NULL,
	[c2_shid] [int] NOT NULL,
	[c2_type] [nvarchar](60) NOT NULL,
	[c2_fcdebits] [numeric](12, 2) NOT NULL,
	[c2_fccredits] [numeric](12, 2) NOT NULL,
 CONSTRAINT [PK_dtcash2] PRIMARY KEY CLUSTERED 
(
	[c2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcheck]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcheck](
	[ck_id] [int] IDENTITY(1,1) NOT NULL,
	[ck_chid] [int] NOT NULL,
	[ck_number] [numeric](20, 0) NOT NULL,
 CONSTRAINT [PK_dtcheck] PRIMARY KEY CLUSTERED 
(
	[ck_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcinv]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcinv](
	[ci_id] [int] IDENTITY(1,1) NOT NULL,
	[ci_shid] [int] NOT NULL,
	[ci_prid] [int] NOT NULL,
	[ci_quant] [numeric](17, 7) NOT NULL,
	[ci_ordnum] [numeric](15, 0) NOT NULL,
	[ci_zeroed] [datetime] NULL,
	[ci_balance] [numeric](17, 7) NOT NULL,
	[ci_serial] [nvarchar](30) NOT NULL,
	[ci_biid] [int] NOT NULL,
	[ci_siid] [int] NOT NULL,
	[ci_crid] [int] NOT NULL,
 CONSTRAINT [PK_dtcinv] PRIMARY KEY CLUSTERED 
(
	[ci_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcontrecents]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcontrecents](
	[re_id] [int] IDENTITY(1,1) NOT NULL,
	[re_usid] [int] NOT NULL,
	[re_coid] [int] NOT NULL,
	[re_lastvisit] [datetime] NULL,
	[re_timevisit] [nvarchar](8) NOT NULL,
 CONSTRAINT [PK_dtcontrecents] PRIMARY KEY CLUSTERED 
(
	[re_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcount]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcount](
	[co_id] [int] IDENTITY(1,1) NOT NULL,
	[co_name] [nvarchar](30) NOT NULL,
	[co_phid] [int] NOT NULL,
	[co_team] [nvarchar](30) NOT NULL,
	[co_active] [bit] NOT NULL,
	[co_usid] [int] NOT NULL,
	[co_edited] [datetime] NULL,
	[co_source] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dtcount] PRIMARY KEY CLUSTERED 
(
	[co_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcount2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcount2](
	[c2_id] [int] IDENTITY(1,1) NOT NULL,
	[c2_coid] [int] NOT NULL,
	[c2_prid] [int] NOT NULL,
	[c2_quant] [numeric](17, 7) NOT NULL,
	[c2_seq] [int] NOT NULL,
	[c2_loc] [nvarchar](30) NOT NULL,
	[c2_userlot] [nvarchar](60) NOT NULL,
	[c2_syslot] [int] NOT NULL,
	[c2_loid] [int] NOT NULL,
	[c2_unid] [int] NOT NULL,
	[c2_serial] [nvarchar](30) NOT NULL,
	[c2_catchwgt] [numeric](17, 7) NOT NULL,
	[c2_container] [numeric](17, 7) NOT NULL,
	[c2_contnum] [nvarchar](30) NOT NULL,
	[c2_contunid] [int] NOT NULL,
	[c2_lotdate] [datetime] NULL,
	[c2_notes] [nvarchar](max) NOT NULL,
	[c2_attrib1] [nvarchar](60) NOT NULL,
	[c2_attrib2] [nvarchar](60) NOT NULL,
	[c2_attrib3] [nvarchar](60) NOT NULL,
	[c2_tarewgt] [numeric](10, 7) NOT NULL,
	[c2_expires] [datetime] NULL,
 CONSTRAINT [PK_dtcount2] PRIMARY KEY CLUSTERED 
(
	[c2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcrmproj]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcrmproj](
	[cp_id] [int] IDENTITY(1,1) NOT NULL,
	[cp_name] [nvarchar](100) NOT NULL,
	[cp_ccid] [int] NOT NULL,
	[cp_notes] [nvarchar](max) NOT NULL,
	[cp_coid] [int] NOT NULL,
	[cp_status] [nvarchar](30) NOT NULL,
	[cp_cpid] [int] NOT NULL,
	[cp_trak2id] [int] NOT NULL,
	[cp_trakid] [int] NOT NULL,
 CONSTRAINT [PK_dtcrmproj] PRIMARY KEY CLUSTERED 
(
	[cp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcrmprojmilestone]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcrmprojmilestone](
	[mn_id] [int] IDENTITY(1,1) NOT NULL,
	[mn_active] [bit] NOT NULL,
	[mn_default] [bit] NOT NULL,
	[mn_targetdate] [datetime] NULL,
	[mn_name] [nvarchar](30) NOT NULL,
	[mn_cpid] [int] NOT NULL,
	[mn_notes] [nvarchar](max) NOT NULL,
	[mn_seq] [int] NOT NULL,
 CONSTRAINT [PK_dtcrmprojmilestone] PRIMARY KEY CLUSTERED 
(
	[mn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcrmprojnote]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcrmprojnote](
	[pn_cpid] [int] NOT NULL,
	[pn_date] [datetime] NULL,
	[pn_id] [int] IDENTITY(1,1) NOT NULL,
	[pn_note] [nvarchar](max) NOT NULL,
	[pn_peid] [int] NOT NULL,
	[pn_time] [numeric](4, 0) NOT NULL,
	[pn_usid] [int] NOT NULL,
	[pn_contactpersonid] [int] NOT NULL,
 CONSTRAINT [PK_dtcrmprojnote] PRIMARY KEY CLUSTERED 
(
	[pn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcrmprojtask]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcrmprojtask](
	[pt_active] [bit] NOT NULL,
	[pt_cpid] [int] NOT NULL,
	[pt_end] [datetime] NULL,
	[pt_id] [int] IDENTITY(1,1) NOT NULL,
	[pt_name] [nvarchar](120) NOT NULL,
	[pt_seq] [int] NOT NULL,
	[pt_start] [datetime] NULL,
	[pt_tcid] [int] NOT NULL,
	[pt_tsid] [int] NOT NULL,
	[pt_mnid] [int] NOT NULL,
 CONSTRAINT [PK_dtcrmprojtask] PRIMARY KEY CLUSTERED 
(
	[pt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtcrmprojtick]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtcrmprojtick](
	[ct_id] [int] IDENTITY(1,1) NOT NULL,
	[ct_cpid] [int] NOT NULL,
	[ct_tiid] [int] NOT NULL,
	[ct_seq] [int] NOT NULL,
	[ct_mnid] [int] NOT NULL,
 CONSTRAINT [PK_dtcrmprojtick] PRIMARY KEY CLUSTERED 
(
	[ct_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtd2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtd2](
	[d2_id] [int] IDENTITY(1,1) NOT NULL,
	[d2_d1id] [int] NOT NULL,
	[d2_recid] [numeric](12, 0) NOT NULL,
	[d2_group] [numeric](10, 0) NOT NULL,
	[d2_value] [nvarchar](60) NOT NULL,
	[d2_memo] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dtd2] PRIMARY KEY CLUSTERED 
(
	[d2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtemailcode]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtemailcode](
	[ec_id] [int] IDENTITY(1,1) NOT NULL,
	[ec_usid] [int] NOT NULL,
	[ec_code] [nvarchar](6) NOT NULL,
	[ec_start] [datetime] NULL,
	[ec_end] [datetime] NULL,
	[ec_success] [bit] NOT NULL,
 CONSTRAINT [PK_dtemailcode] PRIMARY KEY CLUSTERED 
(
	[ec_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dteng]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dteng](
	[in_orid] [int] NOT NULL,
	[in_ordnum] [numeric](15, 0) NOT NULL,
	[in_ts] [nvarchar](10) NOT NULL,
	[in_bs] [nvarchar](10) NOT NULL,
	[in_type] [nvarchar](10) NOT NULL,
	[in_span] [nvarchar](10) NOT NULL,
	[in_leftoh] [nvarchar](10) NOT NULL,
	[in_righoh] [nvarchar](10) NOT NULL,
	[in_toplum] [nvarchar](10) NOT NULL,
	[in_botlum] [nvarchar](10) NOT NULL,
	[in_ply] [numeric](10, 0) NOT NULL,
	[in_spacing] [nvarchar](10) NOT NULL,
	[in_file] [nvarchar](254) NOT NULL,
	[in_height] [nvarchar](10) NOT NULL,
	[in_joints] [numeric](10, 0) NOT NULL,
	[in_sticks] [numeric](10, 0) NOT NULL,
	[in_linfeet] [numeric](10, 0) NOT NULL,
	[in_brdfeet] [numeric](10, 0) NOT NULL,
	[in_mats] [numeric](17, 7) NOT NULL,
	[in_labor] [numeric](17, 7) NOT NULL,
	[in_burden] [numeric](17, 7) NOT NULL,
	[in_picture1] [nvarchar](max) NOT NULL,
	[in_picture2] [nvarchar](max) NOT NULL,
	[in_lheel] [nvarchar](10) NOT NULL,
	[in_rheel] [nvarchar](10) NOT NULL,
	[in_toid] [int] NOT NULL,
	[in_id] [int] IDENTITY(1,1) NOT NULL,
	[in_lispric] [numeric](17, 7) NOT NULL,
	[in_lumcost] [numeric](17, 7) NOT NULL,
	[in_platecost] [numeric](17, 7) NOT NULL,
	[in_notes] [nvarchar](max) NOT NULL,
	[in_uniquesticks] [int] NOT NULL,
 CONSTRAINT [PK_dteng] PRIMARY KEY CLUSTERED 
(
	[in_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtfifo]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtfifo](
	[fi_id] [int] IDENTITY(1,1) NOT NULL,
	[fi_date] [datetime] NULL,
	[fi_lotdate] [datetime] NULL,
	[fi_lotnum] [numeric](10, 0) NOT NULL,
	[fi_userlot] [nvarchar](60) NOT NULL,
	[fi_prid] [int] NOT NULL,
	[fi_zeroed] [datetime] NULL,
	[fi_quant] [numeric](17, 7) NOT NULL,
	[fi_balance] [numeric](17, 7) NOT NULL,
	[fi_cost] [numeric](17, 7) NOT NULL,
	[fi_postref] [nvarchar](30) NOT NULL,
	[fi_action] [nvarchar](60) NOT NULL,
	[fi_loc] [nvarchar](30) NOT NULL,
	[fi_allonum] [numeric](15, 0) NOT NULL,
	[fi_type] [nvarchar](10) NOT NULL,
	[fi_group] [numeric](10, 0) NOT NULL,
	[fi_waid] [int] NOT NULL,
	[fi_chid] [int] NOT NULL,
	[fi_orid] [int] NOT NULL,
	[fi_exten] [numeric](12, 2) NOT NULL,
	[fi_catchwgt] [numeric](17, 7) NOT NULL,
	[fi_serial] [nvarchar](30) NOT NULL,
	[fi_expires] [datetime] NULL,
	[fi_invcost] [numeric](17, 7) NOT NULL,
	[fi_attrib1] [nvarchar](60) NOT NULL,
	[fi_attrib2] [nvarchar](60) NOT NULL,
	[fi_attrib3] [nvarchar](60) NOT NULL,
	[fi_descrip] [nvarchar](40) NOT NULL,
	[fi_q4group] [int] NOT NULL,
	[fi_qc] [nvarchar](30) NOT NULL,
	[fi_masterlot] [int] NOT NULL,
	[fi_tally] [numeric](17, 7) NOT NULL,
	[fi_loid] [int] NOT NULL,
	[fi_notes] [nvarchar](max) NOT NULL,
	[fi_container] [numeric](17, 7) NOT NULL,
	[fi_contnum] [nvarchar](30) NOT NULL,
	[fi_atrisk] [bit] NOT NULL,
	[fi_density] [numeric](17, 7) NOT NULL,
	[fi_recdate] [datetime] NULL,
	[fi_rtid] [int] NOT NULL,
	[fi_contunid] [int] NOT NULL,
	[fi_origpostref] [nvarchar](30) NOT NULL,
	[fi_vcid] [int] NOT NULL,
	[fi_crid] [int] NOT NULL,
	[fi_tarewgt] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dtfifo] PRIMARY KEY CLUSTERED 
(
	[fi_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtfifo2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtfifo2](
	[f2_id] [int] IDENTITY(1,1) NOT NULL,
	[f2_date] [datetime] NULL,
	[f2_prid] [int] NOT NULL,
	[f2_fiid] [int] NOT NULL,
	[f2_postref] [nvarchar](30) NOT NULL,
	[f2_oldquan] [numeric](17, 7) NOT NULL,
	[f2_newquan] [numeric](17, 7) NOT NULL,
	[f2_cost] [numeric](17, 7) NOT NULL,
	[f2_action] [nvarchar](60) NOT NULL,
	[f2_group] [numeric](10, 0) NOT NULL,
	[f2_expense] [bit] NOT NULL,
	[f2_exten] [numeric](12, 2) NOT NULL,
	[f2_invcost] [numeric](17, 7) NOT NULL,
	[f2_notes] [nvarchar](max) NOT NULL,
	[f2_recdate] [datetime] NULL,
 CONSTRAINT [PK_dtfifo2] PRIMARY KEY CLUSTERED 
(
	[f2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtfifocust]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtfifocust](
	[fc_id] [int] IDENTITY(1,1) NOT NULL,
	[fc_table] [nvarchar](60) NOT NULL,
	[fc_recid] [int] NOT NULL,
	[fc_lotnum] [nvarchar](10) NOT NULL,
	[fc_userlot] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_dtfifocust] PRIMARY KEY CLUSTERED 
(
	[fc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtfifoesig]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtfifoesig](
	[fe_id] [int] IDENTITY(1,1) NOT NULL,
	[fe_fiid] [int] NOT NULL,
	[fe_signature] [nvarchar](max) NOT NULL,
	[fe_date] [datetime] NULL,
	[fe_time] [numeric](4, 0) NOT NULL,
	[fe_usid] [int] NOT NULL,
	[fe_type] [nvarchar](30) NOT NULL,
	[fe_allonum] [numeric](15, 0) NOT NULL,
 CONSTRAINT [PK_dtfifoesig] PRIMARY KEY CLUSTERED 
(
	[fe_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtfreightship]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtfreightship](
	[fs_active] [bit] NOT NULL,
	[fs_dnid] [int] NOT NULL,
	[fs_id] [int] IDENTITY(1,1) NOT NULL,
	[fs_label] [nvarchar](30) NOT NULL,
	[fs_loadandcount] [int] NOT NULL,
	[fs_ordnum] [numeric](17, 0) NOT NULL,
	[fs_piid] [int] NOT NULL,
	[fs_role] [nvarchar](30) NOT NULL,
	[fs_bookingnum] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dtfreightship] PRIMARY KEY CLUSTERED 
(
	[fs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtfreightshipline]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtfreightshipline](
	[fl_active] [bit] NOT NULL,
	[fl_class] [nvarchar](30) NOT NULL,
	[fl_description] [nvarchar](max) NOT NULL,
	[fl_fsid] [int] NOT NULL,
	[fl_handlingunits] [int] NOT NULL,
	[fl_height] [numeric](7, 0) NOT NULL,
	[fl_id] [int] IDENTITY(1,1) NOT NULL,
	[fl_length] [numeric](7, 0) NOT NULL,
	[fl_packtype] [nvarchar](30) NOT NULL,
	[fl_pieces] [int] NOT NULL,
	[fl_seq] [int] NOT NULL,
	[fl_width] [numeric](7, 0) NOT NULL,
	[fl_units] [nvarchar](5) NOT NULL,
	[fl_weight] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dtfreightshipline] PRIMARY KEY CLUSTERED 
(
	[fl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtgl]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtgl](
	[gl_date] [datetime] NULL,
	[gl_group] [int] NOT NULL,
	[gl_postref] [nvarchar](30) NOT NULL,
	[gl_debits] [numeric](12, 2) NOT NULL,
	[gl_credits] [numeric](12, 2) NOT NULL,
	[gl_action] [nvarchar](60) NOT NULL,
	[gl_bankrec] [bit] NOT NULL,
	[gl_descrip] [nvarchar](120) NOT NULL,
	[gl_chid] [int] NOT NULL,
	[gl_id] [int] IDENTITY(1,1) NOT NULL,
	[gl_usid] [int] NOT NULL,
	[gl_cleared] [datetime] NULL,
	[gl_fcid] [int] NOT NULL,
	[gl_fcrate] [numeric](17, 7) NOT NULL,
	[gl_recdate] [datetime] NULL,
	[gl_fcdebits] [numeric](12, 2) NOT NULL,
	[gl_fccredits] [numeric](12, 2) NOT NULL,
	[gl_apprusid] [int] NOT NULL,
	[gl_apprdate] [datetime] NULL,
 CONSTRAINT [PK_dtgl] PRIMARY KEY CLUSTERED 
(
	[gl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtjob]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtjob](
	[jo_jobnum] [numeric](15, 0) NOT NULL,
	[jo_date] [datetime] NULL,
	[jo_started] [datetime] NULL,
	[jo_closed] [datetime] NULL,
	[jo_prtwork] [datetime] NULL,
	[jo_notes] [nvarchar](max) NOT NULL,
	[jo_type] [nvarchar](1) NOT NULL,
	[jo_jcid] [int] NOT NULL,
	[jo_wipjob] [bit] NOT NULL,
	[jo_waid] [int] NOT NULL,
	[jo_due] [datetime] NULL,
	[jo_sched] [bit] NOT NULL,
	[jo_prior] [numeric](10, 0) NOT NULL,
	[jo_prod] [datetime] NULL,
	[jo_descrip] [nvarchar](200) NOT NULL,
	[jo_synch] [bit] NOT NULL,
	[jo_remarks] [nvarchar](max) NOT NULL,
	[jo_history] [nvarchar](max) NOT NULL,
	[jo_shid] [int] NOT NULL,
	[jo_id] [int] IDENTITY(1,1) NOT NULL,
	[jo_userdate4] [datetime] NULL,
	[jo_userdate5] [datetime] NULL,
	[jo_trakid] [int] NOT NULL,
	[jo_trak2id] [int] NOT NULL,
	[jo_schedby] [nvarchar](30) NOT NULL,
	[jo_userdate1] [datetime] NULL,
	[jo_planstart] [datetime] NULL,
	[jo_planfinish] [datetime] NULL,
	[jo_userdate2] [datetime] NULL,
	[jo_userdate3] [datetime] NULL,
	[jo_jobtype] [nvarchar](1) NOT NULL,
	[jo_reworklabor] [bit] NOT NULL,
	[jo_prtpickdate] [datetime] NULL,
	[jo_prtpicktime] [nvarchar](30) NOT NULL,
	[jo_seqjob] [numeric](15, 0) NOT NULL,
	[jo_pjid] [int] NOT NULL,
 CONSTRAINT [PK_dtjob] PRIMARY KEY CLUSTERED 
(
	[jo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtjob2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtjob2](
	[j2_jobnum] [numeric](15, 0) NOT NULL,
	[j2_seq] [numeric](10, 0) NOT NULL,
	[j2_ceid] [int] NOT NULL,
	[j2_opid] [int] NOT NULL,
	[j2_start] [datetime] NULL,
	[j2_due] [datetime] NULL,
	[j2_pieces] [numeric](17, 7) NOT NULL,
	[j2_hours] [numeric](10, 3) NOT NULL,
	[j2_notes] [nvarchar](max) NOT NULL,
	[j2_batch] [bit] NOT NULL,
	[j2_done] [bit] NOT NULL,
	[j2_id] [int] IDENTITY(1,1) NOT NULL,
	[j2_ljid] [int] NOT NULL,
	[j2_priority] [int] NOT NULL,
	[j2_duetime] [numeric](4, 0) NOT NULL,
	[j2_size] [numeric](17, 7) NOT NULL,
	[j2_multiday] [bit] NOT NULL,
	[j2_workers] [numeric](12, 2) NOT NULL,
	[j2_leadtime] [numeric](12, 2) NOT NULL,
	[j2_planhours] [numeric](10, 3) NOT NULL,
	[j2_crid] [int] NOT NULL,
	[j2_woid] [int] NOT NULL,
	[j2_finish] [bit] NOT NULL,
	[j2_leadtype] [nvarchar](30) NOT NULL,
	[j2_r2id] [int] NOT NULL,
	[j2_includeoptimize] [bit] NOT NULL,
	[j2_unavailnextseq] [bit] NOT NULL,
	[j2_unavailseqid] [int] NOT NULL,
 CONSTRAINT [PK_dtjob2] PRIMARY KEY CLUSTERED 
(
	[j2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtjob3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtjob3](
	[j3_id] [int] IDENTITY(1,1) NOT NULL,
	[j3_jobnum] [numeric](15, 0) NOT NULL,
	[j3_datein] [datetime] NULL,
	[j3_dateout] [datetime] NULL,
	[j3_timein] [numeric](4, 0) NOT NULL,
	[j3_timeout] [numeric](4, 0) NOT NULL,
	[j3_woid] [int] NOT NULL,
	[j3_ceid] [int] NOT NULL,
	[j3_cenrate] [numeric](12, 2) NOT NULL,
	[j3_seq] [numeric](10, 0) NOT NULL,
	[j3_opid] [int] NOT NULL,
	[j3_quant] [numeric](17, 7) NOT NULL,
	[j3_rate] [numeric](12, 2) NOT NULL,
	[j3_ratefac] [numeric](5, 2) NOT NULL,
	[j3_otfactr] [numeric](5, 2) NOT NULL,
	[j3_hours] [numeric](13, 3) NOT NULL,
	[j3_relieve] [datetime] NULL,
	[j3_modd1] [datetime] NULL,
	[j3_modd2] [datetime] NULL,
	[j3_modt1] [numeric](4, 0) NOT NULL,
	[j3_modt2] [numeric](4, 0) NOT NULL,
	[j3_modhour] [numeric](13, 3) NOT NULL,
	[j3_othours] [numeric](13, 3) NOT NULL,
	[j3_modot] [numeric](13, 3) NOT NULL,
	[j3_group] [numeric](10, 0) NOT NULL,
	[j3_posted] [datetime] NULL,
	[j3_postref] [nvarchar](30) NOT NULL,
	[j3_chid] [int] NOT NULL,
	[j3_otchid] [int] NOT NULL,
	[j3_crid] [int] NOT NULL,
	[j3_source] [nvarchar](30) NOT NULL,
	[j3_burchid] [int] NOT NULL,
	[j3_laid] [int] NOT NULL,
	[j3_sfid] [int] NOT NULL,
	[j3_ptid] [int] NOT NULL,
	[j3_calctime] [numeric](13, 3) NOT NULL,
	[j3_splithours] [numeric](13, 3) NOT NULL,
	[j3_burdenrate] [numeric](12, 2) NOT NULL,
 CONSTRAINT [PK_dtjob3] PRIMARY KEY CLUSTERED 
(
	[j3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtjob4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtjob4](
	[j4_jobnum] [numeric](15, 0) NOT NULL,
	[j4_ljid] [int] NOT NULL,
	[j4_date] [datetime] NULL,
	[j4_quant] [numeric](17, 7) NOT NULL,
	[j4_crid] [int] NOT NULL,
	[j4_prid] [int] NOT NULL,
	[j4_id] [int] IDENTITY(1,1) NOT NULL,
	[j4_stantot] [numeric](17, 7) NOT NULL,
	[j4_unitcos] [numeric](17, 7) NOT NULL,
	[j4_fiid] [int] NOT NULL,
	[j4_nextstab] [datetime] NULL,
	[j4_stid] [int] NOT NULL,
	[j4_catchwgt] [numeric](17, 7) NOT NULL,
	[j4_matcost] [numeric](17, 7) NOT NULL,
	[j4_labcost] [numeric](17, 7) NOT NULL,
	[j4_purcost] [numeric](17, 7) NOT NULL,
	[j4_centcost] [numeric](17, 7) NOT NULL,
	[j4_burcost] [numeric](17, 7) NOT NULL,
	[j4_meter] [numeric](17, 7) NOT NULL,
	[j4_finlab] [numeric](17, 7) NOT NULL,
	[j4_finbur] [numeric](17, 7) NOT NULL,
	[j4_recdate] [datetime] NULL,
	[j4_sfid] [int] NOT NULL,
	[j4_fixmat] [numeric](17, 7) NOT NULL,
	[j4_fixlab] [numeric](17, 7) NOT NULL,
	[j4_fixbur] [numeric](17, 7) NOT NULL,
	[j4_fixmbur] [numeric](17, 7) NOT NULL,
	[j4_fixfrt] [numeric](17, 7) NOT NULL,
	[j4_f2group] [numeric](17, 0) NOT NULL,
	[j4_glfingrp] [numeric](17, 0) NOT NULL,
	[j4_glrelgrp] [numeric](17, 0) NOT NULL,
 CONSTRAINT [PK_dtjob4] PRIMARY KEY CLUSTERED 
(
	[j4_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtjobsched]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtjobsched](
	[js_id] [int] IDENTITY(1,1) NOT NULL,
	[js_j2id] [int] NOT NULL,
	[js_due] [datetime] NULL,
	[js_duetime] [numeric](4, 0) NOT NULL,
	[js_duration] [numeric](12, 2) NOT NULL,
	[js_jobnum] [numeric](15, 0) NOT NULL,
 CONSTRAINT [PK_dtjobsched] PRIMARY KEY CLUSTERED 
(
	[js_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtjour]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtjour](
	[jr_date] [datetime] NULL,
	[jr_group] [int] NOT NULL,
	[jr_postref] [nvarchar](30) NOT NULL,
	[jr_debits] [numeric](12, 2) NOT NULL,
	[jr_credits] [numeric](12, 2) NOT NULL,
	[jr_action] [nvarchar](30) NOT NULL,
	[jr_bankrec] [bit] NOT NULL,
	[jr_descrip] [nvarchar](120) NOT NULL,
	[jr_chid] [int] NOT NULL,
	[jr_usid] [int] NOT NULL,
	[jr_fcid] [int] NOT NULL,
	[jr_fcrate] [numeric](17, 7) NOT NULL,
	[jr_id] [int] IDENTITY(1,1) NOT NULL,
	[jr_recdate] [datetime] NULL,
	[jr_active] [bit] NOT NULL,
	[jr_fcdebits] [numeric](12, 2) NOT NULL,
	[jr_fccredits] [numeric](12, 2) NOT NULL,
	[jr_apprdate] [datetime] NULL,
	[jr_apprusid] [int] NOT NULL,
	[jr_type] [nvarchar](30) NOT NULL,
	[jr_occurson] [nvarchar](30) NOT NULL,
	[jr_occurences] [int] NOT NULL,
	[jr_reverses] [datetime] NULL,
	[jr_glpostref] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dtjour] PRIMARY KEY CLUSTERED 
(
	[jr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtljob]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtljob](
	[lj_id] [int] IDENTITY(1,1) NOT NULL,
	[lj_jobnum] [numeric](15, 0) NOT NULL,
	[lj_linenum] [numeric](10, 0) NOT NULL,
	[lj_prid] [int] NOT NULL,
	[lj_quant] [numeric](17, 7) NOT NULL,
	[lj_ordnum] [numeric](15, 0) NOT NULL,
	[lj_orid] [int] NOT NULL,
	[lj_descrip] [nvarchar](200) NOT NULL,
	[lj_user1] [nvarchar](30) NOT NULL,
	[lj_reid] [int] NOT NULL,
	[lj_feattree] [nvarchar](max) NOT NULL,
	[lj_joid] [int] NOT NULL,
	[lj_qcid] [int] NOT NULL,
	[lj_approved] [bit] NOT NULL,
	[lj_failed] [bit] NOT NULL,
	[lj_roid] [int] NOT NULL,
	[lj_nextstid] [int] NOT NULL,
	[lj_nextstab] [datetime] NULL,
	[lj_tally] [nvarchar](max) NOT NULL,
	[lj_planquant] [numeric](17, 7) NOT NULL,
	[lj_ceid] [int] NOT NULL,
	[lj_cmid] [int] NOT NULL,
	[lj_cpcost] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dtljob] PRIMARY KEY CLUSTERED 
(
	[lj_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtlock]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtlock](
	[lk_id] [bigint] IDENTITY(1,1) NOT NULL,
	[lk_table] [nvarchar](30) NOT NULL,
	[lk_usid] [int] NOT NULL,
	[lk_recid] [int] NOT NULL,
	[lk_action] [nvarchar](30) NOT NULL,
	[lk_critical] [bit] NOT NULL,
	[lk_date] [datetime] NULL,
	[lk_time] [nvarchar](8) NOT NULL,
	[lk_token] [numeric](10, 0) NOT NULL,
	[lk_expire] [bit] NOT NULL,
 CONSTRAINT [PK_dtlock] PRIMARY KEY CLUSTERED 
(
	[lk_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtmasterlot]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtmasterlot](
	[ml_id] [int] IDENTITY(1,1) NOT NULL,
	[ml_lot] [nvarchar](30) NOT NULL,
	[ml_totwgt] [numeric](17, 7) NOT NULL,
	[ml_status] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dtmasterlot] PRIMARY KEY CLUSTERED 
(
	[ml_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtmovesched]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtmovesched](
	[ms_id] [int] IDENTITY(1,1) NOT NULL,
	[ms_pickbytime] [numeric](4, 0) NOT NULL,
	[ms_pickbydate] [datetime] NULL,
	[ms_priority] [numeric](10, 0) NOT NULL,
	[ms_usid] [int] NOT NULL,
	[ms_loadstartdate] [datetime] NULL,
	[ms_loadenddate] [datetime] NULL,
	[ms_loadstarttime] [numeric](4, 0) NOT NULL,
	[ms_loadendtime] [numeric](4, 0) NOT NULL,
	[ms_unloadstartdate] [datetime] NULL,
	[ms_unloadenddate] [datetime] NULL,
	[ms_unloadstarttime] [numeric](4, 0) NOT NULL,
	[ms_unloadendtime] [numeric](4, 0) NOT NULL,
	[ms_quant] [numeric](17, 7) NOT NULL,
	[ms_loadedquant] [numeric](17, 7) NOT NULL,
	[ms_unloadedquant] [numeric](17, 7) NOT NULL,
	[ms_loid] [int] NOT NULL,
	[ms_destloid] [int] NOT NULL,
	[ms_mrid] [int] NOT NULL,
	[ms_waid] [int] NOT NULL,
	[ms_vcid] [int] NOT NULL,
	[ms_ordnum] [numeric](15, 0) NOT NULL,
	[ms_prid] [int] NOT NULL,
	[ms_orid] [int] NOT NULL,
 CONSTRAINT [PK_dtmovesched] PRIMARY KEY CLUSTERED 
(
	[ms_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtord]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtord](
	[or_id] [int] IDENTITY(1,1) NOT NULL,
	[or_ordnum] [numeric](15, 0) NOT NULL,
	[or_linenum] [numeric](10, 0) NOT NULL,
	[or_chid] [int] NOT NULL,
	[or_cogsid] [int] NOT NULL,
	[or_prid] [int] NOT NULL,
	[or_quant] [numeric](17, 7) NOT NULL,
	[or_qship] [numeric](17, 7) NOT NULL,
	[or_price] [numeric](17, 7) NOT NULL,
	[or_exten] [numeric](14, 2) NOT NULL,
	[or_notes] [nvarchar](max) NOT NULL,
	[or_taxable] [bit] NOT NULL,
	[or_stocked] [bit] NOT NULL,
	[or_control] [bit] NOT NULL,
	[or_wanted] [datetime] NULL,
	[or_promise] [datetime] NULL,
	[or_dueship] [datetime] NULL,
	[or_confirm] [datetime] NULL,
	[or_expires] [datetime] NULL,
	[or_jobnum] [numeric](15, 0) NOT NULL,
	[or_user1] [nvarchar](30) NOT NULL,
	[or_prunid] [int] NOT NULL,
	[or_prfact] [numeric](20, 10) NOT NULL,
	[or_unitwgt] [numeric](12, 4) NOT NULL,
	[or_taid] [int] NOT NULL,
	[or_unitcos] [numeric](17, 7) NOT NULL,
	[or_subtot] [bit] NOT NULL,
	[or_discoun] [bit] NOT NULL,
	[or_tally] [nvarchar](max) NOT NULL,
	[or_lispric] [numeric](17, 7) NOT NULL,
	[or_stantot] [numeric](17, 7) NOT NULL,
	[or_purnum] [numeric](15, 0) NOT NULL,
	[or_loadcos] [numeric](17, 7) NOT NULL,
	[or_prictyp] [nvarchar](60) NOT NULL,
	[or_phid] [int] NOT NULL,
	[or_salunid] [int] NOT NULL,
	[or_salfact] [numeric](20, 10) NOT NULL,
	[or_release] [datetime] NULL,
	[or_toid] [int] NOT NULL,
	[or_special] [bit] NOT NULL,
	[or_tranrecv] [numeric](17, 7) NOT NULL,
	[or_feattree] [nvarchar](max) NOT NULL,
	[or_override] [int] NOT NULL,
	[or_origprice] [numeric](17, 7) NOT NULL,
	[or_dealpric] [numeric](17, 7) NOT NULL,
	[or_avgcost] [numeric](17, 7) NOT NULL,
	[or_cuid] [int] NOT NULL,
	[or_linedisc] [numeric](12, 4) NOT NULL,
	[or_origprod] [int] NOT NULL,
	[or_sizeprod] [int] NOT NULL,
	[or_quotedcost] [numeric](17, 7) NOT NULL,
	[or_catchwgt] [numeric](17, 7) NOT NULL,
	[or_blanket] [numeric](17, 7) NOT NULL,
	[or_blanketid] [int] NOT NULL,
	[or_inclfeat] [bit] NOT NULL,
	[or_featpric] [numeric](17, 7) NOT NULL,
	[or_pmid] [int] NOT NULL,
	[or_pmfact] [numeric](17, 7) NOT NULL,
	[or_p4id] [int] NOT NULL,
	[or_noinv] [bit] NOT NULL,
	[or_ordquant] [numeric](17, 7) NOT NULL,
	[or_shipquant] [numeric](17, 7) NOT NULL,
	[or_duedock] [datetime] NULL,
	[or_rtid] [int] NOT NULL,
	[or_dockmins] [numeric](17, 7) NOT NULL,
	[or_tarewgt] [numeric](17, 7) NOT NULL,
	[or_packages] [nvarchar](max) NOT NULL,
	[or_cogsdelta] [numeric](17, 7) NOT NULL,
	[or_frtcost] [numeric](17, 7) NOT NULL,
	[or_overridedate] [datetime] NULL,
	[or_overrideuser] [nvarchar](max) NOT NULL,
	[or_priceordnum] [numeric](15, 0) NOT NULL,
	[or_planquant] [numeric](17, 7) NOT NULL,
	[or_qplan] [numeric](17, 7) NOT NULL,
	[or_totalorder] [bit] NOT NULL,
	[or_scid] [int] NOT NULL,
	[or_siid] [int] NOT NULL,
	[or_backquant] [numeric](17, 7) NOT NULL,
	[or_autoaddfreight] [bit] NOT NULL,
	[or_discountid] [int] NOT NULL,
	[or_noreserve] [bit] NOT NULL,
	[or_commable] [bit] NOT NULL,
	[or_promoamt] [numeric](17, 7) NOT NULL,
	[or_poallocatable] [bit] NOT NULL,
	[or_pickunit] [int] NOT NULL,
	[or_linejob] [bit] NOT NULL,
	[or_repack] [bit] NOT NULL,
	[or_shid] [int] NOT NULL,
	[or_masterorid] [int] NOT NULL,
	[or_trid] [int] NOT NULL,
	[or_frid] [int] NOT NULL,
	[or_doid] [int] NOT NULL,
	[or_actualfrtcost] [numeric](17, 7) NOT NULL,
	[or_gcid] [int] NOT NULL,
	[or_vaid] [int] NOT NULL,
	[or_laborcogsid] [int] NOT NULL,
	[or_burdencogsid] [int] NOT NULL,
	[or_pricefactor] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dtord] PRIMARY KEY CLUSTERED 
(
	[or_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtord2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtord2](
	[o2_id] [int] IDENTITY(1,1) NOT NULL,
	[o2_orid] [int] NOT NULL,
	[o2_feid] [int] NOT NULL,
	[o2_feid2] [int] NOT NULL,
	[o2_quant] [numeric](17, 7) NOT NULL,
	[o2_fename] [nvarchar](60) NOT NULL,
	[o2_fename2] [nvarchar](60) NOT NULL,
	[o2_seq] [nvarchar](30) NOT NULL,
	[o2_endpt] [bit] NOT NULL,
	[o2_price] [numeric](17, 7) NOT NULL,
	[o2_parent] [int] NOT NULL,
	[o2_prid] [int] NOT NULL,
	[o2_comments] [nvarchar](30) NOT NULL,
	[o2_prid2] [int] NOT NULL,
	[o2_f2id] [int] NOT NULL,
	[o2_multiple] [bit] NOT NULL,
	[o2_notes] [nvarchar](max) NOT NULL,
	[o2_f2id2] [int] NOT NULL,
	[o2_nocost] [bit] NOT NULL,
	[o2_usedeals] [bit] NOT NULL,
	[o2_usepromos] [bit] NOT NULL,
	[o2_comm] [bit] NOT NULL,
	[o2_required] [bit] NOT NULL,
	[o2_basequant] [numeric](17, 7) NOT NULL,
	[o2_suffix] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_dtord2] PRIMARY KEY CLUSTERED 
(
	[o2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtordpricealloc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtordpricealloc](
	[oa_id] [int] IDENTITY(1,1) NOT NULL,
	[oa_orid] [int] NOT NULL,
	[oa_price] [numeric](17, 7) NOT NULL,
	[oa_account] [int] NOT NULL,
 CONSTRAINT [PK_dtordpricealloc] PRIMARY KEY CLUSTERED 
(
	[oa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtpackage]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtpackage](
	[pa_id] [int] IDENTITY(1,1) NOT NULL,
	[pa_name] [nvarchar](30) NOT NULL,
	[pa_confirm] [nvarchar](max) NOT NULL,
	[pa_weight] [numeric](17, 7) NOT NULL,
	[pa_totalcharge] [numeric](12, 2) NOT NULL,
	[pa_active] [bit] NOT NULL,
	[pa_charge] [numeric](12, 2) NOT NULL,
	[pa_addthandle] [nvarchar](max) NOT NULL,
	[pa_cargoair] [bit] NOT NULL,
	[pa_offeror] [nvarchar](60) NOT NULL,
	[pa_shipname] [nvarchar](30) NOT NULL,
	[pa_signame] [nvarchar](60) NOT NULL,
	[pa_sigtitle] [nvarchar](30) NOT NULL,
	[pa_unit] [nvarchar](5) NOT NULL,
	[pa_aescomp] [nvarchar](60) NOT NULL,
	[pa_length] [numeric](17, 0) NOT NULL,
	[pa_width] [numeric](17, 0) NOT NULL,
	[pa_height] [numeric](17, 0) NOT NULL,
	[pa_dimunits] [nvarchar](5) NOT NULL,
	[pa_bookingnum] [nvarchar](30) NOT NULL,
	[pa_loadandcount] [int] NOT NULL,
	[pa_overpack] [bit] NOT NULL,
	[pa_easypostid] [nvarchar](100) NOT NULL,
	[pa_cod] [bit] NOT NULL,
	[pa_packtype] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dtpackage] PRIMARY KEY CLUSTERED 
(
	[pa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtpackageline]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtpackageline](
	[pl_paid] [int] NOT NULL,
	[pl_id] [int] IDENTITY(1,1) NOT NULL,
	[pl_orid] [int] NOT NULL,
	[pl_quant] [numeric](17, 7) NOT NULL,
	[pl_active] [bit] NOT NULL,
	[pl_piid] [int] NOT NULL,
	[pl_linenum] [numeric](10, 0) NOT NULL,
	[pl_value] [numeric](14, 2) NOT NULL,
	[pl_harmonizedcode] [nvarchar](60) NOT NULL,
	[pl_weight] [numeric](17, 7) NOT NULL,
	[pl_unit] [nvarchar](5) NOT NULL,
	[pl_dnid] [int] NOT NULL,
	[pl_label] [nvarchar](100) NOT NULL,
	[pl_authorization] [nvarchar](100) NOT NULL,
	[pl_lotnum] [numeric](10, 0) NOT NULL,
	[pl_compprid] [int] NOT NULL,
	[pl_compcodenum] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dtpackageline] PRIMARY KEY CLUSTERED 
(
	[pl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtpaybreak]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtpaybreak](
	[pb_id] [int] IDENTITY(1,1) NOT NULL,
	[pb_breakin] [numeric](4, 0) NOT NULL,
	[pb_breakout] [numeric](4, 0) NOT NULL,
	[pb_ptid] [int] NOT NULL,
	[pb_datein] [datetime] NULL,
	[pb_dateout] [datetime] NULL,
 CONSTRAINT [PK_dtpaybreak] PRIMARY KEY CLUSTERED 
(
	[pb_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtpaysched]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtpaysched](
	[ps_id] [int] IDENTITY(1,1) NOT NULL,
	[ps_table] [nvarchar](30) NOT NULL,
	[ps_recid] [int] NOT NULL,
	[ps_date] [datetime] NULL,
	[ps_totdue] [numeric](12, 2) NOT NULL,
	[ps_peid] [int] NOT NULL,
	[ps_deposit] [bit] NOT NULL,
	[ps_antcash] [datetime] NULL,
	[ps_balance] [numeric](12, 2) NOT NULL,
	[ps_colldate] [datetime] NULL,
 CONSTRAINT [PK_dtpaysched] PRIMARY KEY CLUSTERED 
(
	[ps_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtpaytime]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtpaytime](
	[pt_id] [int] IDENTITY(1,1) NOT NULL,
	[pt_timein] [numeric](4, 0) NOT NULL,
	[pt_timeout] [numeric](4, 0) NOT NULL,
	[pt_woid] [int] NOT NULL,
	[pt_crid] [int] NOT NULL,
	[pt_datein] [datetime] NULL,
	[pt_dateout] [datetime] NULL,
	[pt_overtime] [numeric](13, 3) NOT NULL,
	[pt_otfactr] [numeric](5, 2) NOT NULL,
	[pt_otchid] [int] NOT NULL,
	[pt_rate] [numeric](12, 2) NOT NULL,
	[pt_chid] [int] NOT NULL,
	[pt_waid] [int] NOT NULL,
	[pt_burdenrate] [numeric](12, 2) NOT NULL,
 CONSTRAINT [PK_dtpaytime] PRIMARY KEY CLUSTERED 
(
	[pt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtphys]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtphys](
	[ph_id] [int] IDENTITY(1,1) NOT NULL,
	[ph_date] [datetime] NULL,
	[ph_name] [nvarchar](30) NOT NULL,
	[ph_complete] [datetime] NULL,
	[ph_waid] [int] NOT NULL,
	[ph_filter] [nvarchar](max) NOT NULL,
	[ph_active] [bit] NOT NULL,
	[ph_grouping] [nvarchar](30) NOT NULL,
	[ph_lotattributes] [nvarchar](10) NOT NULL,
	[ph_lotdate] [nvarchar](10) NOT NULL,
	[ph_cyclecount] [bit] NOT NULL,
	[ph_containergrpby] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_dtphys] PRIMARY KEY CLUSTERED 
(
	[ph_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtphys2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtphys2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_phid] [int] NOT NULL,
	[p2_prid] [int] NOT NULL,
	[p2_onhand] [numeric](17, 7) NOT NULL,
	[p2_adjust] [numeric](17, 7) NOT NULL,
	[p2_seq] [int] NOT NULL,
	[p2_location] [nvarchar](30) NOT NULL,
	[p2_userlot] [nvarchar](60) NOT NULL,
	[p2_cost] [numeric](17, 7) NOT NULL,
	[p2_newloc] [nvarchar](30) NOT NULL,
	[p2_serial] [nvarchar](30) NOT NULL,
	[p2_allonum] [numeric](15, 0) NOT NULL,
	[p2_allotype] [nvarchar](30) NOT NULL,
	[p2_orid] [int] NOT NULL,
	[p2_attrib1] [nvarchar](60) NOT NULL,
	[p2_attrib2] [nvarchar](60) NOT NULL,
	[p2_attrib3] [nvarchar](60) NOT NULL,
	[p2_basedon] [nvarchar](30) NOT NULL,
	[p2_newcost] [numeric](17, 7) NOT NULL,
	[p2_syslot] [int] NOT NULL,
	[p2_complete] [bit] NOT NULL,
	[p2_loid] [int] NOT NULL,
	[p2_newloid] [int] NOT NULL,
	[p2_qc] [nvarchar](30) NOT NULL,
	[p2_expires] [datetime] NULL,
	[p2_masterlot] [int] NOT NULL,
	[p2_density] [numeric](17, 7) NOT NULL,
	[p2_catchwgt] [numeric](17, 7) NOT NULL,
	[p2_contunid] [int] NOT NULL,
	[p2_container] [numeric](17, 7) NOT NULL,
	[p2_contnum] [nvarchar](30) NOT NULL,
	[p2_postref] [nvarchar](30) NOT NULL,
	[p2_origpostref] [nvarchar](30) NOT NULL,
	[p2_lotdate] [datetime] NULL,
	[p2_notes] [nvarchar](max) NOT NULL,
	[p2_newattrib1] [nvarchar](60) NOT NULL,
	[p2_newattrib2] [nvarchar](60) NOT NULL,
	[p2_newattrib3] [nvarchar](60) NOT NULL,
	[p2_newlotdate] [datetime] NULL,
	[p2_tarewgt] [numeric](10, 7) NOT NULL,
 CONSTRAINT [PK_dtphys2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtprerecqc]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtprerecqc](
	[pq_id] [int] IDENTITY(1,1) NOT NULL,
	[pq_prid] [int] NOT NULL,
	[pq_veid] [int] NOT NULL,
	[pq_userlot] [nvarchar](60) NOT NULL,
	[pq_active] [bit] NOT NULL,
	[pq_waid] [int] NOT NULL,
	[pq_reid] [int] NOT NULL,
	[pq_attrib1] [nvarchar](60) NOT NULL,
	[pq_attrib2] [nvarchar](60) NOT NULL,
	[pq_attrib3] [nvarchar](60) NOT NULL,
	[pq_p2id] [int] NOT NULL,
	[pq_lotdate] [datetime] NULL,
 CONSTRAINT [PK_dtprerecqc] PRIMARY KEY CLUSTERED 
(
	[pq_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtprodreviews]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtprodreviews](
	[rv_id] [int] IDENTITY(1,1) NOT NULL,
	[rv_name] [nvarchar](60) NOT NULL,
	[rv_title] [nvarchar](60) NOT NULL,
	[rv_review] [nvarchar](max) NOT NULL,
	[rv_rating] [int] NOT NULL,
	[rv_prid] [int] NOT NULL,
	[rv_date] [datetime] NULL,
	[rv_visible] [bit] NOT NULL,
	[rv_csid] [int] NOT NULL,
	[rv_epid] [int] NOT NULL,
	[rv_cuid] [int] NOT NULL,
 CONSTRAINT [PK_dtprodreviews] PRIMARY KEY CLUSTERED 
(
	[rv_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtproj]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtproj](
	[pj_id] [int] IDENTITY(1,1) NOT NULL,
	[pj_name] [nvarchar](30) NOT NULL,
	[pj_projnum] [numeric](10, 0) NOT NULL,
	[pj_created] [datetime] NULL,
	[pj_active] [bit] NOT NULL,
	[pj_notes] [nvarchar](max) NOT NULL,
	[pj_budget] [numeric](17, 7) NOT NULL,
	[pj_wipinv] [int] NOT NULL,
	[pj_finmat] [int] NOT NULL,
	[pj_finlab] [int] NOT NULL,
	[pj_finbur] [int] NOT NULL,
	[pj_matexp] [int] NOT NULL,
 CONSTRAINT [PK_dtproj] PRIMARY KEY CLUSTERED 
(
	[pj_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtpur]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtpur](
	[pu_id] [int] IDENTITY(1,1) NOT NULL,
	[pu_purnum] [numeric](15, 0) NOT NULL,
	[pu_linenum] [numeric](10, 0) NOT NULL,
	[pu_prid] [int] NOT NULL,
	[pu_vnddesc] [nvarchar](200) NOT NULL,
	[pu_ourcode] [nvarchar](30) NOT NULL,
	[pu_ordman] [numeric](17, 7) NOT NULL,
	[pu_recman] [numeric](17, 7) NOT NULL,
	[pu_quant] [numeric](17, 7) NOT NULL,
	[pu_price] [numeric](17, 7) NOT NULL,
	[pu_stancos] [numeric](17, 7) NOT NULL,
	[pu_exten] [numeric](14, 2) NOT NULL,
	[pu_qship] [numeric](17, 7) NOT NULL,
	[pu_notes] [nvarchar](max) NOT NULL,
	[pu_stocked] [bit] NOT NULL,
	[pu_jobnum] [numeric](15, 0) NOT NULL,
	[pu_wanted] [datetime] NULL,
	[pu_promise] [datetime] NULL,
	[pu_duedock] [datetime] NULL,
	[pu_confirm] [datetime] NULL,
	[pu_expires] [datetime] NULL,
	[pu_relieve] [datetime] NULL,
	[pu_prfact] [numeric](20, 10) NOT NULL,
	[pu_prunid] [int] NOT NULL,
	[pu_unitwgt] [numeric](20, 10) NOT NULL,
	[pu_chid] [int] NOT NULL,
	[pu_tally] [nvarchar](max) NOT NULL,
	[pu_ordnum] [numeric](15, 0) NOT NULL,
	[pu_p2id] [int] NOT NULL,
	[pu_vndcode] [nvarchar](30) NOT NULL,
	[pu_user1] [nvarchar](30) NOT NULL,
	[pu_orid] [int] NOT NULL,
	[pu_stanmat] [numeric](17, 7) NOT NULL,
	[pu_discoun] [numeric](12, 4) NOT NULL,
	[pu_taid] [int] NOT NULL,
	[pu_taxable] [bit] NOT NULL,
	[pu_tpid] [int] NOT NULL,
	[pu_approved] [bit] NOT NULL,
	[pu_failed] [bit] NOT NULL,
	[pu_tranship] [numeric](17, 7) NOT NULL,
	[pu_shipman] [numeric](17, 7) NOT NULL,
	[pu_blanket] [numeric](17, 7) NOT NULL,
	[pu_blanketid] [int] NOT NULL,
	[pu_hazard] [nvarchar](30) NOT NULL,
	[pu_hazflag] [bit] NOT NULL,
	[pu_frtcost] [numeric](17, 7) NOT NULL,
	[pu_noinv] [bit] NOT NULL,
	[pu_release] [datetime] NULL,
	[pu_prictyp] [nvarchar](30) NOT NULL,
	[pu_purunid] [int] NOT NULL,
	[pu_dockmins] [numeric](17, 7) NOT NULL,
	[pu_biid] [int] NOT NULL,
	[pu_adjustpuid] [int] NOT NULL,
	[pu_backquant] [numeric](17, 7) NOT NULL,
	[pu_totalorder] [bit] NOT NULL,
	[pu_pjid] [int] NOT NULL,
	[pu_1099] [bit] NOT NULL,
	[pu_tyid] [int] NOT NULL,
	[pu_unitcos] [numeric](17, 7) NOT NULL,
	[pu_mfgveid] [int] NOT NULL,
	[pu_matbur] [numeric](17, 7) NOT NULL,
	[pu_vaid] [int] NOT NULL,
	[pu_invoiceprice] [numeric](17, 7) NOT NULL,
	[pu_pricefactor] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dtpur] PRIMARY KEY CLUSTERED 
(
	[pu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtpur2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtpur2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_fiid] [int] NOT NULL,
	[p2_puid] [int] NOT NULL,
	[p2_srcloid] [int] NOT NULL,
 CONSTRAINT [PK_dtpur2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtpurlinkedso]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtpurlinkedso](
	[pl_id] [int] IDENTITY(1,1) NOT NULL,
	[pl_orid] [int] NOT NULL,
	[pl_puid] [int] NOT NULL,
	[pl_quant] [numeric](17, 7) NOT NULL,
	[pl_seq] [int] NOT NULL,
	[pl_ordnum] [numeric](15, 0) NOT NULL,
	[pl_freightpo] [bit] NOT NULL,
 CONSTRAINT [PK_dtpurlinkedso] PRIMARY KEY CLUSTERED 
(
	[pl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtqc4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtqc4](
	[q4_id] [int] IDENTITY(1,1) NOT NULL,
	[q4_q2id] [int] NOT NULL,
	[q4_value] [nvarchar](30) NOT NULL,
	[q4_table] [nvarchar](30) NOT NULL,
	[q4_recid] [int] NOT NULL,
	[q4_notes] [nvarchar](max) NOT NULL,
	[q4_ordnum] [numeric](15, 0) NOT NULL,
	[q4_pass] [int] NOT NULL,
	[q4_lineid] [int] NOT NULL,
	[q4_complete] [bit] NOT NULL,
	[q4_group] [int] NOT NULL,
	[q4_mindet] [numeric](17, 7) NOT NULL,
	[q4_stid] [int] NOT NULL,
	[q4_usid] [int] NOT NULL,
	[q4_date] [datetime] NULL,
	[q4_time] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dtqc4] PRIMARY KEY CLUSTERED 
(
	[q4_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtqc5]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtqc5](
	[q5_id] [int] IDENTITY(1,1) NOT NULL,
	[q5_usid] [int] NOT NULL,
	[q5_date] [datetime] NULL,
	[q5_table] [nvarchar](30) NOT NULL,
	[q5_recid] [int] NOT NULL,
	[q5_time] [nvarchar](8) NOT NULL,
	[q5_action] [nvarchar](30) NOT NULL,
	[q5_ordnum] [numeric](15, 0) NOT NULL,
	[q5_lineid] [int] NOT NULL,
	[q5_q4group] [int] NOT NULL,
	[q5_notes] [nvarchar](max) NOT NULL,
	[q5_signature] [nvarchar](max) NOT NULL,
	[q5_pass] [int] NOT NULL,
 CONSTRAINT [PK_dtqc5] PRIMARY KEY CLUSTERED 
(
	[q5_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtqcfreq]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtqcfreq](
	[qf_id] [int] IDENTITY(1,1) NOT NULL,
	[qf_senttoqc] [bit] NOT NULL,
	[qf_date] [datetime] NULL,
	[qf_revnum] [int] NOT NULL,
	[qf_prid] [int] NOT NULL,
	[qf_qcid] [int] NOT NULL,
	[qf_linetable] [nvarchar](30) NOT NULL,
	[qf_lineid] [int] NOT NULL,
	[qf_q6id] [int] NOT NULL,
	[qf_waid] [int] NOT NULL,
	[qf_p2id] [int] NOT NULL,
 CONSTRAINT [PK_dtqcfreq] PRIMARY KEY CLUSTERED 
(
	[qf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtqcfreqassgn]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtqcfreqassgn](
	[qa_id] [int] IDENTITY(1,1) NOT NULL,
	[qa_lotnum] [numeric](10, 0) NOT NULL,
	[qa_qfid] [int] NOT NULL,
	[qa_userlot] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_dtqcfreqassgn] PRIMARY KEY CLUSTERED 
(
	[qa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtqclots]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtqclots](
	[ql_id] [int] IDENTITY(1,1) NOT NULL,
	[ql_q4group] [int] NOT NULL,
	[ql_fiid] [int] NOT NULL,
	[ql_approved] [bit] NOT NULL,
	[ql_failed] [bit] NOT NULL,
	[ql_ljid] [int] NOT NULL,
	[ql_origgroup] [int] NOT NULL,
	[ql_pqid] [int] NOT NULL,
	[ql_ungrouped] [bit] NOT NULL,
 CONSTRAINT [PK_dtqclots] PRIMARY KEY CLUSTERED 
(
	[ql_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtqcprerecpo]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtqcprerecpo](
	[qp_id] [int] IDENTITY(1,1) NOT NULL,
	[qp_pqid] [int] NOT NULL,
	[qp_tpid] [int] NOT NULL,
 CONSTRAINT [PK_dtqcprerecpo] PRIMARY KEY CLUSTERED 
(
	[qp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtregisterrec]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtregisterrec](
	[rr_id] [int] IDENTITY(1,1) NOT NULL,
	[rr_postref] [nvarchar](30) NOT NULL,
	[rr_c3id] [int] NOT NULL,
	[rr_rgid] [int] NOT NULL,
	[rr_endbal] [numeric](17, 7) NOT NULL,
 CONSTRAINT [PK_dtregisterrec] PRIMARY KEY CLUSTERED 
(
	[rr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtroute]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtroute](
	[ru_id] [int] IDENTITY(1,1) NOT NULL,
	[ru_startdate] [datetime] NULL,
	[ru_starttime] [numeric](4, 0) NOT NULL,
	[ru_enddate] [datetime] NULL,
	[ru_endtime] [numeric](4, 0) NOT NULL,
	[ru_usid] [int] NOT NULL,
	[ru_deviceid] [nvarchar](100) NOT NULL,
	[ru_loid] [int] NOT NULL,
	[ru_trid] [int] NOT NULL,
	[ru_ltid] [int] NOT NULL,
	[ru_chid] [int] NOT NULL,
 CONSTRAINT [PK_dtroute] PRIMARY KEY CLUSTERED 
(
	[ru_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtrss]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtrss](
	[rs_id] [int] IDENTITY(1,1) NOT NULL,
	[rs_descrip] [nvarchar](250) NOT NULL,
	[rs_link] [nvarchar](250) NOT NULL,
	[rs_date] [datetime] NULL,
	[rs_coid] [int] NOT NULL,
 CONSTRAINT [PK_dtrss] PRIMARY KEY CLUSTERED 
(
	[rs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtstaging]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtstaging](
	[st_figroup] [numeric](10, 0) NOT NULL,
	[st_id] [int] IDENTITY(1,1) NOT NULL,
	[st_jobnum] [numeric](15, 0) NOT NULL,
	[st_f2group] [numeric](10, 0) NOT NULL,
	[st_ordnum] [numeric](15, 0) NOT NULL,
	[st_stagcnt] [int] NOT NULL,
	[st_boid] [int] NOT NULL,
 CONSTRAINT [PK_dtstaging] PRIMARY KEY CLUSTERED 
(
	[st_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dttestresult]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dttestresult](
	[tr_id] [int] IDENTITY(1,1) NOT NULL,
	[tr_build] [int] NOT NULL,
	[tr_passed] [bit] NOT NULL,
	[tr_failed] [bit] NOT NULL,
	[tr_teid] [int] NOT NULL,
	[tr_usid] [int] NOT NULL,
	[tr_date] [datetime] NULL,
	[tr_log] [nvarchar](max) NOT NULL,
	[tr_verifiedby] [int] NOT NULL,
	[tr_validations] [nvarchar](max) NOT NULL,
	[tr_seq] [numeric](10, 0) NOT NULL,
 CONSTRAINT [PK_dttestresult] PRIMARY KEY CLUSTERED 
(
	[tr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dttick]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dttick](
	[ti_id] [int] IDENTITY(1,1) NOT NULL,
	[ti_ticknum] [numeric](9, 0) NOT NULL,
	[ti_primuser] [int] NOT NULL,
	[ti_usid] [int] NOT NULL,
	[ti_cdate] [datetime] NULL,
	[ti_ctime] [numeric](4, 0) NOT NULL,
	[ti_pprovdate] [datetime] NULL,
	[ti_pprovtime] [numeric](4, 0) NOT NULL,
	[ti_promdate] [datetime] NULL,
	[ti_exdate] [datetime] NULL,
	[ti_resdate] [datetime] NULL,
	[ti_lastdate] [datetime] NULL,
	[ti_lasttime] [numeric](4, 0) NOT NULL,
	[ti_t1id] [int] NOT NULL,
	[ti_t2id] [int] NOT NULL,
	[ti_t3id] [int] NOT NULL,
	[ti_t4id] [int] NOT NULL,
	[ti_t5id] [int] NOT NULL,
	[ti_summary] [nvarchar](max) NOT NULL,
	[ti_detail] [nvarchar](max) NOT NULL,
	[ti_trakid] [int] NOT NULL,
	[ti_trak2id] [int] NOT NULL,
	[ti_tickettype] [nvarchar](30) NOT NULL,
	[ti_assignuser] [int] NOT NULL,
	[ti_resolution] [nvarchar](max) NOT NULL,
	[ti_tcid] [int] NOT NULL,
 CONSTRAINT [PK_dttick] PRIMARY KEY CLUSTERED 
(
	[ti_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dttickcont]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dttickcont](
	[tt_id] [int] IDENTITY(1,1) NOT NULL,
	[tt_tiid] [int] NOT NULL,
	[tt_coid] [int] NOT NULL,
	[tt_memo] [nvarchar](max) NOT NULL,
	[tt_cpid] [int] NOT NULL,
 CONSTRAINT [PK_dttickcont] PRIMARY KEY CLUSTERED 
(
	[tt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtticknote]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtticknote](
	[tn_id] [int] IDENTITY(1,1) NOT NULL,
	[tn_tiid] [int] NOT NULL,
	[tn_date] [datetime] NULL,
	[tn_time] [numeric](4, 0) NOT NULL,
	[tn_usid] [int] NOT NULL,
	[tn_note] [nvarchar](max) NOT NULL,
	[tn_teid] [int] NOT NULL,
	[tn_coid] [int] NOT NULL,
 CONSTRAINT [PK_dtticknote] PRIMARY KEY CLUSTERED 
(
	[tn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dttord]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dttord](
	[to_ordnum] [numeric](15, 0) NOT NULL,
	[to_ordtype] [nvarchar](1) NOT NULL,
	[to_quoted] [datetime] NULL,
	[to_ordered] [datetime] NULL,
	[to_orddate] [datetime] NULL,
	[to_biid] [int] NOT NULL,
	[to_shid] [int] NOT NULL,
	[to_smid] [int] NOT NULL,
	[to_brid] [int] NOT NULL,
	[to_s1id] [int] NOT NULL,
	[to_s2id] [int] NOT NULL,
	[to_grid] [int] NOT NULL,
	[to_billpo] [nvarchar](30) NOT NULL,
	[to_shippo] [nvarchar](30) NOT NULL,
	[to_prtpack] [datetime] NULL,
	[to_shipped] [datetime] NULL,
	[to_trid] [int] NOT NULL,
	[to_teid] [int] NOT NULL,
	[to_credhld] [datetime] NULL,
	[to_invdate] [datetime] NULL,
	[to_totdue] [numeric](12, 2) NOT NULL,
	[to_balance] [numeric](12, 2) NOT NULL,
	[to_paydate] [datetime] NULL,
	[to_notes] [nvarchar](max) NOT NULL,
	[to_confirm] [nvarchar](max) NOT NULL,
	[to_waid] [int] NOT NULL,
	[to_header] [bit] NOT NULL,
	[to_descrip] [nvarchar](60) NOT NULL,
	[to_prognum] [int] NOT NULL,
	[to_user1] [nvarchar](30) NOT NULL,
	[to_release] [datetime] NULL,
	[to_linkto] [numeric](15, 0) NOT NULL,
	[to_frid] [int] NOT NULL,
	[to_expires] [datetime] NULL,
	[to_flush] [bit] NOT NULL,
	[to_trakid] [int] NOT NULL,
	[to_trak2id] [int] NOT NULL,
	[to_wanted] [datetime] NULL,
	[to_dueship] [datetime] NULL,
	[to_archid] [int] NOT NULL,
	[to_discoun] [numeric](12, 2) NOT NULL,
	[to_remarks] [nvarchar](max) NOT NULL,
	[to_history] [nvarchar](max) NOT NULL,
	[to_usid] [int] NOT NULL,
	[to_trid2] [int] NOT NULL,
	[to_prepay] [int] NOT NULL,
	[to_s3id] [int] NOT NULL,
	[to_statax] [int] NOT NULL,
	[to_loctax] [int] NOT NULL,
	[to_sgid] [int] NOT NULL,
	[to_prior] [numeric](10, 0) NOT NULL,
	[to_s4id] [int] NOT NULL,
	[to_s5id] [int] NOT NULL,
	[to_deltime] [numeric](4, 0) NOT NULL,
	[to_promise] [datetime] NULL,
	[to_condate] [datetime] NULL,
	[to_id] [int] IDENTITY(1,1) NOT NULL,
	[to_saved] [datetime] NULL,
	[to_status] [nvarchar](1) NOT NULL,
	[to_savetime] [nvarchar](8) NOT NULL,
	[to_minquan] [bit] NOT NULL,
	[to_tranwaid] [int] NOT NULL,
	[to_tranrecv] [datetime] NULL,
	[to_fcid] [int] NOT NULL,
	[to_fcrate] [numeric](17, 7) NOT NULL,
	[to_totwgt] [numeric](14, 4) NOT NULL,
	[to_pjid] [int] NOT NULL,
	[to_saletax] [numeric](12, 2) NOT NULL,
	[to_cashsale] [bit] NOT NULL,
	[to_overcred] [int] NOT NULL,
	[to_tendered] [numeric](12, 2) NOT NULL,
	[to_paysched] [nvarchar](max) NOT NULL,
	[to_distance] [numeric](12, 2) NOT NULL,
	[to_auid] [int] NOT NULL,
	[to_signature] [nvarchar](max) NOT NULL,
	[to_recdate] [datetime] NULL,
	[to_dgid] [int] NOT NULL,
	[to_psid] [int] NOT NULL,
	[to_crosswaid] [int] NOT NULL,
	[to_ccauth] [nvarchar](30) NOT NULL,
	[to_authorize] [numeric](12, 2) NOT NULL,
	[to_authc3id] [int] NOT NULL,
	[to_fcrate2] [numeric](17, 7) NOT NULL,
	[to_cpid] [int] NOT NULL,
	[to_duedock] [datetime] NULL,
	[to_intransit] [nvarchar](max) NOT NULL,
	[to_facilitypricing] [bit] NOT NULL,
	[to_pickuptime] [numeric](4, 0) NOT NULL,
	[to_antcash] [datetime] NULL,
	[to_credexp] [datetime] NULL,
	[to_cclast4] [nvarchar](4) NOT NULL,
	[to_doid] [int] NOT NULL,
	[to_trandoid] [int] NOT NULL,
	[to_tottare] [numeric](17, 7) NOT NULL,
	[to_deldate] [datetime] NULL,
	[to_shipfromid] [int] NOT NULL,
	[to_colldate] [datetime] NULL,
	[to_said] [int] NOT NULL,
	[to_stagcnt] [int] NOT NULL,
	[to_frominvjobnum] [numeric](15, 0) NOT NULL,
	[to_prtinv] [datetime] NULL,
	[to_invpost] [datetime] NULL,
	[to_coid] [int] NOT NULL,
	[to_recurtype] [nvarchar](30) NOT NULL,
	[to_recurinterval] [int] NOT NULL,
	[to_cardtoken] [nvarchar](100) NOT NULL,
	[to_prtpick] [datetime] NULL,
	[to_seasonal] [bit] NOT NULL,
	[to_easypostrateid] [nvarchar](100) NOT NULL,
	[to_ccinvnum] [nvarchar](50) NOT NULL,
	[to_masterordnum] [numeric](15, 0) NOT NULL,
	[to_rgid] [int] NOT NULL,
	[to_ccauthdate] [datetime] NULL,
	[to_ttid] [int] NOT NULL,
	[to_sodate] [datetime] NULL,
	[to_ruid] [int] NOT NULL,
	[to_groupnum] [int] NOT NULL,
	[to_lastusid] [int] NOT NULL,
 CONSTRAINT [PK_dttord] PRIMARY KEY CLUSTERED 
(
	[to_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dttpur]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dttpur](
	[tp_purnum] [numeric](15, 0) NOT NULL,
	[tp_ordtype] [nvarchar](1) NOT NULL,
	[tp_date] [datetime] NULL,
	[tp_veid] [int] NOT NULL,
	[tp_vendinv] [nvarchar](30) NOT NULL,
	[tp_teid] [int] NOT NULL,
	[tp_totdue] [numeric](12, 2) NOT NULL,
	[tp_balance] [numeric](12, 2) NOT NULL,
	[tp_paydate] [datetime] NULL,
	[tp_invrecv] [datetime] NULL,
	[tp_topay] [datetime] NULL,
	[tp_trid] [int] NOT NULL,
	[tp_recevd] [datetime] NULL,
	[tp_prtpo] [datetime] NULL,
	[tp_seid] [int] NOT NULL,
	[tp_usid] [int] NOT NULL,
	[tp_notes] [nvarchar](max) NOT NULL,
	[tp_waid] [int] NOT NULL,
	[tp_potype] [nvarchar](10) NOT NULL,
	[tp_p1id] [int] NOT NULL,
	[tp_p2id] [int] NOT NULL,
	[tp_frid] [int] NOT NULL,
	[tp_ref1] [nvarchar](30) NOT NULL,
	[tp_ref2] [nvarchar](30) NOT NULL,
	[tp_apchid] [int] NOT NULL,
	[tp_remarks] [nvarchar](max) NOT NULL,
	[tp_history] [nvarchar](max) NOT NULL,
	[tp_trid2] [int] NOT NULL,
	[tp_deltime] [numeric](4, 0) NOT NULL,
	[tp_wanted] [datetime] NULL,
	[tp_promise] [datetime] NULL,
	[tp_duedock] [datetime] NULL,
	[tp_expires] [datetime] NULL,
	[tp_condate] [datetime] NULL,
	[tp_discoun] [numeric](12, 4) NOT NULL,
	[tp_taid1] [int] NOT NULL,
	[tp_taid2] [int] NOT NULL,
	[tp_fcid] [int] NOT NULL,
	[tp_fcrate] [numeric](17, 7) NOT NULL,
	[tp_autoinv] [bit] NOT NULL,
	[tp_totwgt] [numeric](14, 4) NOT NULL,
	[tp_id] [int] IDENTITY(1,1) NOT NULL,
	[tp_prepay] [int] NOT NULL,
	[tp_paysched] [nvarchar](max) NOT NULL,
	[tp_trakid] [int] NOT NULL,
	[tp_trak2id] [int] NOT NULL,
	[tp_dropship] [bit] NOT NULL,
	[tp_tranship] [datetime] NULL,
	[tp_tranwaid] [int] NOT NULL,
	[tp_posuspchid] [int] NOT NULL,
	[tp_coid] [int] NOT NULL,
	[tp_release] [datetime] NULL,
	[tp_minquan] [bit] NOT NULL,
	[tp_source] [nvarchar](30) NOT NULL,
	[tp_invvend] [datetime] NULL,
	[tp_approvedate] [datetime] NULL,
	[tp_approvetime] [numeric](4, 0) NOT NULL,
	[tp_approveusid] [int] NOT NULL,
	[tp_fcrate2] [numeric](17, 7) NOT NULL,
	[tp_doid] [int] NOT NULL,
	[tp_inventered] [datetime] NULL,
	[tp_1099] [bit] NOT NULL,
	[tp_linkto] [numeric](15, 0) NOT NULL,
	[tp_tyid] [int] NOT NULL,
	[tp_totfrtcost] [numeric](17, 7) NOT NULL,
	[tp_facilitypricing] [bit] NOT NULL,
	[tp_possdate] [datetime] NULL,
	[tp_reqtime] [numeric](4, 0) NOT NULL,
	[tp_pgid] [int] NOT NULL,
	[tp_pricingorddate] [nvarchar](30) NOT NULL,
	[tp_psid] [int] NOT NULL,
	[tp_brid] [int] NOT NULL,
 CONSTRAINT [PK_dttpur] PRIMARY KEY CLUSTERED 
(
	[tp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dttrak5]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dttrak5](
	[t5_id] [int] IDENTITY(1,1) NOT NULL,
	[t5_usid] [int] NOT NULL,
	[t5_time] [nvarchar](8) NOT NULL,
	[t5_date] [datetime] NULL,
	[t5_action] [nvarchar](30) NOT NULL,
	[t5_table] [nvarchar](30) NOT NULL,
	[t5_recid] [int] NOT NULL,
	[t5_t2id] [int] NOT NULL,
	[t5_comment] [nvarchar](max) NOT NULL,
	[t5_t2id_return] [int] NOT NULL,
	[t5_seqname] [nvarchar](max) NOT NULL,
	[t5_usid2] [int] NOT NULL,
	[t5_planned] [datetime] NULL,
	[t5_notes] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dttrak5] PRIMARY KEY CLUSTERED 
(
	[t5_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dttrigdel]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dttrigdel](
	[td_id] [int] IDENTITY(1,1) NOT NULL,
	[td_tgid] [int] NOT NULL,
	[td_recid] [int] NOT NULL,
	[td_table] [nvarchar](30) NOT NULL,
	[td_delivery] [datetime] NULL,
 CONSTRAINT [PK_dttrigdel] PRIMARY KEY CLUSTERED 
(
	[td_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dttrigqueue]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dttrigqueue](
	[tq_id] [int] IDENTITY(1,1) NOT NULL,
	[tq_tgid] [int] NOT NULL,
	[tq_recid] [int] NOT NULL,
 CONSTRAINT [PK_dttrigqueue] PRIMARY KEY CLUSTERED 
(
	[tq_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtusersecquest]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtusersecquest](
	[uq_id] [int] IDENTITY(1,1) NOT NULL,
	[uq_sqid] [int] NOT NULL,
	[uq_usid] [int] NOT NULL,
	[uq_secanswer] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_dtusersecquest] PRIMARY KEY CLUSTERED 
(
	[uq_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtworkshift]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtworkshift](
	[ws_id] [int] IDENTITY(1,1) NOT NULL,
	[ws_date] [datetime] NULL,
	[ws_sfid] [int] NOT NULL,
	[ws_woid] [int] NOT NULL,
	[ws_j2id] [int] NOT NULL,
 CONSTRAINT [PK_dtworkshift] PRIMARY KEY CLUSTERED 
(
	[ws_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxbrow]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxbrow](
	[br_id] [int] IDENTITY(1,1) NOT NULL,
	[br_name] [nvarchar](30) NOT NULL,
	[br_title] [nvarchar](30) NOT NULL,
	[br_b3id] [int] NOT NULL,
	[br_refresh] [bit] NOT NULL,
	[br_userref] [nvarchar](30) NOT NULL,
	[br_actfld] [nvarchar](30) NOT NULL,
	[br_layout] [nvarchar](30) NOT NULL,
	[br_editfld] [nvarchar](30) NOT NULL,
	[br_edittbl] [nvarchar](30) NOT NULL,
	[br_parentref] [bit] NOT NULL,
	[br_userpref] [nvarchar](30) NOT NULL,
	[br_gridid] [int] NOT NULL,
	[br_gridfor] [nvarchar](30) NOT NULL,
	[br_drillpage] [nvarchar](100) NOT NULL,
	[br_drillval] [nvarchar](100) NOT NULL,
	[br_isiphone] [bit] NOT NULL,
	[br_c2id] [int] NOT NULL,
	[br_iphonecelltype] [nvarchar](30) NOT NULL,
	[br_b3name] [nvarchar](30) NOT NULL,
	[br_device] [nvarchar](30) NOT NULL,
	[br_pincols] [int] NOT NULL,
	[br_quid] [int] NOT NULL,
	[br_secrequired] [bit] NOT NULL,
	[br_copiedfrom] [nvarchar](60) NOT NULL,
	[br_script] [nvarchar](max) NOT NULL,
	[br_fiid] [int] NOT NULL,
	[br_c2guid] [uniqueidentifier] NULL,
	[br_internal] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_dxbrow] PRIMARY KEY CLUSTERED 
(
	[br_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxbrow2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxbrow2](
	[b2_id] [int] IDENTITY(1,1) NOT NULL,
	[b2_brid] [int] NOT NULL,
	[b2_field] [nvarchar](50) NOT NULL,
	[b2_width] [numeric](3, 0) NOT NULL,
	[b2_title] [nvarchar](60) NOT NULL,
	[b2_mask] [nvarchar](30) NOT NULL,
	[b2_format] [nvarchar](10) NOT NULL,
	[b2_sum] [bit] NOT NULL,
	[b2_sorter] [numeric](10, 0) NOT NULL,
	[b2_sortdsc] [bit] NOT NULL,
	[b2_user] [bit] NOT NULL,
	[b2_userexpr] [nvarchar](max) NOT NULL,
	[b2_wordwrap] [nvarchar](30) NOT NULL,
	[b2_drillpage] [nvarchar](30) NOT NULL,
	[b2_drillval] [nvarchar](30) NOT NULL,
	[b2_preview] [bit] NOT NULL,
	[b2_time] [bit] NOT NULL,
	[b2_iphonetype] [nvarchar](30) NOT NULL,
	[b2_c2id] [int] NOT NULL,
	[b2_iphoneformat] [nvarchar](30) NOT NULL,
	[b2_iphonefontstyle] [nvarchar](30) NOT NULL,
	[b2_mobilecaption] [bit] NOT NULL,
	[b2_c2guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dxbrow2] PRIMARY KEY CLUSTERED 
(
	[b2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxbrow3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxbrow3](
	[b3_id] [int] IDENTITY(1,1) NOT NULL,
	[b3_name] [nvarchar](30) NOT NULL,
	[b3_code] [nvarchar](max) NOT NULL,
	[b3_usercod] [nvarchar](max) NOT NULL,
	[b3_user] [bit] NOT NULL,
 CONSTRAINT [PK_dxbrow3] PRIMARY KEY CLUSTERED 
(
	[b3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxbrowreport]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxbrowreport](
	[bt_id] [int] IDENTITY(1,1) NOT NULL,
	[bt_reid] [int] NOT NULL,
	[bt_name] [nvarchar](30) NOT NULL,
	[bt_default] [bit] NOT NULL,
	[bt_brid] [int] NOT NULL,
	[bt_type] [nvarchar](30) NOT NULL,
	[bt_text] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxbrowreport] PRIMARY KEY CLUSTERED 
(
	[bt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxbrowsec]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxbrowsec](
	[bs_id] [int] IDENTITY(1,1) NOT NULL,
	[bs_access] [bit] NOT NULL,
	[bs_brname] [nvarchar](30) NOT NULL,
	[bs_usid] [int] NOT NULL,
	[bs_ugid] [int] NOT NULL,
 CONSTRAINT [PK_dxbrowsec] PRIMARY KEY CLUSTERED 
(
	[bs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxbutton]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxbutton](
	[bu_id] [int] IDENTITY(1,1) NOT NULL,
	[bu_name] [int] NOT NULL,
	[bu_code] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxbutton] PRIMARY KEY CLUSTERED 
(
	[bu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxbutton2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxbutton2](
	[b2_groupid] [int] NOT NULL,
	[b2_buid] [int] NOT NULL,
	[b2_position] [int] NOT NULL,
	[b2_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dxbutton2] PRIMARY KEY CLUSTERED 
(
	[b2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxbutton3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxbutton3](
	[b3_id] [int] IDENTITY(1,1) NOT NULL,
	[b3_brid] [int] NOT NULL,
	[b3_grouppos] [int] NOT NULL,
	[b3_b2groupid] [int] NOT NULL,
 CONSTRAINT [PK_dxbutton3] PRIMARY KEY CLUSTERED 
(
	[b3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxcmserrors]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxcmserrors](
	[ce_id] [int] IDENTITY(1,1) NOT NULL,
	[ce_csid] [int] NOT NULL,
	[ce_date] [datetime] NULL,
	[ce_except] [nvarchar](max) NOT NULL,
	[ce_source] [nvarchar](max) NOT NULL,
	[ce_stack] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxcmserrors] PRIMARY KEY CLUSTERED 
(
	[ce_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxcmsforms]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxcmsforms](
	[cf_id] [int] IDENTITY(1,1) NOT NULL,
	[cf_name] [nvarchar](100) NOT NULL,
	[cf_desc] [nvarchar](500) NOT NULL,
	[cf_active] [bit] NOT NULL,
	[cf_email] [nvarchar](100) NOT NULL,
	[cf_emailsubj] [nvarchar](500) NOT NULL,
	[cf_emailptxt] [nvarchar](250) NOT NULL,
	[cf_type] [nvarchar](50) NOT NULL,
	[cf_ftpuser] [nvarchar](50) NOT NULL,
	[cf_ftppass] [nvarchar](150) NOT NULL,
	[cf_ftpfile] [nvarchar](100) NOT NULL,
	[cf_ftplocation] [nvarchar](150) NOT NULL,
	[cf_ftpappend] [bit] NOT NULL,
	[cf_emailfrom] [nvarchar](500) NOT NULL,
	[cf_emailfrompass] [nvarchar](150) NOT NULL,
	[cf_csid] [int] NOT NULL,
 CONSTRAINT [PK_dxcmsforms] PRIMARY KEY CLUSTERED 
(
	[cf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxcmslog]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxcmslog](
	[cl_id] [int] IDENTITY(1,1) NOT NULL,
	[cl_csid] [int] NOT NULL,
	[cl_ip] [nvarchar](40) NOT NULL,
	[cl_uaid] [int] NOT NULL,
	[cl_device] [nvarchar](30) NOT NULL,
	[cl_browser] [nvarchar](30) NOT NULL,
	[cl_date] [datetime] NULL,
 CONSTRAINT [PK_dxcmslog] PRIMARY KEY CLUSTERED 
(
	[cl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxcmsoption]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxcmsoption](
	[co_id] [int] IDENTITY(1,1) NOT NULL,
	[co_csid] [int] NOT NULL,
	[co_key] [nvarchar](50) NOT NULL,
	[co_val] [nvarchar](500) NOT NULL,
	[co_desc] [nvarchar](250) NOT NULL,
	[co_active] [bit] NOT NULL,
	[co_restrict] [bit] NOT NULL,
 CONSTRAINT [PK_dxcmsoption] PRIMARY KEY CLUSTERED 
(
	[co_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxcmspages]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxcmspages](
	[cp_id] [int] IDENTITY(1,1) NOT NULL,
	[cp_active] [bit] NOT NULL,
	[cp_markuptop] [nvarchar](max) NOT NULL,
	[cp_title] [nvarchar](200) NOT NULL,
	[cp_caid] [int] NOT NULL,
	[cp_keywords] [nvarchar](500) NOT NULL,
	[cp_desc] [nvarchar](500) NOT NULL,
	[cp_default] [bit] NOT NULL,
	[cp_date] [datetime] NULL,
	[cp_oldurl] [nvarchar](250) NOT NULL,
	[cp_hidden] [bit] NOT NULL,
	[cp_modified] [datetime] NULL,
	[cp_markupbottom] [nvarchar](max) NOT NULL,
	[cp_partial] [bit] NOT NULL,
	[cp_csid] [int] NOT NULL,
 CONSTRAINT [PK_dxcmspages] PRIMARY KEY CLUSTERED 
(
	[cp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxcmsprod]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxcmsprod](
	[cp_id] [int] IDENTITY(1,1) NOT NULL,
	[cp_active] [bit] NOT NULL,
	[cp_caid] [int] NOT NULL,
	[cp_c2id] [int] NOT NULL,
	[cp_prid] [int] NOT NULL,
	[cp_shopping] [bit] NOT NULL,
	[cp_csid] [int] NOT NULL,
	[cp_onhandquant] [numeric](17, 7) NOT NULL,
	[cp_epid] [int] NOT NULL,
	[cp_seq] [int] NOT NULL,
	[cp_available] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dxcmsprod] PRIMARY KEY CLUSTERED 
(
	[cp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxcmssite]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxcmssite](
	[cs_active] [bit] NOT NULL,
	[cs_id] [int] IDENTITY(1,1) NOT NULL,
	[cs_name] [nvarchar](30) NOT NULL,
	[cs_website] [nvarchar](100) NOT NULL,
	[cs_server] [nvarchar](30) NOT NULL,
	[cs_database] [nvarchar](30) NOT NULL,
	[cs_username] [nvarchar](30) NOT NULL,
	[cs_password] [nvarchar](100) NOT NULL,
	[cs_sync] [bit] NOT NULL,
	[cs_syncperiod] [nvarchar](30) NOT NULL,
	[cs_syncday] [nvarchar](30) NOT NULL,
	[cs_synctime] [nvarchar](30) NOT NULL,
	[cs_lastsyncdate] [datetime] NULL,
	[cs_lastsynctime] [nvarchar](30) NOT NULL,
	[cs_sitemap] [bit] NOT NULL,
	[cs_sitemappath] [nvarchar](100) NOT NULL,
	[cs_ipaddress] [nvarchar](30) NOT NULL,
	[cs_port] [int] NOT NULL,
	[cs_gcontentapi] [nvarchar](max) NOT NULL,
	[cs_allowregister] [bit] NOT NULL,
	[cs_cartwologin] [bit] NOT NULL,
	[cs_gmerchantid] [int] NOT NULL,
	[cs_gcredentials] [nvarchar](max) NOT NULL,
	[cs_defaultdate] [nvarchar](30) NOT NULL,
	[cs_userapproval] [nvarchar](30) NOT NULL,
	[cs_promolist] [bit] NOT NULL,
	[cs_secquestions] [bit] NOT NULL,
	[cs_productimages] [bit] NOT NULL,
	[cs_ordertype] [nvarchar](30) NOT NULL,
	[cs_dcid] [int] NOT NULL,
	[cs_sessionexp] [int] NOT NULL,
	[cs_regbiid] [int] NOT NULL,
	[cs_regshid] [int] NOT NULL,
	[cs_minord] [numeric](17, 7) NOT NULL,
	[cs_s1id] [int] NOT NULL,
	[cs_s2id] [int] NOT NULL,
	[cs_s3id] [int] NOT NULL,
	[cs_s4id] [int] NOT NULL,
	[cs_s5id] [int] NOT NULL,
	[cs_trid] [int] NOT NULL,
	[cs_smid] [int] NOT NULL,
	[cs_allowsaturday] [bit] NOT NULL,
	[cs_allowsunday] [bit] NOT NULL,
	[cs_syncdocs] [bit] NOT NULL,
	[cs_temppassemail] [nvarchar](max) NOT NULL,
	[cs_mrpmins] [int] NOT NULL,
	[cs_easypost] [bit] NOT NULL,
	[cs_logapicalls] [bit] NOT NULL,
	[cs_numberpass] [bit] NOT NULL,
	[cs_symbolpass] [bit] NOT NULL,
	[cs_mrpprefilter] [int] NOT NULL,
	[cs_cartreminderemail] [nvarchar](max) NOT NULL,
	[cs_usemrp] [bit] NOT NULL,
	[cs_createcontact] [bit] NOT NULL,
	[cs_reminderemailmin] [int] NOT NULL,
	[cs_salesearchdflt] [nvarchar](30) NOT NULL,
	[cs_maxcartvalue] [int] NOT NULL,
 CONSTRAINT [PK_dxcmssite] PRIMARY KEY CLUSTERED 
(
	[cs_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxcmswidgets]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxcmswidgets](
	[cw_id] [int] IDENTITY(1,1) NOT NULL,
	[cw_active] [bit] NOT NULL,
	[cw_markup] [nvarchar](max) NOT NULL,
	[cw_title] [nvarchar](100) NOT NULL,
	[cw_desc] [nvarchar](200) NOT NULL,
	[cw_css] [nvarchar](max) NOT NULL,
	[cw_js] [nvarchar](max) NOT NULL,
	[cw_csid] [int] NOT NULL,
 CONSTRAINT [PK_dxcmswidgets] PRIMARY KEY CLUSTERED 
(
	[cw_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxdflt]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxdflt](
	[df_id] [int] IDENTITY(1,1) NOT NULL,
	[df_name] [nvarchar](80) NOT NULL,
	[df_street] [nvarchar](80) NOT NULL,
	[df_city] [nvarchar](80) NOT NULL,
	[df_state] [nvarchar](80) NOT NULL,
	[df_zip] [nvarchar](80) NOT NULL,
	[df_remit] [nvarchar](80) NOT NULL,
	[df_remit2] [nvarchar](80) NOT NULL,
	[df_remit3] [nvarchar](80) NOT NULL,
	[df_remit4] [nvarchar](80) NOT NULL,
	[df_remit5] [nvarchar](20) NOT NULL,
	[df_phone] [nvarchar](60) NOT NULL,
	[df_fax] [nvarchar](60) NOT NULL,
	[df_credlim] [bit] NOT NULL,
	[df_credmax] [numeric](10, 0) NOT NULL,
	[df_teid] [int] NOT NULL,
	[df_purterm] [int] NOT NULL,
	[df_fmargin] [numeric](5, 2) NOT NULL,
	[df_pruser1] [nvarchar](60) NOT NULL,
	[df_pruser2] [nvarchar](60) NOT NULL,
	[df_pruser3] [nvarchar](60) NOT NULL,
	[df_pruser4] [nvarchar](60) NOT NULL,
	[df_invcost] [nvarchar](30) NOT NULL,
	[df_deposit] [int] NOT NULL,
	[df_payment] [int] NOT NULL,
	[df_ar] [int] NOT NULL,
	[df_ap] [int] NOT NULL,
	[df_purdis] [int] NOT NULL,
	[df_saledis] [int] NOT NULL,
	[df_souser1] [nvarchar](60) NOT NULL,
	[df_souser2] [nvarchar](60) NOT NULL,
	[df_invadj] [int] NOT NULL,
	[df_wipinv] [int] NOT NULL,
	[df_wippur] [int] NOT NULL,
	[df_wiplab] [int] NOT NULL,
	[df_wipmach] [int] NOT NULL,
	[df_closed] [datetime] NULL,
	[df_supclos] [datetime] NULL,
	[df_stocked] [nvarchar](24) NOT NULL,
	[df_control] [nvarchar](60) NOT NULL,
	[df_payroll] [int] NOT NULL,
	[df_adjmax] [numeric](10, 0) NOT NULL,
	[df_adjacct] [int] NOT NULL,
	[df_neginv] [nvarchar](20) NOT NULL,
	[df_matexp] [int] NOT NULL,
	[df_pricdec] [numeric](1, 0) NOT NULL,
	[df_quandec] [numeric](1, 0) NOT NULL,
	[df_pastday] [numeric](10, 0) NOT NULL,
	[df_paytype] [nvarchar](60) NOT NULL,
	[df_payfor] [nvarchar](60) NOT NULL,
	[df_acctend] [datetime] NULL,
	[df_saledec] [numeric](1, 0) NOT NULL,
	[df_puradj] [int] NOT NULL,
	[df_cashsal] [int] NOT NULL,
	[df_headjob] [bit] NOT NULL,
	[df_frtprod] [int] NOT NULL,
	[df_wipjob] [bit] NOT NULL,
	[df_syncjob] [bit] NOT NULL,
	[df_purtype] [nvarchar](60) NOT NULL,
	[df_serprod] [int] NOT NULL,
	[df_backjob] [bit] NOT NULL,
	[df_burden] [numeric](4, 0) NOT NULL,
	[df_pricord] [nvarchar](20) NOT NULL,
	[df_crewop] [int] NOT NULL,
	[df_crewcen] [numeric](10, 0) NOT NULL,
	[df_serterm] [int] NOT NULL,
	[df_porem] [bit] NOT NULL,
	[df_sorem] [bit] NOT NULL,
	[df_taxid] [nvarchar](30) NOT NULL,
	[df_crewpro] [bit] NOT NULL,
	[df_co1] [nvarchar](60) NOT NULL,
	[df_co2] [nvarchar](60) NOT NULL,
	[df_co3] [nvarchar](60) NOT NULL,
	[df_co4] [nvarchar](60) NOT NULL,
	[df_co5] [nvarchar](60) NOT NULL,
	[df_finmat] [int] NOT NULL,
	[df_finlab] [int] NOT NULL,
	[df_finbur] [int] NOT NULL,
	[df_maxso1] [numeric](12, 0) NOT NULL,
	[df_maxso2] [numeric](12, 0) NOT NULL,
	[df_maxso3] [numeric](12, 0) NOT NULL,
	[df_maxpo1] [numeric](12, 0) NOT NULL,
	[df_maxpo2] [numeric](12, 0) NOT NULL,
	[df_maxpo3] [numeric](12, 0) NOT NULL,
	[df_defbill] [int] NOT NULL,
	[df_shipin] [int] NOT NULL,
	[df_prepay] [int] NOT NULL,
	[df_souser3] [nvarchar](60) NOT NULL,
	[df_xfer] [int] NOT NULL,
	[df_pouser1] [nvarchar](60) NOT NULL,
	[df_pouser2] [nvarchar](60) NOT NULL,
	[df_pouser3] [nvarchar](60) NOT NULL,
	[df_pouser4] [nvarchar](60) NOT NULL,
	[df_defgain] [int] NOT NULL,
	[df_batyld] [nvarchar](60) NOT NULL,
	[df_soback] [bit] NOT NULL,
	[df_poback] [bit] NOT NULL,
	[df_matbur] [int] NOT NULL,
	[df_souser4] [nvarchar](60) NOT NULL,
	[df_souser5] [nvarchar](60) NOT NULL,
	[df_ordlen] [numeric](1, 0) NOT NULL,
	[df_sotype] [nvarchar](2) NOT NULL,
	[df_potype] [nvarchar](2) NOT NULL,
	[df_bomtype] [nvarchar](60) NOT NULL,
	[df_port] [numeric](1, 0) NOT NULL,
	[df_freqa] [int] NOT NULL,
	[df_freqb] [int] NOT NULL,
	[df_freqc] [int] NOT NULL,
	[df_freqd] [int] NOT NULL,
	[df_freqweek] [numeric](2, 0) NOT NULL,
	[df_phasejob] [bit] NOT NULL,
	[df_invgain] [int] NOT NULL,
	[df_daysales] [int] NOT NULL,
	[df_payprod] [int] NOT NULL,
	[df_taxdate] [nvarchar](60) NOT NULL,
	[df_socal1] [nvarchar](60) NOT NULL,
	[df_socal2] [nvarchar](60) NOT NULL,
	[df_socal3] [nvarchar](60) NOT NULL,
	[df_socal4] [nvarchar](60) NOT NULL,
	[df_socal5] [nvarchar](60) NOT NULL,
	[df_jobcal1] [nvarchar](60) NOT NULL,
	[df_jobcal2] [nvarchar](60) NOT NULL,
	[df_jobcal3] [nvarchar](60) NOT NULL,
	[df_jobcal4] [nvarchar](60) NOT NULL,
	[df_jobcal5] [nvarchar](60) NOT NULL,
	[df_pruser5] [nvarchar](60) NOT NULL,
	[df_pruser6] [nvarchar](60) NOT NULL,
	[df_co6] [nvarchar](60) NOT NULL,
	[df_co7] [nvarchar](60) NOT NULL,
	[df_co8] [nvarchar](60) NOT NULL,
	[df_co9] [nvarchar](60) NOT NULL,
	[df_co10] [nvarchar](60) NOT NULL,
	[df_schedunit] [numeric](10, 0) NOT NULL,
	[df_scheduni2] [numeric](10, 0) NOT NULL,
	[df_purlev] [numeric](10, 0) NOT NULL,
	[df_tranvar] [int] NOT NULL,
	[df_loadcalc1] [nvarchar](120) NOT NULL,
	[df_loadcalc2] [nvarchar](120) NOT NULL,
	[df_loadcalc3] [nvarchar](120) NOT NULL,
	[df_burcalc] [nvarchar](120) NOT NULL,
	[df_matburcalc] [nvarchar](120) NOT NULL,
	[df_kitpart] [nvarchar](max) NOT NULL,
	[df_excelfooter] [nvarchar](max) NOT NULL,
	[df_currgain] [int] NOT NULL,
	[df_autoinv] [bit] NOT NULL,
	[df_schedcaid] [int] NOT NULL,
	[df_schedcai2] [int] NOT NULL,
	[df_invdest] [nvarchar](60) NOT NULL,
	[df_statedest] [nvarchar](60) NOT NULL,
	[df_reggain] [int] NOT NULL,
	[df_sorep1] [nvarchar](60) NOT NULL,
	[df_sorep2] [nvarchar](60) NOT NULL,
	[df_sorep3] [nvarchar](60) NOT NULL,
	[df_sorep4] [nvarchar](60) NOT NULL,
	[df_sorep5] [nvarchar](60) NOT NULL,
	[df_sorep6] [nvarchar](60) NOT NULL,
	[df_sorep7] [nvarchar](60) NOT NULL,
	[df_sorep8] [nvarchar](60) NOT NULL,
	[df_sorep9] [nvarchar](60) NOT NULL,
	[df_sorep10] [nvarchar](60) NOT NULL,
	[df_taxdisc] [bit] NOT NULL,
	[df_exclcash] [bit] NOT NULL,
	[df_payterm] [int] NOT NULL,
	[df_jobsort1] [nvarchar](60) NOT NULL,
	[df_jobsort2] [nvarchar](60) NOT NULL,
	[df_jobsort3] [nvarchar](60) NOT NULL,
	[df_sosort1] [nvarchar](60) NOT NULL,
	[df_sosort2] [nvarchar](60) NOT NULL,
	[df_sosort3] [nvarchar](60) NOT NULL,
	[df_pruser7] [nvarchar](60) NOT NULL,
	[df_pruser8] [nvarchar](60) NOT NULL,
	[df_pruser9] [nvarchar](60) NOT NULL,
	[df_sowantcalc] [nvarchar](max) NOT NULL,
	[df_sopromcalc] [nvarchar](max) NOT NULL,
	[df_soduecalc] [nvarchar](max) NOT NULL,
	[df_soconfcalc] [nvarchar](max) NOT NULL,
	[df_sorelcalc] [nvarchar](max) NOT NULL,
	[df_soexpcalc] [nvarchar](max) NOT NULL,
	[df_drawport] [numeric](1, 0) NOT NULL,
	[df_drawcmd] [nvarchar](max) NOT NULL,
	[df_sodate1] [nvarchar](60) NOT NULL,
	[df_sodate2] [nvarchar](60) NOT NULL,
	[df_sodate3] [nvarchar](60) NOT NULL,
	[df_sodate4] [nvarchar](60) NOT NULL,
	[df_sodate5] [nvarchar](60) NOT NULL,
	[df_porep1] [nvarchar](60) NOT NULL,
	[df_porep2] [nvarchar](60) NOT NULL,
	[df_porep3] [nvarchar](60) NOT NULL,
	[df_porep4] [nvarchar](60) NOT NULL,
	[df_porep5] [nvarchar](60) NOT NULL,
	[df_porep6] [nvarchar](60) NOT NULL,
	[df_porep7] [nvarchar](60) NOT NULL,
	[df_porep8] [nvarchar](60) NOT NULL,
	[df_porep9] [nvarchar](60) NOT NULL,
	[df_porep10] [nvarchar](60) NOT NULL,
	[df_prepaypo] [int] NOT NULL,
	[df_logoimg] [varbinary](max) NULL,
	[df_logoname] [nvarchar](120) NOT NULL,
	[df_xfertype] [nvarchar](2) NOT NULL,
	[df_fontname] [nvarchar](60) NOT NULL,
	[df_fontsize] [int] NOT NULL,
	[df_wordwrap] [bit] NOT NULL,
	[df_sermin] [numeric](12, 2) NOT NULL,
	[df_finrep1] [nvarchar](60) NOT NULL,
	[df_finrep2] [nvarchar](60) NOT NULL,
	[df_finrep3] [nvarchar](60) NOT NULL,
	[df_finrep4] [nvarchar](60) NOT NULL,
	[df_finrep5] [nvarchar](60) NOT NULL,
	[df_finrep6] [nvarchar](60) NOT NULL,
	[df_scanport] [int] NOT NULL,
	[df_podate1] [nvarchar](60) NOT NULL,
	[df_podate2] [nvarchar](60) NOT NULL,
	[df_podate3] [nvarchar](60) NOT NULL,
	[df_podate4] [nvarchar](60) NOT NULL,
	[df_podate5] [nvarchar](60) NOT NULL,
	[df_joballo] [nvarchar](60) NOT NULL,
	[df_attrib1] [nvarchar](120) NOT NULL,
	[df_attrib2] [nvarchar](120) NOT NULL,
	[df_attrib3] [nvarchar](120) NOT NULL,
	[df_joblot] [nvarchar](max) NOT NULL,
	[df_prodallo] [nvarchar](60) NOT NULL,
	[df_pospaid] [int] NOT NULL,
	[df_joballovar] [numeric](12, 2) NOT NULL,
	[df_jobchk] [nvarchar](60) NOT NULL,
	[df_docdir] [nvarchar](120) NOT NULL,
	[df_frtdisc] [bit] NOT NULL,
	[df_calsizeso] [bit] NOT NULL,
	[df_calsizejob] [bit] NOT NULL,
	[df_elimchid] [int] NOT NULL,
	[df_poprtform] [bit] NOT NULL,
	[df_msdsid] [int] NOT NULL,
	[df_cofaid] [int] NOT NULL,
	[df_joblabid] [int] NOT NULL,
	[df_itemlabid] [int] NOT NULL,
	[df_polabid] [int] NOT NULL,
	[df_solabid] [int] NOT NULL,
	[df_lotlabid] [int] NOT NULL,
	[df_credship] [bit] NOT NULL,
	[df_qcloc] [nvarchar](60) NOT NULL,
	[df_credopenso] [bit] NOT NULL,
	[df_negadj] [int] NOT NULL,
	[df_reljob] [bit] NOT NULL,
	[df_gridrowcolor] [int] NOT NULL,
	[df_rcountry] [nvarchar](60) NOT NULL,
	[df_issuetype] [nvarchar](60) NOT NULL,
	[df_sopricdate] [nvarchar](60) NOT NULL,
	[df_ccid] [int] NOT NULL,
	[df_facprompt] [bit] NOT NULL,
	[df_bomdec] [numeric](1, 0) NOT NULL,
	[df_ssocert] [nvarchar](max) NOT NULL,
	[df_jobdate1calc] [nvarchar](max) NOT NULL,
	[df_jobdate2calc] [nvarchar](max) NOT NULL,
	[df_jobdate3calc] [nvarchar](max) NOT NULL,
	[df_jobdate4calc] [nvarchar](max) NOT NULL,
	[df_jobdate5calc] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxdflt] PRIMARY KEY CLUSTERED 
(
	[df_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxdflt2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxdflt2](
	[df_id] [int] IDENTITY(1,1) NOT NULL,
	[df_poconfcalc] [nvarchar](max) NOT NULL,
	[df_poduecalc] [nvarchar](max) NOT NULL,
	[df_poexpcalc] [nvarchar](max) NOT NULL,
	[df_popromcalc] [nvarchar](max) NOT NULL,
	[df_powantcalc] [nvarchar](max) NOT NULL,
	[df_soprtform] [bit] NOT NULL,
	[df_jobprtform] [bit] NOT NULL,
	[df_jobinclstan] [bit] NOT NULL,
	[df_xfermarkchid] [int] NOT NULL,
	[df_sergen] [nvarchar](60) NOT NULL,
	[df_serexpr] [nvarchar](max) NOT NULL,
	[df_jobqc] [nvarchar](max) NOT NULL,
	[df_jobfg] [nvarchar](max) NOT NULL,
	[df_signature] [nvarchar](max) NOT NULL,
	[df_skipsat] [bit] NOT NULL,
	[df_skipsun] [bit] NOT NULL,
	[df_finrep7] [nvarchar](60) NOT NULL,
	[df_finrep8] [nvarchar](60) NOT NULL,
	[df_finrep9] [nvarchar](60) NOT NULL,
	[df_finrep10] [nvarchar](60) NOT NULL,
	[df_websvrloc] [nvarchar](120) NOT NULL,
	[df_websvrport] [int] NOT NULL,
	[df_gridlines] [bit] NOT NULL,
	[df_webfolder] [nvarchar](120) NOT NULL,
	[df_payacctchid] [int] NOT NULL,
	[df_crossrev] [bit] NOT NULL,
	[df_physlots] [bit] NOT NULL,
	[df_serdays] [int] NOT NULL,
	[df_jobdate1] [nvarchar](60) NOT NULL,
	[df_jobdate2] [nvarchar](60) NOT NULL,
	[df_jobdate3] [nvarchar](60) NOT NULL,
	[df_jobdate4] [nvarchar](60) NOT NULL,
	[df_jobdate5] [nvarchar](60) NOT NULL,
	[df_costbyprod] [nvarchar](60) NOT NULL,
	[df_posuspchid] [int] NOT NULL,
	[df_maxdocsize] [numeric](12, 2) NOT NULL,
	[df_intprod] [int] NOT NULL,
	[df_finrep11] [nvarchar](60) NOT NULL,
	[df_finrep12] [nvarchar](60) NOT NULL,
	[df_finrep13] [nvarchar](60) NOT NULL,
	[df_finrep14] [nvarchar](60) NOT NULL,
	[df_finrep15] [nvarchar](60) NOT NULL,
	[df_maxsodocsize] [numeric](12, 2) NOT NULL,
	[df_salefeat] [nvarchar](max) NOT NULL,
	[df_porecvlimit] [numeric](17, 7) NOT NULL,
	[df_passminlen] [int] NOT NULL,
	[df_passmaxage] [int] NOT NULL,
	[df_passminage] [int] NOT NULL,
	[df_passhistory] [int] NOT NULL,
	[df_passcomplex] [bit] NOT NULL,
	[df_fcdec] [numeric](1, 0) NOT NULL,
	[df_picksortso] [nvarchar](60) NOT NULL,
	[df_picksortjob] [nvarchar](60) NOT NULL,
	[df_picksortprestage] [nvarchar](60) NOT NULL,
	[df_picksortstage] [nvarchar](60) NOT NULL,
	[df_routcal1] [nvarchar](60) NOT NULL,
	[df_routcal2] [nvarchar](60) NOT NULL,
	[df_routcal3] [nvarchar](60) NOT NULL,
	[df_routcal4] [nvarchar](60) NOT NULL,
	[df_routcal5] [nvarchar](60) NOT NULL,
	[df_routsort1] [nvarchar](60) NOT NULL,
	[df_routsort2] [nvarchar](60) NOT NULL,
	[df_routsort3] [nvarchar](60) NOT NULL,
	[df_retainloc] [bit] NOT NULL,
	[df_issueoverlimit] [numeric](17, 7) NOT NULL,
	[df_issuelimitenforce] [bit] NOT NULL,
	[df_porecvlimitenforce] [bit] NOT NULL,
	[df_lotexpr] [nvarchar](max) NOT NULL,
	[df_calwidth] [int] NOT NULL,
	[df_conrep1] [nvarchar](60) NOT NULL,
	[df_conrep2] [nvarchar](60) NOT NULL,
	[df_conrep3] [nvarchar](60) NOT NULL,
	[df_dispport] [int] NOT NULL,
	[df_disptext] [nvarchar](max) NOT NULL,
	[df_postext] [nvarchar](max) NOT NULL,
	[df_companyrss] [nvarchar](400) NOT NULL,
	[df_jobrout] [nvarchar](max) NOT NULL,
	[df_tgmailhost] [nvarchar](120) NOT NULL,
	[df_tgmailport] [int] NOT NULL,
	[df_tgdefcred] [bit] NOT NULL,
	[df_tgcrname] [nvarchar](120) NOT NULL,
	[df_tgcrpass] [nvarchar](400) NOT NULL,
	[df_tgcrdomain] [nvarchar](60) NOT NULL,
	[df_tgsendaddy] [nvarchar](120) NOT NULL,
	[df_domain] [nvarchar](60) NOT NULL,
	[df_porelcalc] [nvarchar](max) NOT NULL,
	[df_lastlogin] [int] NOT NULL,
	[df_poscmdset] [nvarchar](60) NOT NULL,
	[df_regbomtext] [nvarchar](max) NOT NULL,
	[df_poqc] [nvarchar](max) NOT NULL,
	[df_jobtrak] [nvarchar](max) NOT NULL,
	[df_jobschedby] [nvarchar](60) NOT NULL,
	[df_pfmerchant] [nvarchar](60) NOT NULL,
	[df_pfpartner] [nvarchar](60) NOT NULL,
	[df_pfpass] [nvarchar](200) NOT NULL,
	[df_pfuser] [nvarchar](60) NOT NULL,
	[df_pftest] [bit] NOT NULL,
	[df_iphonetimeout] [int] NOT NULL,
	[df_wipbur] [int] NOT NULL,
	[df_paybur] [int] NOT NULL,
	[df_rempass] [bit] NOT NULL,
	[df_posbiid] [int] NOT NULL,
	[df_bomcalc] [nvarchar](22) NOT NULL,
	[df_helpuser] [nvarchar](60) NOT NULL,
	[df_helppass] [nvarchar](200) NOT NULL,
	[df_currcheck] [numeric](4, 0) NOT NULL,
	[df_showzerolines] [bit] NOT NULL,
	[df_finzerodflt] [bit] NOT NULL,
	[df_mrpdec] [numeric](1, 0) NOT NULL,
	[df_bofinish] [int] NOT NULL,
	[df_bostart] [int] NOT NULL,
	[df_jobfg2] [nvarchar](max) NOT NULL,
	[df_issueprintlabel] [bit] NOT NULL,
	[df_sojob] [nvarchar](60) NOT NULL,
	[df_sodockcalc] [nvarchar](max) NOT NULL,
	[df_dsdreceipt] [nvarchar](max) NOT NULL,
	[df_wmschoosergroup] [nvarchar](60) NOT NULL,
	[df_rellabor] [bit] NOT NULL,
	[df_picksortsouser] [nvarchar](max) NOT NULL,
	[df_wipburmaint] [int] NOT NULL,
	[df_wippurmaint] [int] NOT NULL,
	[df_wipinvmaint] [int] NOT NULL,
	[df_wiplabmaint] [int] NOT NULL,
	[df_saleonhand] [nvarchar](60) NOT NULL,
	[df_creddays] [int] NOT NULL,
	[df_lotexpcalc] [nvarchar](max) NOT NULL,
	[df_reworklabor] [bit] NOT NULL,
	[df_authentication] [nvarchar](60) NOT NULL,
	[df_dsdpricevar] [numeric](10, 7) NOT NULL,
	[df_prevlotx] [bit] NOT NULL,
	[df_wmschooserqcstatus] [nvarchar](60) NOT NULL,
	[df_wmschooseritemtype] [nvarchar](60) NOT NULL,
	[df_linkemailctid] [int] NOT NULL,
	[df_linkemailmins] [int] NOT NULL,
	[df_uslinkemail] [bit] NOT NULL,
	[df_cplinkemail] [bit] NOT NULL,
	[df_dockcal1] [nvarchar](60) NOT NULL,
	[df_dockcal2] [nvarchar](60) NOT NULL,
	[df_dockcal3] [nvarchar](60) NOT NULL,
	[df_dockcal4] [nvarchar](60) NOT NULL,
	[df_dockcal5] [nvarchar](60) NOT NULL,
	[df_docksort1] [nvarchar](60) NOT NULL,
	[df_docksort2] [nvarchar](60) NOT NULL,
	[df_docksort3] [nvarchar](60) NOT NULL,
	[df_zerocatchweight] [bit] NOT NULL,
	[df_printnone] [bit] NOT NULL,
	[df_shipquan] [nvarchar](60) NOT NULL,
	[df_packexp] [nvarchar](max) NOT NULL,
	[df_valutecclientid] [nvarchar](120) NOT NULL,
	[df_valutecterminalid] [nvarchar](60) NOT NULL,
	[df_dsdpricetype] [nvarchar](max) NOT NULL,
	[df_shortship] [nvarchar](60) NOT NULL,
	[df_formqcexp] [nvarchar](max) NOT NULL,
	[df_shipview] [nvarchar](60) NOT NULL,
	[df_wmsfieldlim] [int] NOT NULL,
	[df_sumissuedlots] [bit] NOT NULL,
	[df_dsdarchrec] [bit] NOT NULL,
	[df_useentirelot] [bit] NOT NULL,
	[df_wmssugglot] [nvarchar](60) NOT NULL,
	[df_fedacc] [nvarchar](max) NOT NULL,
	[df_fedpass] [nvarchar](max) NOT NULL,
	[df_fedauth] [nvarchar](max) NOT NULL,
	[df_fedshipacc] [nvarchar](max) NOT NULL,
	[df_fedmeternum] [nvarchar](max) NOT NULL,
	[df_remmlot] [bit] NOT NULL,
	[df_fedtest] [bit] NOT NULL,
	[df_fedalwaysgenlabel] [bit] NOT NULL,
	[df_fedpollmins] [int] NOT NULL,
	[df_cogsvariance] [int] NOT NULL,
	[df_showchooser] [nvarchar](60) NOT NULL,
	[df_purlen] [numeric](1, 0) NOT NULL,
	[df_fedgenshiplabel] [nvarchar](max) NOT NULL,
	[df_explodephantoms] [bit] NOT NULL,
	[df_wmsfilterto] [nvarchar](60) NOT NULL,
	[df_dsdvartype] [nvarchar](60) NOT NULL,
	[df_readweight] [bit] NOT NULL,
	[df_wmsautoselectloc] [bit] NOT NULL,
	[df_workeract2] [nvarchar](60) NOT NULL,
	[df_skipfield] [bit] NOT NULL,
	[df_monthjob1] [nvarchar](60) NOT NULL,
	[df_monthjob2] [nvarchar](60) NOT NULL,
	[df_monthjob3] [nvarchar](60) NOT NULL,
	[df_tempcapex] [nvarchar](max) NOT NULL,
	[df_resmlot] [bit] NOT NULL,
	[df_autofinlayout] [nvarchar](60) NOT NULL,
	[df_somrppref] [int] NOT NULL,
	[df_jobmrpprefilter] [int] NOT NULL,
	[df_jobmrppref] [int] NOT NULL,
	[df_somrpprefilter] [int] NOT NULL,
	[df_invzeroso] [bit] NOT NULL,
	[df_commaccr] [int] NOT NULL,
	[df_commexp] [int] NOT NULL,
	[df_wmschoosersort] [nvarchar](60) NOT NULL,
	[df_salstag] [int] NOT NULL,
	[df_sobocalcs] [bit] NOT NULL,
	[df_wmsprtv15] [bit] NOT NULL,
	[df_acctbal] [nvarchar](60) NOT NULL,
	[df_defissquan] [int] NOT NULL,
	[df_purlotexp] [nvarchar](max) NOT NULL,
	[df_invso] [nvarchar](60) NOT NULL,
	[df_exstag] [bit] NOT NULL,
	[df_stagscan] [bit] NOT NULL,
	[df_bommrppref] [int] NOT NULL,
	[df_bommrpprefilter] [int] NOT NULL,
	[df_autofinoffline] [bit] NOT NULL,
	[df_stagweigh] [bit] NOT NULL,
	[df_autoaltwgtfield] [nvarchar](60) NOT NULL,
	[df_nothingissuedprompt] [bit] NOT NULL,
	[df_autofingridsize] [int] NOT NULL,
	[df_somrpshowall] [nvarchar](60) NOT NULL,
	[df_jobmrpshowall] [nvarchar](60) NOT NULL,
	[df_wmssuggby] [nvarchar](60) NOT NULL,
	[df_emvexpr] [nvarchar](max) NOT NULL,
	[df_dsdsynstat] [nvarchar](60) NOT NULL,
	[df_genmasterlot] [bit] NOT NULL,
	[df_deissueprintlabel] [bit] NOT NULL,
	[df_aflbl] [nvarchar](10) NOT NULL,
	[df_addfedexfreight] [bit] NOT NULL,
	[df_defmrpordtype] [nvarchar](2) NOT NULL,
	[df_masterlotwgt] [bit] NOT NULL,
	[df_syncorderdates] [bit] NOT NULL,
	[df_jobstage] [int] NOT NULL,
	[df_docresolution] [int] NOT NULL,
	[df_remitid] [nvarchar](60) NOT NULL,
	[df_depexpensechid] [int] NOT NULL,
	[df_inputprodclear] [nvarchar](60) NOT NULL,
	[df_jobchktype] [nvarchar](60) NOT NULL,
	[df_soprtsub] [nvarchar](60) NOT NULL,
	[df_allowjobcaldragpriority] [bit] NOT NULL,
	[df_allowsocaldragpriority] [bit] NOT NULL,
	[df_jotype] [nvarchar](2) NOT NULL,
	[df_dsdinvoice] [bit] NOT NULL,
	[df_optimschedby] [nvarchar](60) NOT NULL,
	[df_printsolabel] [bit] NOT NULL,
	[df_printjoblabel] [bit] NOT NULL,
	[df_autofingroup] [nvarchar](60) NOT NULL,
	[df_promptpoblanket] [bit] NOT NULL,
	[df_code128asgs1128] [bit] NOT NULL,
	[df_crmavailablefor] [nvarchar](max) NOT NULL,
	[df_emvtimeout] [int] NOT NULL,
	[df_picklistfacility] [int] NOT NULL,
	[df_reqqcgrpesig] [bit] NOT NULL,
	[df_verboseemv] [bit] NOT NULL,
	[df_crossrevict] [bit] NOT NULL,
	[df_upsacc] [nvarchar](200) NOT NULL,
	[df_upspass] [nvarchar](510) NOT NULL,
	[df_upsauth] [nvarchar](510) NOT NULL,
	[df_recquan] [nvarchar](60) NOT NULL,
	[df_upsshipnum] [nvarchar](510) NOT NULL,
	[df_lotpriority] [nvarchar](60) NOT NULL,
	[df_prefillwms] [bit] NOT NULL,
	[df_upstest] [bit] NOT NULL,
	[df_enforcebarcode] [nvarchar](60) NOT NULL,
	[df_uspsacc] [nvarchar](200) NOT NULL,
	[df_uspstest] [bit] NOT NULL,
 CONSTRAINT [PK_dxdflt2] PRIMARY KEY CLUSTERED 
(
	[df_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxdflt3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxdflt3](
	[df_id] [int] IDENTITY(1,1) NOT NULL,
	[df_jobonhand] [nvarchar](60) NOT NULL,
	[df_sumregbom] [bit] NOT NULL,
	[df_posdec] [numeric](17, 7) NOT NULL,
	[df_template] [nvarchar](60) NOT NULL,
	[df_icxstag] [int] NOT NULL,
	[df_availview] [nvarchar](60) NOT NULL,
	[df_availzeroitems] [nvarchar](60) NOT NULL,
	[df_includemlonpl] [bit] NOT NULL,
	[df_prodcostexp] [nvarchar](max) NOT NULL,
	[df_pdfxmargin] [int] NOT NULL,
	[df_pdfymargin] [int] NOT NULL,
	[df_lotchooserselect] [nvarchar](60) NOT NULL,
	[df_definqty] [nvarchar](120) NOT NULL,
	[df_movelotbalance] [bit] NOT NULL,
	[df_xfercostexp] [nvarchar](max) NOT NULL,
	[df_passpromptdays] [int] NOT NULL,
	[df_pohlinkprompt] [bit] NOT NULL,
	[df_tjkey] [nvarchar](400) NOT NULL,
	[df_saletaxchid] [int] NOT NULL,
	[df_issueunderlimit] [numeric](17, 7) NOT NULL,
	[df_issueunderenforce] [bit] NOT NULL,
	[df_prestageinv] [nvarchar](60) NOT NULL,
	[df_tjname] [nvarchar](120) NOT NULL,
	[df_tjsync] [bit] NOT NULL,
	[df_jobfinbl] [bit] NOT NULL,
	[df_atriskimp] [nvarchar](60) NOT NULL,
	[df_qcfreqlottype] [nvarchar](60) NOT NULL,
	[df_stagprtml] [bit] NOT NULL,
	[df_joblen] [int] NOT NULL,
	[df_syncjobdates] [bit] NOT NULL,
	[df_jobbomtrak] [nvarchar](max) NOT NULL,
	[df_useanysyslot] [nvarchar](60) NOT NULL,
	[df_otchid] [int] NOT NULL,
	[df_remsettings] [nvarchar](60) NOT NULL,
	[df_chid] [int] NOT NULL,
	[df_jitcalc] [nvarchar](60) NOT NULL,
	[df_wmspartsearchorder] [nvarchar](60) NOT NULL,
	[df_tarecatch] [bit] NOT NULL,
	[df_contsergen] [nvarchar](60) NOT NULL,
	[df_contserexpr] [nvarchar](max) NOT NULL,
	[df_wmslocsearchorder] [nvarchar](60) NOT NULL,
	[df_dirputaway] [bit] NOT NULL,
	[df_otexpression] [nvarchar](max) NOT NULL,
	[df_otstartofweek] [nvarchar](60) NOT NULL,
	[df_scanpartsforpckgs] [bit] NOT NULL,
	[df_autovalidaddress] [bit] NOT NULL,
	[df_dfltvalidtype] [nvarchar](40) NOT NULL,
	[df_qcparentinfo] [bit] NOT NULL,
	[df_copypromoprid] [int] NOT NULL,
	[df_wmsloctypedelay] [int] NOT NULL,
	[df_autopalletize] [bit] NOT NULL,
	[df_staginggroupby] [bit] NOT NULL,
	[df_taxtype] [nvarchar](120) NOT NULL,
	[df_taxuser] [nvarchar](120) NOT NULL,
	[df_taxpass] [nvarchar](max) NOT NULL,
	[df_whitelistauth] [bit] NOT NULL,
	[df_emailauth] [bit] NOT NULL,
	[df_secquestionauth] [bit] NOT NULL,
	[df_secquestions] [int] NOT NULL,
	[df_emailcodemins] [int] NOT NULL,
	[df_reservetype] [nvarchar](60) NOT NULL,
	[df_postburden] [nvarchar](60) NOT NULL,
	[df_otexpense] [nvarchar](60) NOT NULL,
	[df_suppressinvprompt] [bit] NOT NULL,
	[df_easypostapikey] [nvarchar](400) NOT NULL,
	[df_incstagingondocs] [bit] NOT NULL,
	[df_poacashchid] [int] NOT NULL,
	[df_splitpayrolltime] [bit] NOT NULL,
	[df_copylinktoso] [bit] NOT NULL,
	[df_expreng] [nvarchar](60) NOT NULL,
	[df_uniqueupc] [bit] NOT NULL,
	[df_pricingprefilter] [int] NOT NULL,
	[df_popricdate] [nvarchar](30) NOT NULL,
	[df_masterlotgen] [nvarchar](60) NOT NULL,
	[df_masterlotexp] [nvarchar](max) NOT NULL,
	[df_masterorderprid] [int] NOT NULL,
	[df_scalecustomadds] [bit] NOT NULL,
	[df_trackeruser] [nvarchar](120) NOT NULL,
	[df_trackerpass] [nvarchar](400) NOT NULL,
	[df_rssdays] [int] NOT NULL,
	[df_giftcardprid] [int] NOT NULL,
	[df_singleapp] [bit] NOT NULL,
	[df_byproductyield] [bit] NOT NULL,
	[df_dfltshiptoprompt] [bit] NOT NULL,
	[df_outlookemail] [bit] NOT NULL,
	[df_qcpendmoverev] [nvarchar](60) NOT NULL,
	[df_excelgridfooter] [nvarchar](max) NOT NULL,
	[df_xfacmarkchid] [int] NOT NULL,
	[df_popayacctchid] [int] NOT NULL,
	[df_defstagequan] [nvarchar](60) NOT NULL,
	[df_taxsandboxmode] [bit] NOT NULL,
	[df_giftcardgen] [nvarchar](60) NOT NULL,
	[df_posordtype] [nvarchar](60) NOT NULL,
	[df_prestagemasterlots] [bit] NOT NULL,
	[df_ldapdomain] [nvarchar](200) NOT NULL,
	[df_custinvexcess] [bit] NOT NULL,
	[df_autoissuecontents] [bit] NOT NULL,
	[df_linkedsoworkflowcolor] [nvarchar](60) NOT NULL,
	[df_shippingscript] [nvarchar](max) NOT NULL,
	[df_syncjobquant] [bit] NOT NULL,
	[df_giftcardexp] [nvarchar](max) NOT NULL,
	[df_singlejoblogon] [bit] NOT NULL,
	[df_backflushcatchwgt] [bit] NOT NULL,
	[df_outlookauthtype] [nvarchar](12) NOT NULL,
	[df_outlookappid] [nvarchar](508) NOT NULL,
	[df_outlooktenantid] [nvarchar](508) NOT NULL,
	[df_outlooksecret] [nvarchar](254) NOT NULL,
	[df_issueview] [nvarchar](60) NOT NULL,
	[df_dfltcrmbiid] [int] NOT NULL,
	[df_dfltcrmshid] [int] NOT NULL,
	[df_savepackageshipped3] [bit] NOT NULL,
	[df_printername] [nvarchar](60) NOT NULL,
	[df_labcostexp] [nvarchar](max) NOT NULL,
	[df_popriceordselect] [nvarchar](60) NOT NULL,
	[df_useshiptoterms] [bit] NOT NULL,
	[df_pricinglinedates] [bit] NOT NULL,
	[df_finalstageclear] [nvarchar](60) NOT NULL,
	[df_prefillnextwms] [nvarchar](60) NOT NULL,
	[df_workshift] [bit] NOT NULL,
	[df_recalcpoprices] [bit] NOT NULL,
	[df_inclccauthcredit] [bit] NOT NULL,
	[df_promptsopricing] [bit] NOT NULL,
	[df_customerlotexp] [nvarchar](max) NOT NULL,
	[df_attribdelim] [nvarchar](2) NOT NULL,
	[df_taxexemptapis] [bit] NOT NULL,
	[df_vattaxid] [nvarchar](60) NOT NULL,
	[df_currencyratebank] [nvarchar](120) NOT NULL,
	[df_jobchktypefinish] [bit] NOT NULL,
	[df_removecustinv] [nvarchar](60) NOT NULL,
	[df_recalcpriceon] [nvarchar](60) NOT NULL,
	[df_recalcusercalcson] [nvarchar](60) NOT NULL,
	[df_recalcpromoson] [nvarchar](60) NOT NULL,
	[df_taxcompcode] [nvarchar](120) NOT NULL,
	[df_inputdirectstaging] [bit] NOT NULL,
	[df_freightinprid] [int] NOT NULL,
	[df_applytaxonicxfer] [bit] NOT NULL,
	[df_costcoprod] [bit] NOT NULL,
	[df_brokaccr] [int] NOT NULL,
	[df_excelpassword] [bit] NOT NULL,
	[df_dsdtemplatesync] [bit] NOT NULL,
	[df_costrollup] [nvarchar](60) NOT NULL,
	[df_showzerolinesreserve] [bit] NOT NULL,
	[df_printqcbygroup] [bit] NOT NULL,
	[df_maxcheckdetails] [int] NOT NULL,
	[df_credshiphold] [bit] NOT NULL,
	[df_returnlinkedsolots] [bit] NOT NULL,
	[df_sosortexpr] [nvarchar](max) NOT NULL,
	[df_sogroupexpr] [nvarchar](max) NOT NULL,
	[df_jourdescriptype] [nvarchar](30) NOT NULL,
	[df_allowablefiletypes] [nvarchar](max) NOT NULL,
	[df_enforceseqstaging] [bit] NOT NULL,
	[df_memofontname] [nvarchar](30) NOT NULL,
	[df_memofontsize] [int] NOT NULL,
	[df_coagrouping] [nvarchar](30) NOT NULL,
	[df_reservemultipleusers] [bit] NOT NULL,
	[df_receiveictmultipleusers] [bit] NOT NULL,
	[df_receivemultipleusers] [bit] NOT NULL,
	[df_cancelbackordpo] [bit] NOT NULL,
	[df_committaxtransactions] [bit] NOT NULL,
	[df_taxclientlogging] [bit] NOT NULL,
	[df_unavailopid] [int] NOT NULL,
	[df_filterrestrictedselling] [bit] NOT NULL,
	[df_dropshipordtype] [nvarchar](30) NOT NULL,
	[df_poinvadjust] [bit] NOT NULL,
	[df_autoreceivefreightpo] [bit] NOT NULL,
	[df_triggeroutlookauthtype] [nvarchar](6) NOT NULL,
	[df_triggeroutlookappid] [nvarchar](254) NOT NULL,
	[df_triggeroutlooktenantid] [nvarchar](254) NOT NULL,
	[df_triggeroutlooksecret] [nvarchar](254) NOT NULL,
	[df_posprintcopies] [bit] NOT NULL,
	[df_promptcopynewlinkedso] [bit] NOT NULL,
	[df_fedacclegacy] [nvarchar](max) NOT NULL,
	[df_fedpasslegacy] [nvarchar](max) NOT NULL,
	[df_fedauthlegacy] [nvarchar](max) NOT NULL,
	[df_fedshipacclegacy] [nvarchar](max) NOT NULL,
	[df_fedmeternumlegacy] [nvarchar](max) NOT NULL,
	[df_recalcjobcalcs] [bit] NOT NULL,
	[df_ssoappid] [nvarchar](max) NOT NULL,
	[df_ssourl] [nvarchar](max) NOT NULL,
	[df_singlesignon] [nvarchar](60) NOT NULL,
	[df_ssoauthmethod] [nvarchar](60) NOT NULL,
	[df_sopricescript] [nvarchar](max) NOT NULL,
	[df_popricescript] [nvarchar](max) NOT NULL,
	[df_numberpass] [bit] NOT NULL,
	[df_specialcharpass] [bit] NOT NULL,
	[df_uppercasepass] [bit] NOT NULL,
	[df_promisecalc] [nvarchar](30) NOT NULL,
	[df_recorddochistory] [bit] NOT NULL,
	[df_purtaxchid] [int] NOT NULL,
	[df_searchall] [bit] NOT NULL,
	[df_searchcontains] [bit] NOT NULL,
	[df_allowabledatafilepaths] [nvarchar](max) NOT NULL,
	[df_wmsrecordbutton] [nvarchar](30) NOT NULL,
	[df_wmsrecordkeycode] [nvarchar](30) NOT NULL,
	[df_wmsshowrecordbutton] [nvarchar](30) NOT NULL,
	[df_requireqcatrisk] [bit] NOT NULL,
	[df_overcredoverride] [bit] NOT NULL,
	[df_allowshifting] [bit] NOT NULL,
	[df_multiuserqc] [bit] NOT NULL,
	[df_reqqcaftermove] [bit] NOT NULL,
 CONSTRAINT [PK_dxdflt3] PRIMARY KEY CLUSTERED 
(
	[df_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxecommsync]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxecommsync](
	[es_id] [int] IDENTITY(1,1) NOT NULL,
	[es_table] [nvarchar](60) NOT NULL,
	[es_date] [datetime] NULL,
	[es_time] [nvarchar](8) NOT NULL,
	[es_csid] [int] NOT NULL,
 CONSTRAINT [PK_dxecommsync] PRIMARY KEY CLUSTERED 
(
	[es_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxedihist]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxedihist](
	[eh_id] [int] IDENTITY(1,1) NOT NULL,
	[eh_edid] [int] NOT NULL,
	[eh_file] [nvarchar](254) NOT NULL,
	[eh_msg] [nvarchar](max) NOT NULL,
	[eh_date] [datetime] NULL,
	[eh_time] [nvarchar](8) NOT NULL,
	[eh_outcome] [nvarchar](30) NOT NULL,
	[eh_orders] [nvarchar](max) NOT NULL,
	[eh_line] [int] NOT NULL,
	[eh_hash] [int] NOT NULL,
 CONSTRAINT [PK_dxedihist] PRIMARY KEY CLUSTERED 
(
	[eh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxextern]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxextern](
	[ex_id] [int] IDENTITY(1,1) NOT NULL,
	[ex_name] [nvarchar](60) NOT NULL,
	[ex_program] [nvarchar](30) NOT NULL,
	[ex_private] [bit] NOT NULL,
	[ex_plugin] [bit] NOT NULL,
	[ex_trigger] [bit] NOT NULL,
	[ex_type] [nvarchar](30) NOT NULL,
	[ex_script] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxextern] PRIMARY KEY CLUSTERED 
(
	[ex_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxexternhist]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxexternhist](
	[xh_id] [int] IDENTITY(1,1) NOT NULL,
	[xh_date] [datetime] NULL,
	[xh_exid] [int] NOT NULL,
	[xh_usid] [int] NOT NULL,
	[xh_time] [nvarchar](8) NOT NULL,
	[xh_message] [nvarchar](max) NOT NULL,
	[xh_recid] [numeric](12, 7) NOT NULL,
	[xh_stack] [nvarchar](max) NOT NULL,
	[xh_table] [nvarchar](20) NOT NULL,
	[xh_level] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dxexternhist] PRIMARY KEY CLUSTERED 
(
	[xh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxfav]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxfav](
	[fv_id] [int] IDENTITY(1,1) NOT NULL,
	[fv_usid] [int] NOT NULL,
	[fv_caption] [nvarchar](60) NOT NULL,
	[fv_seq] [int] NOT NULL,
	[fv_dashboard] [bit] NOT NULL,
	[fv_sysname] [nvarchar](60) NOT NULL,
	[fv_interval] [int] NOT NULL,
	[fv_preview] [bit] NOT NULL,
	[fv_d2id] [int] NOT NULL,
	[fv_copied] [bit] NOT NULL,
	[fv_height] [int] NOT NULL,
	[fv_minimized] [bit] NOT NULL,
	[fv_autolaunch] [bit] NOT NULL,
 CONSTRAINT [PK_dxfav] PRIMARY KEY CLUSTERED 
(
	[fv_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxgridhist]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxgridhist](
	[gh_id] [int] IDENTITY(1,1) NOT NULL,
	[gh_brid] [int] NOT NULL,
	[gh_action] [nvarchar](30) NOT NULL,
	[gh_date] [datetime] NULL,
	[gh_usid] [int] NOT NULL,
	[gh_reccount] [int] NOT NULL,
	[gh_filter] [nvarchar](max) NOT NULL,
	[gh_time] [numeric](4, 0) NOT NULL,
 CONSTRAINT [PK_dxgridhist] PRIMARY KEY CLUSTERED 
(
	[gh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dximphist]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dximphist](
	[ih_id] [int] IDENTITY(1,1) NOT NULL,
	[ih_date] [datetime] NULL,
	[ih_time] [nvarchar](8) NOT NULL,
	[ih_descrip] [nvarchar](30) NOT NULL,
	[ih_file] [nvarchar](max) NOT NULL,
	[ih_table] [nvarchar](30) NOT NULL,
	[ih_imid] [int] NOT NULL,
	[ih_usid] [int] NOT NULL,
	[ih_dur] [numeric](12, 2) NOT NULL,
 CONSTRAINT [PK_dximphist] PRIMARY KEY CLUSTERED 
(
	[ih_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxin]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxin](
	[in_usid] [int] NOT NULL,
	[in_id] [int] IDENTITY(1,1) NOT NULL,
	[in_mainapp] [numeric](10, 0) NOT NULL,
	[in_cashreg] [numeric](10, 0) NOT NULL,
	[in_wms] [numeric](10, 0) NOT NULL,
	[in_mobile] [numeric](10, 0) NOT NULL,
	[in_dsd] [numeric](10, 0) NOT NULL,
	[in_tracker] [numeric](10, 0) NOT NULL,
	[in_ecommerce] [nvarchar](60) NOT NULL,
	[in_uaid] [int] NOT NULL,
 CONSTRAINT [PK_dxin] PRIMARY KEY CLUSTERED 
(
	[in_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxintegrationlogging]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxintegrationlogging](
	[il_id] [int] IDENTITY(1,1) NOT NULL,
	[il_application] [nvarchar](60) NOT NULL,
	[il_date] [datetime] NULL,
	[il_time] [numeric](4, 0) NOT NULL,
	[il_returned] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxintegrationlogging] PRIMARY KEY CLUSTERED 
(
	[il_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxlinkdochist]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxlinkdochist](
	[dh_id] [int] IDENTITY(1,1) NOT NULL,
	[dh_date] [datetime] NULL,
	[dh_msg] [nvarchar](max) NOT NULL,
	[dh_time] [nvarchar](8) NOT NULL,
	[dh_outcome] [nvarchar](30) NOT NULL,
	[dh_file] [nvarchar](254) NOT NULL,
	[dh_liid] [int] NOT NULL,
 CONSTRAINT [PK_dxlinkdochist] PRIMARY KEY CLUSTERED 
(
	[dh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxlog]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxlog](
	[lo_usid] [int] NOT NULL,
	[lo_date] [datetime] NULL,
	[lo_time] [nvarchar](8) NOT NULL,
	[lo_recid] [nvarchar](15) NOT NULL,
	[lo_table] [nvarchar](20) NOT NULL,
	[lo_id] [int] IDENTITY(1,1) NOT NULL,
	[lo_ihid] [int] NOT NULL,
 CONSTRAINT [PK_dxlog] PRIMARY KEY CLUSTERED 
(
	[lo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxmfu]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxmfu](
	[mf_id] [int] IDENTITY(1,1) NOT NULL,
	[mf_usid] [int] NOT NULL,
	[mf_m2id] [int] NOT NULL,
	[mf_day] [datetime] NULL,
	[mf_count] [int] NOT NULL,
	[mf_mtid] [int] NOT NULL,
 CONSTRAINT [PK_dxmfu] PRIMARY KEY CLUSTERED 
(
	[mf_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxmod]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxmod](
	[mo_date] [datetime] NULL,
	[mo_time] [nvarchar](10) NOT NULL,
	[mo_usid] [int] NOT NULL,
	[mo_table] [nvarchar](20) NOT NULL,
	[mo_field] [nvarchar](30) NOT NULL,
	[mo_recid] [numeric](15, 0) NOT NULL,
	[mo_oldval] [nvarchar](60) NOT NULL,
	[mo_newval] [nvarchar](60) NOT NULL,
	[mo_oldmemo] [nvarchar](max) NOT NULL,
	[mo_newmemo] [nvarchar](max) NOT NULL,
	[mo_id] [int] IDENTITY(1,1) NOT NULL,
	[mo_oldid] [int] NOT NULL,
	[mo_newid] [int] NOT NULL,
 CONSTRAINT [PK_dxmod] PRIMARY KEY CLUSTERED 
(
	[mo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxmru]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxmru](
	[mr_id] [int] IDENTITY(1,1) NOT NULL,
	[mr_usid] [int] NOT NULL,
	[mr_lastuse] [datetime] NULL,
	[mr_m2id] [int] NOT NULL,
	[mr_mtid] [int] NOT NULL,
	[mr_m2guid] [uniqueidentifier] NULL,
	[mr_mtguid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dxmru] PRIMARY KEY CLUSTERED 
(
	[mr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxperf]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxperf](
	[pe_id] [int] IDENTITY(1,1) NOT NULL,
	[pe_time] [nvarchar](8) NOT NULL,
	[pe_dur] [numeric](12, 2) NOT NULL,
	[pe_usid] [int] NOT NULL,
	[pe_brid] [int] NOT NULL,
	[pe_date] [datetime] NULL,
	[pe_display] [nvarchar](max) NOT NULL,
	[pe_max] [int] NOT NULL,
 CONSTRAINT [PK_dxperf] PRIMARY KEY CLUSTERED 
(
	[pe_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxping]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxping](
	[pi_id] [int] IDENTITY(1,1) NOT NULL,
	[pi_token] [numeric](10, 0) NOT NULL,
	[pi_pingtime] [datetime] NULL,
	[pi_appsource] [nvarchar](30) NOT NULL,
	[pi_usid] [int] NOT NULL,
 CONSTRAINT [PK_dxping] PRIMARY KEY CLUSTERED 
(
	[pi_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxprefilter]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxprefilter](
	[pr_id] [int] IDENTITY(1,1) NOT NULL,
	[pr_descrip] [nvarchar](30) NOT NULL,
	[pr_name] [nvarchar](30) NOT NULL,
	[pr_usid] [int] NOT NULL,
	[pr_default] [bit] NOT NULL,
	[pr_fiid] [int] NOT NULL,
	[pr_active] [bit] NOT NULL,
 CONSTRAINT [PK_dxprefilter] PRIMARY KEY CLUSTERED 
(
	[pr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxprefilter2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxprefilter2](
	[p2_id] [int] IDENTITY(1,1) NOT NULL,
	[p2_field] [nvarchar](30) NOT NULL,
	[p2_value] [nvarchar](60) NOT NULL,
	[p2_prid] [int] NOT NULL,
	[p2_table] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_dxprefilter2] PRIMARY KEY CLUSTERED 
(
	[p2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxpromptover]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxpromptover](
	[po_id] [int] IDENTITY(1,1) NOT NULL,
	[po_ptid] [int] NOT NULL,
	[po_caid] [int] NOT NULL,
	[po_prompt] [nvarchar](max) NOT NULL,
	[po_ptguid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dxpromptover] PRIMARY KEY CLUSTERED 
(
	[po_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxpset]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxpset](
	[ps_fldname] [nvarchar](20) NOT NULL,
	[ps_number] [numeric](10, 0) NOT NULL,
	[ps_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_dxpset] PRIMARY KEY CLUSTERED 
(
	[ps_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxschedhist]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxschedhist](
	[sc_id] [int] IDENTITY(1,1) NOT NULL,
	[sc_date] [datetime] NULL,
	[sc_isid] [int] NOT NULL,
	[sc_usid] [int] NOT NULL,
	[sc_time] [nvarchar](8) NOT NULL,
	[sc_error] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_dxschedhist] PRIMARY KEY CLUSTERED 
(
	[sc_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxschedperf]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxschedperf](
	[sp_id] [int] IDENTITY(1,1) NOT NULL,
	[sp_date] [datetime] NULL,
	[sp_dur] [numeric](12, 2) NOT NULL,
	[sp_max] [int] NOT NULL,
	[sp_time] [nvarchar](8) NOT NULL,
	[sp_usid] [int] NOT NULL,
	[sp_isid] [int] NOT NULL,
 CONSTRAINT [PK_dxschedperf] PRIMARY KEY CLUSTERED 
(
	[sp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxscripterr]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxscripterr](
	[se_id] [int] IDENTITY(1,1) NOT NULL,
	[se_usid] [int] NOT NULL,
	[se_date] [datetime] NULL,
	[se_time] [numeric](4, 0) NOT NULL,
	[se_document] [nvarchar](100) NOT NULL,
	[se_error] [nvarchar](max) NOT NULL,
	[se_script] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxscripterr] PRIMARY KEY CLUSTERED 
(
	[se_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxscriptlog]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxscriptlog](
	[sl_id] [int] IDENTITY(1,1) NOT NULL,
	[sl_hash] [nvarchar](64) NOT NULL,
	[sl_document] [nvarchar](100) NOT NULL,
	[sl_script] [nvarchar](max) NOT NULL,
	[sl_firstrun] [datetime] NULL,
	[sl_lastrun] [datetime] NULL,
 CONSTRAINT [PK_dxscriptlog] PRIMARY KEY CLUSTERED 
(
	[sl_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxscriptperf]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxscriptperf](
	[sp_id] [int] IDENTITY(1,1) NOT NULL,
	[sp_usid] [int] NOT NULL,
	[sp_date] [datetime] NULL,
	[sp_time] [numeric](4, 0) NOT NULL,
	[sp_seconds] [numeric](10, 2) NOT NULL,
	[sp_document] [nvarchar](100) NOT NULL,
	[sp_script] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxscriptperf] PRIMARY KEY CLUSTERED 
(
	[sp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxsecmod]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxsecmod](
	[sm_id] [int] IDENTITY(1,1) NOT NULL,
	[sm_usid] [int] NOT NULL,
	[sm_ugid] [int] NOT NULL,
	[sm_table] [nvarchar](60) NOT NULL,
	[sm_oldval] [nvarchar](60) NOT NULL,
	[sm_newval] [nvarchar](60) NOT NULL,
	[sm_date] [datetime] NULL,
	[sm_time] [numeric](4, 0) NOT NULL,
	[sm_changedby] [int] NOT NULL,
	[sm_recid] [int] NOT NULL,
 CONSTRAINT [PK_dxsecmod] PRIMARY KEY CLUSTERED 
(
	[sm_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxservice]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxservice](
	[sr_id] [int] IDENTITY(1,1) NOT NULL,
	[sr_name] [nvarchar](30) NOT NULL,
	[sr_lastran] [datetime] NULL,
 CONSTRAINT [PK_dxservice] PRIMARY KEY CLUSTERED 
(
	[sr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxsrch]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxsrch](
	[sr_id] [int] IDENTITY(1,1) NOT NULL,
	[sr_name] [nvarchar](30) NOT NULL,
	[sr_caption] [nvarchar](30) NOT NULL,
	[sr_format] [nvarchar](30) NOT NULL,
	[sr_mask] [nvarchar](30) NOT NULL,
	[sr_display] [nvarchar](254) NOT NULL,
	[sr_table] [nvarchar](30) NOT NULL,
	[sr_index] [nvarchar](30) NOT NULL,
	[sr_retval] [nvarchar](30) NOT NULL,
	[sr_filter] [nvarchar](max) NOT NULL,
	[sr_title] [nvarchar](60) NOT NULL,
	[sr_addform] [nvarchar](30) NOT NULL,
	[sr_user] [bit] NOT NULL,
	[sr_number] [int] NOT NULL,
	[sr_modparm] [nvarchar](254) NOT NULL,
	[sr_code] [nvarchar](max) NOT NULL,
	[sr_systbl] [bit] NOT NULL,
	[sr_all] [bit] NOT NULL,
	[sr_doctbl] [bit] NOT NULL,
	[sr_isiphone] [bit] NOT NULL,
	[sr_sqlite] [bit] NOT NULL,
	[sr_userfilter] [nvarchar](max) NOT NULL,
	[sr_internal] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_dxsrch] PRIMARY KEY CLUSTERED 
(
	[sr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxsrch2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxsrch2](
	[s2_id] [int] IDENTITY(1,1) NOT NULL,
	[s2_name] [nvarchar](30) NOT NULL,
	[s2_caption] [nvarchar](30) NOT NULL,
	[s2_format] [nvarchar](30) NOT NULL,
	[s2_mask] [nvarchar](30) NOT NULL,
	[s2_width] [numeric](10, 0) NOT NULL,
	[s2_type] [nvarchar](30) NOT NULL,
	[s2_sorter] [numeric](10, 0) NOT NULL,
	[s2_srnum] [int] NOT NULL,
	[s2_user] [bit] NOT NULL,
	[s2_srid] [int] NOT NULL,
	[s2_sortdsc] [bit] NOT NULL,
	[s2_iphonetype] [nvarchar](30) NOT NULL,
	[s2_isiphone] [bit] NOT NULL,
 CONSTRAINT [PK_dxsrch2] PRIMARY KEY CLUSTERED 
(
	[s2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxtrak]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxtrak](
	[tr_id] [int] IDENTITY(1,1) NOT NULL,
	[tr_name] [nvarchar](30) NOT NULL,
	[tr_active] [bit] NOT NULL,
	[tr_default] [bit] NOT NULL,
	[tr_table] [nvarchar](30) NOT NULL,
	[tr_nextseq] [nvarchar](30) NOT NULL,
	[tr_revreset] [bit] NOT NULL,
	[tr_resetbackorder] [bit] NOT NULL,
 CONSTRAINT [PK_dxtrak] PRIMARY KEY CLUSTERED 
(
	[tr_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxtrak2]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxtrak2](
	[t2_id] [int] IDENTITY(1,1) NOT NULL,
	[t2_name] [nvarchar](30) NOT NULL,
	[t2_trid] [int] NOT NULL,
	[t2_seq] [int] NOT NULL,
	[t2_active] [bit] NOT NULL,
	[t2_reqseq] [bit] NOT NULL,
	[t2_reqship] [bit] NOT NULL,
	[t2_reqprod] [bit] NOT NULL,
	[t2_level] [numeric](1, 0) NOT NULL,
	[t2_reqpo] [bit] NOT NULL,
	[t2_reqjob] [bit] NOT NULL,
	[t2_color] [int] NOT NULL,
	[t2_usid] [int] NOT NULL,
	[t2_reqso] [bit] NOT NULL,
	[t2_reqrecv] [bit] NOT NULL,
	[t2_esig] [bit] NOT NULL,
	[t2_lock] [bit] NOT NULL,
	[t2_returnto] [int] NOT NULL,
	[t2_plancalc] [nvarchar](max) NOT NULL,
	[t2_minpoext] [numeric](12, 2) NOT NULL,
	[t2_notes] [nvarchar](max) NOT NULL,
	[t2_reqjobclose] [bit] NOT NULL,
	[t2_copytoback] [bit] NOT NULL,
	[t2_expression] [nvarchar](max) NOT NULL,
	[t2_reqpack] [bit] NOT NULL,
	[t2_reqlabonly] [bit] NOT NULL,
	[t2_bomqclock] [bit] NOT NULL,
	[t2_bomroutlock] [bit] NOT NULL,
	[t2_bomjobwflock] [bit] NOT NULL,
	[t2_reqnotes] [bit] NOT NULL,
	[t2_copybackorder] [nvarchar](30) NOT NULL,
	[t2_recurringstart] [bit] NOT NULL,
	[t2_recurringend] [bit] NOT NULL,
	[t2_approveby] [nvarchar](60) NOT NULL,
	[t2_reqqcgroup] [bit] NOT NULL,
	[t2_assigneduserexp] [nvarchar](max) NOT NULL,
	[t2_esigcounts] [int] NOT NULL,
	[t2_reqpost] [bit] NOT NULL,
 CONSTRAINT [PK_dxtrak2] PRIMARY KEY CLUSTERED 
(
	[t2_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxtrak3]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxtrak3](
	[t3_t2id] [int] NOT NULL,
	[t3_date] [datetime] NULL,
	[t3_time] [nvarchar](10) NOT NULL,
	[t3_usid] [int] NOT NULL,
	[t3_toid] [int] NOT NULL,
	[t3_id] [int] IDENTITY(1,1) NOT NULL,
	[t3_table] [nvarchar](30) NOT NULL,
	[t3_recid] [int] NOT NULL,
	[t3_planned] [datetime] NULL,
	[t3_notes] [nvarchar](max) NOT NULL,
	[t3_usid2] [int] NOT NULL,
	[t3_t4id] [int] NOT NULL,
	[t3_usid3] [int] NOT NULL,
	[t3_esigusid] [int] NOT NULL,
	[t3_created] [datetime] NULL,
	[t3_returnto] [int] NOT NULL,
	[t3_comment] [nvarchar](max) NOT NULL,
	[t3_minpoext] [numeric](12, 2) NOT NULL,
	[t3_expression] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxtrak3] PRIMARY KEY CLUSTERED 
(
	[t3_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxtrak4]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxtrak4](
	[t4_table] [nvarchar](30) NOT NULL,
	[t4_recid] [int] NOT NULL,
	[t4_name] [nvarchar](30) NOT NULL,
	[t4_usid] [int] NOT NULL,
	[t4_id] [int] IDENTITY(1,1) NOT NULL,
	[t4_seq] [int] NOT NULL,
 CONSTRAINT [PK_dxtrak4] PRIMARY KEY CLUSTERED 
(
	[t4_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxtrig]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxtrig](
	[tg_id] [int] IDENTITY(1,1) NOT NULL,
	[tg_name] [nvarchar](30) NOT NULL,
	[tg_event] [nvarchar](30) NOT NULL,
	[tg_destination] [nvarchar](max) NOT NULL,
	[tg_active] [bit] NOT NULL,
	[tg_msg] [nvarchar](max) NOT NULL,
	[tg_attach] [nvarchar](30) NOT NULL,
	[tg_sql] [nvarchar](max) NOT NULL,
	[tg_table] [nvarchar](30) NOT NULL,
	[tg_output] [nvarchar](30) NOT NULL,
	[tg_conditions] [nvarchar](max) NOT NULL,
	[tg_template] [bit] NOT NULL,
	[tg_subject] [nvarchar](60) NOT NULL,
	[tg_ftpserver] [nvarchar](100) NOT NULL,
	[tg_ftpuser] [nvarchar](30) NOT NULL,
	[tg_ftppass] [nvarchar](max) NOT NULL,
	[tg_crlf] [bit] NOT NULL,
	[tg_invssl] [bit] NOT NULL,
	[tg_binary] [bit] NOT NULL,
	[tg_encoding] [nvarchar](max) NOT NULL,
	[tg_delexp] [nvarchar](max) NOT NULL,
	[tg_sftp] [bit] NOT NULL,
	[tg_delcondition] [nvarchar](max) NOT NULL,
	[tg_exid] [int] NOT NULL,
	[tg_ftpport] [int] NOT NULL,
	[tg_brid] [int] NOT NULL,
	[tg_reid] [int] NOT NULL,
	[tg_excel] [bit] NOT NULL,
	[tg_notes] [nvarchar](max) NOT NULL,
	[tg_ccemail] [nvarchar](max) NOT NULL,
	[tg_bccemail] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_dxtrig] PRIMARY KEY CLUSTERED 
(
	[tg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxtrighist]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxtrighist](
	[th_id] [int] IDENTITY(1,1) NOT NULL,
	[th_date] [datetime] NULL,
	[th_time] [nvarchar](8) NOT NULL,
	[th_tgid] [int] NOT NULL,
	[th_msg] [nvarchar](max) NOT NULL,
	[th_processed] [bit] NOT NULL,
	[th_table] [nvarchar](30) NOT NULL,
	[th_recid] [int] NOT NULL,
 CONSTRAINT [PK_dxtrighist] PRIMARY KEY CLUSTERED 
(
	[th_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxwmslastact]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxwmslastact](
	[la_id] [int] IDENTITY(1,1) NOT NULL,
	[la_usid] [int] NOT NULL,
	[la_datetime] [datetime] NULL,
 CONSTRAINT [PK_dxwmslastact] PRIMARY KEY CLUSTERED 
(
	[la_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dxwmslog]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dxwmslog](
	[wg_id] [int] IDENTITY(1,1) NOT NULL,
	[wg_allonum] [numeric](15, 0) NOT NULL,
	[wg_usid] [int] NOT NULL,
	[wg_date] [datetime] NULL,
	[wg_time] [numeric](4, 0) NOT NULL,
	[wg_fiid] [int] NOT NULL,
	[wg_lotnum] [numeric](10, 0) NOT NULL,
	[wg_userlot] [nvarchar](60) NOT NULL,
	[wg_quant] [numeric](17, 7) NOT NULL,
	[wg_transaction] [nvarchar](60) NOT NULL,
	[wg_action] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_dxwmslog] PRIMARY KEY CLUSTERED 
(
	[wg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[u_MfgLotExpirations]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[u_MfgLotExpirations](
	[fi_userlot] [nvarchar](60) NULL,
	[fi_lotnum] [int] NULL,
	[mfg_prefix] [nvarchar](4) NULL,
	[mfgdate] [datetime2](7) NULL,
	[ve_name] [nvarchar](60) NULL,
	[facility_expiration] [datetime2](7) NULL,
	[mfg_part_exp] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[u_SOLinkedToPO]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[u_SOLinkedToPO](
	[PONum] [bigint] NULL,
	[SONum] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WhoIsActive]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WhoIsActive](
	[dd hh:mm:ss.mss] [varchar](8000) NULL,
	[session_id] [smallint] NOT NULL,
	[sql_text] [xml] NULL,
	[login_name] [nvarchar](128) NOT NULL,
	[wait_info] [nvarchar](4000) NULL,
	[CPU] [varchar](30) NULL,
	[tempdb_allocations] [varchar](30) NULL,
	[tempdb_current] [varchar](30) NULL,
	[blocking_session_id] [smallint] NULL,
	[reads] [varchar](30) NULL,
	[writes] [varchar](30) NULL,
	[physical_reads] [varchar](30) NULL,
	[used_memory] [varchar](30) NULL,
	[status] [varchar](30) NOT NULL,
	[open_tran_count] [varchar](30) NULL,
	[percent_complete] [varchar](30) NULL,
	[host_name] [nvarchar](128) NULL,
	[database_name] [nvarchar](128) NULL,
	[program_name] [nvarchar](128) NULL,
	[start_time] [datetime] NOT NULL,
	[login_time] [datetime] NULL,
	[request_id] [int] NULL,
	[collection_time] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WhoIsActiveBlockLeader]    Script Date: 6/30/2025 12:49:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WhoIsActiveBlockLeader](
	[dd hh:mm:ss.mss] [varchar](8000) NULL,
	[session_id] [smallint] NOT NULL,
	[sql_text] [xml] NULL,
	[login_name] [nvarchar](128) NOT NULL,
	[wait_info] [nvarchar](4000) NULL,
	[CPU] [varchar](30) NULL,
	[tempdb_allocations] [varchar](30) NULL,
	[tempdb_current] [varchar](30) NULL,
	[blocking_session_id] [smallint] NULL,
	[blocked_session_count] [varchar](30) NULL,
	[reads] [varchar](30) NULL,
	[writes] [varchar](30) NULL,
	[physical_reads] [varchar](30) NULL,
	[used_memory] [varchar](30) NULL,
	[status] [varchar](30) NOT NULL,
	[open_tran_count] [varchar](30) NULL,
	[percent_complete] [varchar](30) NULL,
	[host_name] [nvarchar](128) NULL,
	[database_name] [nvarchar](128) NULL,
	[program_name] [nvarchar](128) NULL,
	[start_time] [datetime] NOT NULL,
	[login_time] [datetime] NULL,
	[request_id] [int] NULL,
	[collection_time] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[dcbom2] ADD  DEFAULT ((4)) FOR [bc_group]
GO
ALTER TABLE [dbo].[dcbom2] ADD  DEFAULT ((0)) FOR [bc_ljid]
GO
ALTER TABLE [dbo].[dcbom2] ADD  DEFAULT ((0)) FOR [bc_orid]
GO
ALTER TABLE [dbo].[dm1099type] ADD  DEFAULT ((1)) FOR [ty_active]
GO
ALTER TABLE [dbo].[dm1099type] ADD  DEFAULT ((0)) FOR [ty_default]
GO
ALTER TABLE [dbo].[dm1099type] ADD  DEFAULT ('') FOR [ty_name]
GO
ALTER TABLE [dbo].[dm1099type] ADD  DEFAULT ('') FOR [ty_fieldname]
GO
ALTER TABLE [dbo].[dmalloc] ADD  DEFAULT ((0)) FOR [al_childchid]
GO
ALTER TABLE [dbo].[dmalloc] ADD  DEFAULT ((0)) FOR [al_parentchid]
GO
ALTER TABLE [dbo].[dmalloc] ADD  DEFAULT ((0)) FOR [al_pct]
GO
ALTER TABLE [dbo].[dmalloc] ADD  DEFAULT ((0)) FOR [al_biid]
GO
ALTER TABLE [dbo].[dmalloc] ADD  DEFAULT ((0)) FOR [al_shid]
GO
ALTER TABLE [dbo].[dmalloc] ADD  DEFAULT ((0)) FOR [al_veid]
GO
ALTER TABLE [dbo].[dmalpn] ADD  DEFAULT ((0)) FOR [alp_id]
GO
ALTER TABLE [dbo].[dmalpn] ADD  DEFAULT (' ') FOR [alp_size]
GO
ALTER TABLE [dbo].[dmalpn] ADD  DEFAULT (' ') FOR [alp_spec]
GO
ALTER TABLE [dbo].[dmauth] ADD  DEFAULT ((0)) FOR [au_biid]
GO
ALTER TABLE [dbo].[dmauth] ADD  DEFAULT ((0)) FOR [au_shid]
GO
ALTER TABLE [dbo].[dmauth] ADD  DEFAULT ('') FOR [au_name]
GO
ALTER TABLE [dbo].[dmauth] ADD  DEFAULT ((1)) FOR [au_active]
GO
ALTER TABLE [dbo].[dmautoclient] ADD  DEFAULT ('') FOR [ac_source]
GO
ALTER TABLE [dbo].[dmautoclient] ADD  DEFAULT ((0)) FOR [ac_verbose]
GO
ALTER TABLE [dbo].[dmautoclient] ADD  DEFAULT ((0)) FOR [ac_loopback]
GO
ALTER TABLE [dbo].[dmautoclient] ADD  DEFAULT ('COM1') FOR [ac_com]
GO
ALTER TABLE [dbo].[dmautoclient] ADD  DEFAULT ((0)) FOR [ac_smid]
GO
ALTER TABLE [dbo].[dmautoclient] ADD  DEFAULT ('Standard') FOR [ac_layout]
GO
ALTER TABLE [dbo].[dmautoclient] ADD  DEFAULT ('None') FOR [ac_lotprinter]
GO
ALTER TABLE [dbo].[dmautoclient] ADD  DEFAULT ('None') FOR [ac_masterlotprinter]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ((0)) FOR [ae_dayofweek]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_filepath]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('1') FOR [ae_interval]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT (NULL) FOR [ae_lastprint]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ((0)) FOR [ae_reid]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_reportfor]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ((0)) FOR [ae_reportid]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ((0)) FOR [ae_time]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('File') FOR [ae_destinationtype]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_destination]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_emailbody]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_emailsubject]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_text]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_type]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_ftppass]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_ftpserver]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ((0)) FOR [ae_ftpport]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_ftpuser]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ((0)) FOR [ae_invssl]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ((0)) FOR [ae_sftp]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_delimiter]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ((0)) FOR [ae_includeheader]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ((0)) FOR [ae_doublequotes]
GO
ALTER TABLE [dbo].[dmautoexport] ADD  DEFAULT ('') FOR [ae_password]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ((1)) FOR [ba_active]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_name]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_for]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_street]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_street2]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_city]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_state]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_zip]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_country]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ((0)) FOR [ba_cyid]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_contact]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_phone]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_phext]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_fax]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_email]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_url]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_bankid]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_bic]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_idcode]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('checking') FOR [ba_acctype]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_account]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_accname]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_iban]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ((0)) FOR [ba_balanced]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_payorid]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_payor]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_pstreet]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_pstreet2]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_pcity]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_pstate]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_pzip]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_pcountry]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ((0)) FOR [ba_pcyid]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_pphone]
GO
ALTER TABLE [dbo].[dmbankacc] ADD  DEFAULT ('') FOR [ba_pemail]
GO
ALTER TABLE [dbo].[dmbcodefmt] ADD  DEFAULT ('') FOR [bf_name]
GO
ALTER TABLE [dbo].[dmbcodefmt] ADD  DEFAULT ((0)) FOR [bf_length]
GO
ALTER TABLE [dbo].[dmbcodefmt] ADD  DEFAULT ((1)) FOR [bf_active]
GO
ALTER TABLE [dbo].[dmbcodeseg] ADD  DEFAULT ((0)) FOR [bs_bfid]
GO
ALTER TABLE [dbo].[dmbcodeseg] ADD  DEFAULT ((0)) FOR [bs_start]
GO
ALTER TABLE [dbo].[dmbcodeseg] ADD  DEFAULT ((0)) FOR [bs_end]
GO
ALTER TABLE [dbo].[dmbcodeseg] ADD  DEFAULT ((0)) FOR [bs_ai]
GO
ALTER TABLE [dbo].[dmbiassign] ADD  DEFAULT ((0)) FOR [ba_bpid]
GO
ALTER TABLE [dbo].[dmbiassign] ADD  DEFAULT ((0)) FOR [ba_usid]
GO
ALTER TABLE [dbo].[dmbiassign] ADD  DEFAULT ((999999)) FOR [ba_seq]
GO
ALTER TABLE [dbo].[dmbicategory] ADD  DEFAULT ('') FOR [bc_name]
GO
ALTER TABLE [dbo].[dmbicategory] ADD  DEFAULT ((1)) FOR [bc_active]
GO
ALTER TABLE [dbo].[dmbicategory] ADD  DEFAULT ((0)) FOR [bc_default]
GO
ALTER TABLE [dbo].[dmbicatsecurity] ADD  DEFAULT ((0)) FOR [bs_bcid]
GO
ALTER TABLE [dbo].[dmbicatsecurity] ADD  DEFAULT ((0)) FOR [bs_access]
GO
ALTER TABLE [dbo].[dmbicatsecurity] ADD  DEFAULT ((0)) FOR [bs_ugid]
GO
ALTER TABLE [dbo].[dmbicolorprofiles] ADD  DEFAULT ('') FOR [cp_name]
GO
ALTER TABLE [dbo].[dmbicolorprofiles] ADD  DEFAULT ((1)) FOR [cp_active]
GO
ALTER TABLE [dbo].[dmbicolors] ADD  DEFAULT ((0)) FOR [bc_cpid]
GO
ALTER TABLE [dbo].[dmbicolors] ADD  DEFAULT ((0)) FOR [bc_seq]
GO
ALTER TABLE [dbo].[dmbicolors] ADD  DEFAULT ((0)) FOR [bc_color]
GO
ALTER TABLE [dbo].[dmbidataset] ADD  DEFAULT ((1)) FOR [bd_active]
GO
ALTER TABLE [dbo].[dmbidataset] ADD  DEFAULT ((0)) FOR [bd_d2id]
GO
ALTER TABLE [dbo].[dmbidataset] ADD  DEFAULT ((0)) FOR [bd_daid]
GO
ALTER TABLE [dbo].[dmbidataset] ADD  DEFAULT ('') FOR [bd_descrip]
GO
ALTER TABLE [dbo].[dmbidataset] ADD  DEFAULT ('') FOR [bd_name]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ('') FOR [be_type]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_grid]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_right]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_bottom]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_left]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_top]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_bdid]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_bpid]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ('') FOR [be_title]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_drilldownbdid]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_drilldownbpid]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_cpid]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ('Left') FOR [be_anchorxref]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((25)) FOR [be_anchorxpos]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ('Top') FOR [be_anchoryref]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((25)) FOR [be_anchorypos]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((50)) FOR [be_heightpct]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((50)) FOR [be_widthpct]
GO
ALTER TABLE [dbo].[dmbielement] ADD  DEFAULT ((0)) FOR [be_aggregate]
GO
ALTER TABLE [dbo].[dmbigridcols] ADD  DEFAULT ((0)) FOR [bc_b2id]
GO
ALTER TABLE [dbo].[dmbigridcols] ADD  DEFAULT ((0)) FOR [bc_beid]
GO
ALTER TABLE [dbo].[dmbigridcols] ADD  DEFAULT ('Grouped') FOR [bc_aggtype]
GO
ALTER TABLE [dbo].[dmbigridcols] ADD  DEFAULT ((0)) FOR [bc_seq]
GO
ALTER TABLE [dbo].[dmbigridcols] ADD  DEFAULT ((0)) FOR [bc_width]
GO
ALTER TABLE [dbo].[dmbigridcols] ADD  DEFAULT ('') FOR [bc_format]
GO
ALTER TABLE [dbo].[dmbigridcols] ADD  DEFAULT ('') FOR [bc_mask]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_name]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_grid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_street]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_street2]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_city]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_state]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_zip]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_phone]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_fax]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_contact]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_credlim]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_teid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT (NULL) FOR [bi_credhld]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_active]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_notes]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_collect]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_country]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT (' ') FOR [bi_ccode]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_user1]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_brid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_smid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_s1id]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_s2id]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_trid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_waid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_statax]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_loctax]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_highcrd]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_county]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_custid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_email]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_poreqd]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_frid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_pastday]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_service]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_s3id]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_webname]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_webpass]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_backord]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_dba]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_s4id]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_s5id]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_credmast]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_phext]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT (NULL) FOR [bi_lastcred]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_nextact]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT (NULL) FOR [bi_nextdate]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_exid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_dear]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_said]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_fcid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_popup]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('Printer') FOR [bi_invdest]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('Printer') FOR [bi_statedest]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_psid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_quota]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_exempt]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_exceed]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_exday]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_credflag]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_dgid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_pomask]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_shelfpct]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_archid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_mobileid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_popupship]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_trakid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_trak2id]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_shelfdays]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT (' ') FOR [bi_pfuser]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_sotrakid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_posprice]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_exreserve]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_routeacct]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('with') FOR [bi_shortship]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_pfid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_nopospay]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_reqcpart]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_availall]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_street3]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_ccid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_caid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_pdid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((1)) FOR [bi_restrictshipfrom]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_noinvdflt]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_rebill]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_rebillworkflow]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_shortpayprid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_noreserve]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_cardvaultid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_retattrib1]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_retattrib2]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_retattrib3]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_retdates]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT (NULL) FOR [bi_laststateprint]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_creddueshipdays]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_ttid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT (NULL) FOR [bi_addressvalid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_edibilltopo]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_edibilltopodays]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_c3id]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('Manual') FOR [bi_emailtype]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('Reserved') FOR [bi_linkedjobfinish]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_vatid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_cyid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_serializeonreserve]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_invoiceemail]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_statementemail]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ((0)) FOR [bi_baid]
GO
ALTER TABLE [dbo].[dmbill] ADD  DEFAULT ('') FOR [bi_ccproccontactid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_biid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_waid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_s1id]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_s2id]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_s3id]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_s4id]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_s5id]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_brid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_trid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_frid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_psid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_sotrakid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_fcid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ((0)) FOR [bf_dgid]
GO
ALTER TABLE [dbo].[dmbillfacility] ADD  DEFAULT ('') FOR [bf_ccproccontactid]
GO
ALTER TABLE [dbo].[dmbillship] ADD  DEFAULT ((0)) FOR [bs_biid]
GO
ALTER TABLE [dbo].[dmbillship] ADD  DEFAULT ((0)) FOR [bs_shid]
GO
ALTER TABLE [dbo].[dmbillship] ADD  DEFAULT ((0)) FOR [bs_shipdefault]
GO
ALTER TABLE [dbo].[dmbillship] ADD  DEFAULT ((0)) FOR [bs_billdefault]
GO
ALTER TABLE [dbo].[dmbipage] ADD  DEFAULT ('') FOR [bp_name]
GO
ALTER TABLE [dbo].[dmbipage] ADD  DEFAULT ('') FOR [bp_descrip]
GO
ALTER TABLE [dbo].[dmbipage] ADD  DEFAULT ((1)) FOR [bp_active]
GO
ALTER TABLE [dbo].[dmbipage] ADD  DEFAULT ((0)) FOR [bp_bcid]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_bomfor]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_prid]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_seq]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_quant]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ('') FOR [bo_notes]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ('') FOR [bo_desig]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_reid]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_subtot]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_costonly]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_unid]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_scrap]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_overage]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_byproduct]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_overissue]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_bgid]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ('') FOR [bo_bomcalc]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_fixqty]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_scrapcost]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_uselot]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_useexp]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_coprod]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_propattrib]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ('Default') FOR [bo_cpcost]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_finasissued]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_reqseq]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_incqty]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_maxage]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_coprodquant]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ('') FOR [bo_groupby]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_q3id]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_minage]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ('No') FOR [bo_nonscaleableqty]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_propattrib1]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_propattrib2]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_propattrib3]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_issueunid]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_shelfpct]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_shelfdays]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ((0)) FOR [bo_relievecatch]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ('Fixed') FOR [bo_issueinctype]
GO
ALTER TABLE [dbo].[dmbom] ADD  DEFAULT ('') FOR [bo_issueincexp]
GO
ALTER TABLE [dbo].[dmbomgrp] ADD  DEFAULT ('') FOR [bg_name]
GO
ALTER TABLE [dbo].[dmbomgrp] ADD  DEFAULT ((1)) FOR [bg_active]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_name]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_street]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_street2]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_city]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_state]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_zip]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_phone]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_fax]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_contact]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ((1)) FOR [br_active]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ((0)) FOR [br_default]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_webname]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_webpass]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_phext]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ((0)) FOR [br_quota]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ('') FOR [br_email]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT (' ') FOR [br_ccode]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ((0)) FOR [br_ccid]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ((0)) FOR [br_veid]
GO
ALTER TABLE [dbo].[dmbrok] ADD  DEFAULT ((0)) FOR [br_cyid]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peid]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_chid]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt1]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt2]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt3]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt4]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt5]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt6]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt7]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt8]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt9]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt10]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt11]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt12]
GO
ALTER TABLE [dbo].[dmbud] ADD  DEFAULT ((0)) FOR [bu_peramt13]
GO
ALTER TABLE [dbo].[dmbuyer] ADD  DEFAULT ('') FOR [bu_name]
GO
ALTER TABLE [dbo].[dmbuyer] ADD  DEFAULT ((1)) FOR [bu_active]
GO
ALTER TABLE [dbo].[dmbuyer] ADD  DEFAULT ((0)) FOR [bu_default]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('') FOR [ca_name]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ((1)) FOR [ca_active]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('') FOR [ca_express]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('') FOR [ca_type]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('99,999,999.99') FOR [ca_picture]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('') FOR [ca_notes]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('') FOR [ca_field]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ((0)) FOR [ca_seq]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('dmbom') FOR [ca_table]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('N') FOR [ca_fldtype]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('Price') FOR [ca_linecalc]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('b') FOR [ca_level]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ((0)) FOR [ca_regulatory]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ('Always') FOR [ca_until]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ((0)) FOR [ca_prtform]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ((0)) FOR [ca_masterorder]
GO
ALTER TABLE [dbo].[dmcalc] ADD  DEFAULT ((0)) FOR [ca_manualrecalc]
GO
ALTER TABLE [dbo].[dmcampaign] ADD  DEFAULT ('') FOR [ca_name]
GO
ALTER TABLE [dbo].[dmcampaign] ADD  DEFAULT ((0)) FOR [ca_default]
GO
ALTER TABLE [dbo].[dmcampaign] ADD  DEFAULT ((1)) FOR [ca_active]
GO
ALTER TABLE [dbo].[dmcampaign] ADD  DEFAULT ((0)) FOR [ca_emid]
GO
ALTER TABLE [dbo].[dmcampaignemail] ADD  DEFAULT ('') FOR [ce_name]
GO
ALTER TABLE [dbo].[dmcampaignemail] ADD  DEFAULT ((0)) FOR [ce_default]
GO
ALTER TABLE [dbo].[dmcampaignemail] ADD  DEFAULT ((1)) FOR [ce_active]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ('') FOR [c3_name]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_default]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((1)) FOR [c3_active]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_recon]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_badchk]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_chid]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((1)) FOR [c3_cashback]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_recchid]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_recgain]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ('9999-9999-9999-9999') FOR [c3_ccmask]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_creditcard]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_giftcard]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_max]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_cashchid]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((1)) FOR [c3_showcashreg]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((0)) FOR [c3_seq]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ('') FOR [c3_swipeexpression]
GO
ALTER TABLE [dbo].[dmcash3] ADD  DEFAULT ((1)) FOR [c3_showdsd]
GO
ALTER TABLE [dbo].[dmcats] ADD  DEFAULT ('') FOR [ca_name]
GO
ALTER TABLE [dbo].[dmcats] ADD  DEFAULT ((1)) FOR [ca_active]
GO
ALTER TABLE [dbo].[dmcats] ADD  DEFAULT ((0)) FOR [ca_default]
GO
ALTER TABLE [dbo].[dmcats] ADD  DEFAULT ((0)) FOR [ca_quota]
GO
ALTER TABLE [dbo].[dmcats] ADD  DEFAULT ((0)) FOR [ca_restricted]
GO
ALTER TABLE [dbo].[dmcats2] ADD  DEFAULT ('') FOR [c2_name]
GO
ALTER TABLE [dbo].[dmcats2] ADD  DEFAULT ((1)) FOR [c2_active]
GO
ALTER TABLE [dbo].[dmcats2] ADD  DEFAULT ((0)) FOR [c2_caid]
GO
ALTER TABLE [dbo].[dmcats2] ADD  DEFAULT ((0)) FOR [c2_quota]
GO
ALTER TABLE [dbo].[dmcats2] ADD  DEFAULT ((0)) FOR [c2_restricted]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_caid]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_biid]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_shid]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_c2id]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_exid]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_waid]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_rsid]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_parentrsid]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_rtid]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_min]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_max]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_p1id]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_p2id]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_p3id]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_p4id]
GO
ALTER TABLE [dbo].[dmcats3] ADD  DEFAULT ((0)) FOR [c3_p5id]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_number]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_nameoncard]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ((0)) FOR [cc_exp]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ((0)) FOR [cc_c3id]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ((1)) FOR [cc_billaddr]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_street]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_street2]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_city]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_state]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_zip]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_country]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ((0)) FOR [cc_biid]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_last4]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ((0)) FOR [cc_ordnum]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_billpo]
GO
ALTER TABLE [dbo].[dmccard] ADD  DEFAULT ('') FOR [cc_cardvaultid]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ((1)) FOR [cc_active]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_merchant]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_name]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_partner]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_pass]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_user]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ((0)) FOR [cc_default]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ((2)) FOR [cc_type]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_host]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ((9000)) FOR [cc_ipport]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ((0)) FOR [cc_terminalreq]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ((0)) FOR [cc_defaultdc]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_location]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_termcode]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_client]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ((1)) FOR [cc_testmode]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_apikey]
GO
ALTER TABLE [dbo].[dmccproc] ADD  DEFAULT ('') FOR [cc_external]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ('') FOR [ce_name]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_shid]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_rate]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_hours]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((1)) FOR [ce_active]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_util]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_workcnt]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_default]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT (NULL) FOR [ce_acquired]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_acqcost]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ('') FOR [ce_depreciation]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_parent]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_ctid]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ('') FOR [ce_descrip]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ('') FOR [ce_notes]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ('') FOR [ce_manufacturer]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ('') FOR [ce_model]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ('') FOR [ce_serial]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((1)) FOR [ce_burfact]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_depchid]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_depmonths]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_lastpostcost]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_depexpensechid]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT (NULL) FOR [ce_lastpostdate]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_minljquant]
GO
ALTER TABLE [dbo].[dmcent] ADD  DEFAULT ((0)) FOR [ce_maxljquant]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((0)) FOR [cm_ceid]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ('') FOR [cm_recurtype]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((0)) FOR [cm_recurfreq]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((0)) FOR [cm_prid]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ('') FOR [cm_name]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((0)) FOR [cm_mgid]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ('Work Center') FOR [cm_unavailvl]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((5)) FOR [cm_priority]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((0)) FOR [cm_meter]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((0)) FOR [cm_maxmeter]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ('Completion date') FOR [cm_schedtype]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ('none') FOR [cm_dayof]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((0)) FOR [cm_day]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((0)) FOR [cm_copydoc]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT (NULL) FOR [cm_initdate]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ((0)) FOR [cm_recid]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ('') FOR [cm_table]
GO
ALTER TABLE [dbo].[dmcentmaint] ADD  DEFAULT ('') FOR [cm_notes]
GO
ALTER TABLE [dbo].[dmcentstatus] ADD  DEFAULT ((0)) FOR [cs_cmid]
GO
ALTER TABLE [dbo].[dmcentstatus] ADD  DEFAULT (NULL) FOR [cs_lastmaint]
GO
ALTER TABLE [dbo].[dmcentstatus] ADD  DEFAULT ((0)) FOR [cs_meter]
GO
ALTER TABLE [dbo].[dmcenttype] ADD  DEFAULT ('') FOR [ct_name]
GO
ALTER TABLE [dbo].[dmcenttype] ADD  DEFAULT ((1)) FOR [ct_active]
GO
ALTER TABLE [dbo].[dmcenttype] ADD  DEFAULT ((0)) FOR [ct_default]
GO
ALTER TABLE [dbo].[dmchangeover] ADD  DEFAULT ((0)) FOR [co_prevseq1]
GO
ALTER TABLE [dbo].[dmchangeover] ADD  DEFAULT ((0)) FOR [co_nextseq1]
GO
ALTER TABLE [dbo].[dmchangeover] ADD  DEFAULT ((0)) FOR [co_opid]
GO
ALTER TABLE [dbo].[dmchangeover] ADD  DEFAULT ((1)) FOR [co_active]
GO
ALTER TABLE [dbo].[dmchangeover] ADD  DEFAULT ((0)) FOR [co_prid]
GO
ALTER TABLE [dbo].[dmchgrp] ADD  DEFAULT ('') FOR [cg_name]
GO
ALTER TABLE [dbo].[dmchgrp] ADD  DEFAULT ((1)) FOR [cg_active]
GO
ALTER TABLE [dbo].[dmchgrp] ADD  DEFAULT ((0)) FOR [cg_default]
GO
ALTER TABLE [dbo].[dmchgrp2] ADD  DEFAULT ((0)) FOR [c2_cgid]
GO
ALTER TABLE [dbo].[dmchgrp2] ADD  DEFAULT ((0)) FOR [c2_usid]
GO
ALTER TABLE [dbo].[dmchgrp2] ADD  DEFAULT ((0)) FOR [c2_ugid]
GO
ALTER TABLE [dbo].[dmchgrp2] ADD  DEFAULT ((0)) FOR [c2_access]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_account]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ('') FOR [ch_name]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ('') FOR [ch_type]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_cogsid]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((1)) FOR [ch_active]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_cgid]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_balance]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_currgain]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_fcid]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_masterchid]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_laborcogsid]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_burdencogsid]
GO
ALTER TABLE [dbo].[dmchrt] ADD  DEFAULT ((0)) FOR [ch_baid]
GO
ALTER TABLE [dbo].[dmcmscatlink] ADD  DEFAULT ((0)) FOR [cl_ccid]
GO
ALTER TABLE [dbo].[dmcmscatlink] ADD  DEFAULT ('Category') FOR [cl_type]
GO
ALTER TABLE [dbo].[dmcmscatlink] ADD  DEFAULT ((0)) FOR [cl_recid]
GO
ALTER TABLE [dbo].[dmcmscatlink] ADD  DEFAULT ((0)) FOR [cl_csid]
GO
ALTER TABLE [dbo].[dmcmscatlink] ADD  DEFAULT ((0)) FOR [cl_parentccid]
GO
ALTER TABLE [dbo].[dmcmscats] ADD  DEFAULT ('') FOR [cc_ecomcat]
GO
ALTER TABLE [dbo].[dmcmscats] ADD  DEFAULT ((1)) FOR [cc_active]
GO
ALTER TABLE [dbo].[dmcmscats] ADD  DEFAULT ((0)) FOR [cc_default]
GO
ALTER TABLE [dbo].[dmcmscats] ADD  DEFAULT ((0)) FOR [cc_seq]
GO
ALTER TABLE [dbo].[dmcmscats] ADD  DEFAULT ('None') FOR [cc_type]
GO
ALTER TABLE [dbo].[dmcmscats] ADD  DEFAULT ((0)) FOR [cc_includeinfooter]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_regbiid]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_regshid]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_minord]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((1)) FOR [cd_allowsaturday]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((1)) FOR [cd_allowsunday]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_csid]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_s1id]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_s2id]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_s3id]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_s4id]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_s5id]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_trid]
GO
ALTER TABLE [dbo].[dmcmsdefaults] ADD  DEFAULT ((0)) FOR [cd_smid]
GO
ALTER TABLE [dbo].[dmcmsmenus] ADD  DEFAULT ((0)) FOR [cm_parentmeid]
GO
ALTER TABLE [dbo].[dmcmsmenus] ADD  DEFAULT ('') FOR [cm_text]
GO
ALTER TABLE [dbo].[dmcmsmenus] ADD  DEFAULT ('') FOR [cm_desc]
GO
ALTER TABLE [dbo].[dmcmsmenus] ADD  DEFAULT ('') FOR [cm_url]
GO
ALTER TABLE [dbo].[dmcmsmenus] ADD  DEFAULT ('') FOR [cm_column]
GO
ALTER TABLE [dbo].[dmcmsmenus] ADD  DEFAULT ((0)) FOR [cm_sort]
GO
ALTER TABLE [dbo].[dmcmsmenus] ADD  DEFAULT ((1)) FOR [cm_active]
GO
ALTER TABLE [dbo].[dmcmsmenus] ADD  DEFAULT ((0)) FOR [cm_csid]
GO
ALTER TABLE [dbo].[dmcmsparentcats] ADD  DEFAULT ((0)) FOR [pc_ccid]
GO
ALTER TABLE [dbo].[dmcmsparentcats] ADD  DEFAULT ((0)) FOR [pc_parentccid]
GO
ALTER TABLE [dbo].[dmcmssecquest] ADD  DEFAULT ('') FOR [cq_question]
GO
ALTER TABLE [dbo].[dmcmssecquest] ADD  DEFAULT ((1)) FOR [cq_active]
GO
ALTER TABLE [dbo].[dmcmssecquest] ADD  DEFAULT ((0)) FOR [cq_csid]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT (' ') FOR [cu_type]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_biid]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_shid]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((1)) FOR [cu_active]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ('') FOR [cu_password]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ('') FOR [cu_login]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ('') FOR [cu_email]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_cqid]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ('') FOR [cu_sqanswer]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_orderconfirm]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_specialoffer]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((1)) FOR [cu_newsletter]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT (' ') FOR [cu_deldate]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_minord]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ('Dollars') FOR [cu_minordtype]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_samedaycharge]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((1)) FOR [cu_allowsunday]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((1)) FOR [cu_allowsaturday]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_brid]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_ccid]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ('') FOR [cu_phone]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_csid]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_paymentrequired]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((1)) FOR [cu_loginapproved]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_chgpass]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_guestuser]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ('') FOR [cu_fname]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ('') FOR [cu_lname]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_allowcartreminder]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ('') FOR [cu_wishlist]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_defaultccid]
GO
ALTER TABLE [dbo].[dmcmsuseracc] ADD  DEFAULT ((0)) FOR [cu_statelessapionly]
GO
ALTER TABLE [dbo].[dmco1] ADD  DEFAULT ('') FOR [c1_name]
GO
ALTER TABLE [dbo].[dmco1] ADD  DEFAULT ((1)) FOR [c1_active]
GO
ALTER TABLE [dbo].[dmco1] ADD  DEFAULT ((0)) FOR [c1_default]
GO
ALTER TABLE [dbo].[dmco2] ADD  DEFAULT ('') FOR [c2_name]
GO
ALTER TABLE [dbo].[dmco2] ADD  DEFAULT ((1)) FOR [c2_active]
GO
ALTER TABLE [dbo].[dmco2] ADD  DEFAULT ((0)) FOR [c2_default]
GO
ALTER TABLE [dbo].[dmco3] ADD  DEFAULT ('') FOR [c3_name]
GO
ALTER TABLE [dbo].[dmco3] ADD  DEFAULT ((1)) FOR [c3_active]
GO
ALTER TABLE [dbo].[dmco3] ADD  DEFAULT ((0)) FOR [c3_default]
GO
ALTER TABLE [dbo].[dmco4] ADD  DEFAULT ('') FOR [c4_name]
GO
ALTER TABLE [dbo].[dmco4] ADD  DEFAULT ((1)) FOR [c4_active]
GO
ALTER TABLE [dbo].[dmco4] ADD  DEFAULT ((0)) FOR [c4_default]
GO
ALTER TABLE [dbo].[dmco4] ADD  DEFAULT ((0)) FOR [c4_financialmaster]
GO
ALTER TABLE [dbo].[dmco5] ADD  DEFAULT ('') FOR [c5_name]
GO
ALTER TABLE [dbo].[dmco5] ADD  DEFAULT ((1)) FOR [c5_active]
GO
ALTER TABLE [dbo].[dmco5] ADD  DEFAULT ((0)) FOR [c5_default]
GO
ALTER TABLE [dbo].[dmcogrp] ADD  DEFAULT ('') FOR [cg_name]
GO
ALTER TABLE [dbo].[dmcogrp] ADD  DEFAULT ((1)) FOR [cg_active]
GO
ALTER TABLE [dbo].[dmcogrp] ADD  DEFAULT ((0)) FOR [cg_default]
GO
ALTER TABLE [dbo].[dmcogrp2] ADD  DEFAULT ((0)) FOR [c2_usid]
GO
ALTER TABLE [dbo].[dmcogrp2] ADD  DEFAULT ((0)) FOR [c2_cgid]
GO
ALTER TABLE [dbo].[dmcolsums] ADD  DEFAULT ((0)) FOR [cs_usid]
GO
ALTER TABLE [dbo].[dmcolsums] ADD  DEFAULT ('') FOR [cs_reporttype]
GO
ALTER TABLE [dbo].[dmcolsums] ADD  DEFAULT ('') FOR [cs_gridclass]
GO
ALTER TABLE [dbo].[dmcolsums] ADD  DEFAULT ((0)) FOR [cs_collapsed]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('') FOR [c2_for]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ((0)) FOR [c2_fornum]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('') FOR [c2_forname]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('') FOR [c2_on]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ((0)) FOR [c2_onnum]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('') FOR [c2_onname]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('') FOR [c2_type]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ((0)) FOR [c2_typenum]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT (NULL) FOR [c2_start]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT (NULL) FOR [c2_end]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ((1)) FOR [c2_active]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('All companies') FOR [c2_comptype]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ((0)) FOR [c2_compid]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ((0)) FOR [c2_unid]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ((0)) FOR [c2_cgid]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ((1)) FOR [c2_includefreight]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('') FOR [c2_descrip]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('') FOR [c2_expression]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('Created') FOR [c2_basedon]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('') FOR [c2_paytype]
GO
ALTER TABLE [dbo].[dmcomm2] ADD  DEFAULT ('') FOR [c2_itemfilter]
GO
ALTER TABLE [dbo].[dmcommgrp] ADD  DEFAULT ('') FOR [cg_name]
GO
ALTER TABLE [dbo].[dmcommgrp] ADD  DEFAULT ((1)) FOR [cg_active]
GO
ALTER TABLE [dbo].[dmcommgrp] ADD  DEFAULT ((0)) FOR [cg_default]
GO
ALTER TABLE [dbo].[dmconstant] ADD  DEFAULT ('') FOR [co_name]
GO
ALTER TABLE [dbo].[dmconstant] ADD  DEFAULT ((0)) FOR [co_value]
GO
ALTER TABLE [dbo].[dmconstant] ADD  DEFAULT ((1)) FOR [co_active]
GO
ALTER TABLE [dbo].[dmconstant] ADD  DEFAULT ('') FOR [co_notes]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_biid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_lname]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_fname]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_title]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_dear]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_phone]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_fax]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT (' ') FOR [co_email]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_cell]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_home]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_website]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_u1id]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_u2id]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_u3id]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_u4id]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_u5id]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_notes]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_evid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_e2id]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_street]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_street2]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_city]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_state]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_zip]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((1)) FOR [co_active]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT (NULL) FOR [co_evntdue]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_smid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_phext]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_user1]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_user2]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_user3]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_user4]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_user5]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_company]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_nextact]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT (NULL) FOR [co_nextdate]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((1)) FOR [co_usid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('All users') FOR [co_private]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT (NULL) FOR [co_lastnote]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_said]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_quota]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_nexttime]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_sync]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_shid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_veid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_cgid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_country]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_rsslink]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT (' ') FOR [co_ccode]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_trakid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_trak2id]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_revenues]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_employees]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_parentname]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_maid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_msid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_stocksym]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_syncgoog]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_syncyahoo]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT (NULL) FOR [co_lastrss]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ('') FOR [co_street3]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_cyid]
GO
ALTER TABLE [dbo].[dmcont] ADD  DEFAULT ((0)) FOR [co_ttid]
GO
ALTER TABLE [dbo].[dmcont2] ADD  DEFAULT ((0)) FOR [c2_usid]
GO
ALTER TABLE [dbo].[dmcont2] ADD  DEFAULT (NULL) FOR [c2_date]
GO
ALTER TABLE [dbo].[dmcont2] ADD  DEFAULT ('') FOR [c2_time]
GO
ALTER TABLE [dbo].[dmcont2] ADD  DEFAULT ((0)) FOR [c2_coid]
GO
ALTER TABLE [dbo].[dmcont2] ADD  DEFAULT ('') FOR [c2_notes]
GO
ALTER TABLE [dbo].[dmcont2] ADD  DEFAULT ((1)) FOR [c2_ctid]
GO
ALTER TABLE [dbo].[dmcont2] ADD  DEFAULT ((1)) FOR [c2_cpid]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ('') FOR [cr_contnum]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ((0)) FOR [cr_unid]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ((0)) FOR [cr_prid]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ((0)) FOR [cr_tarewgt]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ((0)) FOR [cr_acqcost]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT (NULL) FOR [cr_acquired]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ('N') FOR [cr_depreciation]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ((0)) FOR [cr_depchid]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ((0)) FOR [cr_depmonths]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ((0)) FOR [cr_lastpostcost]
GO
ALTER TABLE [dbo].[dmcontainer] ADD  DEFAULT ((1)) FOR [cr_active]
GO
ALTER TABLE [dbo].[dmcontcampaign] ADD  DEFAULT ((0)) FOR [cn_coid]
GO
ALTER TABLE [dbo].[dmcontcampaign] ADD  DEFAULT ((0)) FOR [cn_caid]
GO
ALTER TABLE [dbo].[dmcontcampaign] ADD  DEFAULT ((0)) FOR [cn_ceid]
GO
ALTER TABLE [dbo].[dmcontcampaign] ADD  DEFAULT (NULL) FOR [cn_date]
GO
ALTER TABLE [dbo].[dmcontcampaign] ADD  DEFAULT ((0)) FOR [cn_time]
GO
ALTER TABLE [dbo].[dmcontcampaign] ADD  DEFAULT ((0)) FOR [cn_cpid]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_dear]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ((0)) FOR [cp_said]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_fname]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_lname]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_title]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_cell]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_phext]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_home]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_email]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ((0)) FOR [cp_default]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ((1)) FOR [cp_active]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ((0)) FOR [cp_coid]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_ccode]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_phone]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ((0)) FOR [cp_emailall]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ((0)) FOR [cp_linkemail]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('Both') FOR [cp_massemail]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ((0)) FOR [cp_cyid]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ('') FOR [cp_country]
GO
ALTER TABLE [dbo].[dmcontpeople] ADD  DEFAULT ((1)) FOR [cp_monitoremail]
GO
ALTER TABLE [dbo].[dmcountry] ADD  DEFAULT ((0)) FOR [cy_code]
GO
ALTER TABLE [dbo].[dmcountry] ADD  DEFAULT ('') FOR [cy_name]
GO
ALTER TABLE [dbo].[dmcountry] ADD  DEFAULT ((1)) FOR [cy_active]
GO
ALTER TABLE [dbo].[dmcountry] ADD  DEFAULT ((0)) FOR [cy_default]
GO
ALTER TABLE [dbo].[dmcountry] ADD  DEFAULT ('') FOR [cy_mask]
GO
ALTER TABLE [dbo].[dmcountry] ADD  DEFAULT ((0)) FOR [cy_fcid]
GO
ALTER TABLE [dbo].[dmcountry] ADD  DEFAULT ((0)) FOR [cy_caid]
GO
ALTER TABLE [dbo].[dmcrew] ADD  DEFAULT ('') FOR [cr_name]
GO
ALTER TABLE [dbo].[dmcrew] ADD  DEFAULT ((1)) FOR [cr_active]
GO
ALTER TABLE [dbo].[dmcrew] ADD  DEFAULT ((0)) FOR [cr_default]
GO
ALTER TABLE [dbo].[dmcrew] ADD  DEFAULT ((0)) FOR [cr_sfid]
GO
ALTER TABLE [dbo].[dmcrew] ADD  DEFAULT ((1)) FOR [cr_workother]
GO
ALTER TABLE [dbo].[dmcrmprojcats] ADD  DEFAULT ('') FOR [cc_name]
GO
ALTER TABLE [dbo].[dmcrmprojcats] ADD  DEFAULT ((1)) FOR [cc_active]
GO
ALTER TABLE [dbo].[dmcrmprojcats] ADD  DEFAULT ((0)) FOR [cc_default]
GO
ALTER TABLE [dbo].[dmctype] ADD  DEFAULT ('') FOR [ct_name]
GO
ALTER TABLE [dbo].[dmctype] ADD  DEFAULT ((1)) FOR [ct_active]
GO
ALTER TABLE [dbo].[dmctype] ADD  DEFAULT ((0)) FOR [ct_default]
GO
ALTER TABLE [dbo].[dmctype] ADD  DEFAULT ((0)) FOR [ct_system]
GO
ALTER TABLE [dbo].[dmctype] ADD  DEFAULT ((0)) FOR [ct_noid]
GO
ALTER TABLE [dbo].[dmctypesec] ADD  DEFAULT ((0)) FOR [cs_access]
GO
ALTER TABLE [dbo].[dmctypesec] ADD  DEFAULT ((0)) FOR [cs_ctid]
GO
ALTER TABLE [dbo].[dmctypesec] ADD  DEFAULT ((0)) FOR [cs_ugid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_prid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_biid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ('') FOR [cu_codenum]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ('') FOR [cu_descrip]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_price]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((1)) FOR [cu_active]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((1)) FOR [cu_taxable]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((1)) FOR [cu_salfact]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_salunid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_shid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_msdsid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_cofaid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_solabid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_prfact]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_prunid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ('') FOR [cu_notes]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_default]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_shelfdays]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_shelfpct]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_qcid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_minsale]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_incsale]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_qcid2]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_soquan]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_smid]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_smpct]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_samelot]
GO
ALTER TABLE [dbo].[dmcust] ADD  DEFAULT ((0)) FOR [cu_linejobqcoverride]
GO
ALTER TABLE [dbo].[dmcustlabel] ADD  DEFAULT ((0)) FOR [cl_cuid]
GO
ALTER TABLE [dbo].[dmcustlabel] ADD  DEFAULT ((0)) FOR [cl_rdid]
GO
ALTER TABLE [dbo].[dmcustlabel] ADD  DEFAULT (' ') FOR [cl_printlabel]
GO
ALTER TABLE [dbo].[dmcustlabel] ADD  DEFAULT ('') FOR [cl_userexpr]
GO
ALTER TABLE [dbo].[dmcustlabel] ADD  DEFAULT (' ') FOR [cl_type]
GO
ALTER TABLE [dbo].[dmcwbarcode] ADD  DEFAULT ((0)) FOR [cb_default]
GO
ALTER TABLE [dbo].[dmcwbarcode] ADD  DEFAULT ((1)) FOR [cb_active]
GO
ALTER TABLE [dbo].[dmcwbarcode] ADD  DEFAULT ((0)) FOR [cb_priceend]
GO
ALTER TABLE [dbo].[dmcwbarcode] ADD  DEFAULT ((0)) FOR [cb_pricestart]
GO
ALTER TABLE [dbo].[dmcwbarcode] ADD  DEFAULT ((0)) FOR [cb_partend]
GO
ALTER TABLE [dbo].[dmcwbarcode] ADD  DEFAULT ((0)) FOR [cb_partstart]
GO
ALTER TABLE [dbo].[dmcwbarcode] ADD  DEFAULT ((0)) FOR [cb_length]
GO
ALTER TABLE [dbo].[dmcwbarcode] ADD  DEFAULT ('') FOR [cb_name]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ('') FOR [d1_table]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ('') FOR [d1_title]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ('') FOR [d1_type]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ('') FOR [d1_picture]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_require]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_unique]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_min]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_max]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_seq]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((1)) FOR [d1_active]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_calc]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ('') FOR [d1_prog]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ('') FOR [d1_field]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_partforms]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((1)) FOR [d1_sort]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_usecaptions]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_firecalcs]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_includeindsd]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_srnumber]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ('') FOR [d1_searchboxoverride]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((0)) FOR [d1_copytobackorder]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ('') FOR [d1_defaultvalue]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ('') FOR [d1_defaultmemo]
GO
ALTER TABLE [dbo].[dmd1] ADD  DEFAULT ((1)) FOR [d1_syncmaster]
GO
ALTER TABLE [dbo].[dmd3] ADD  DEFAULT ((0)) FOR [d3_d1id]
GO
ALTER TABLE [dbo].[dmd3] ADD  DEFAULT ('') FOR [d3_value]
GO
ALTER TABLE [dbo].[dmd3] ADD  DEFAULT ('') FOR [d3_memo]
GO
ALTER TABLE [dbo].[dmd3] ADD  DEFAULT ((1)) FOR [d3_active]
GO
ALTER TABLE [dbo].[dmd3] ADD  DEFAULT ((0)) FOR [d3_c2id]
GO
ALTER TABLE [dbo].[dmd3] ADD  DEFAULT ((0)) FOR [d3_default]
GO
ALTER TABLE [dbo].[dmdash] ADD  DEFAULT ('') FOR [da_name]
GO
ALTER TABLE [dbo].[dmdash] ADD  DEFAULT ((1)) FOR [da_active]
GO
ALTER TABLE [dbo].[dmdash] ADD  DEFAULT ('Combined Report') FOR [da_type]
GO
ALTER TABLE [dbo].[dmdash] ADD  DEFAULT ('All') FOR [da_mobacctype]
GO
ALTER TABLE [dbo].[dmdash] ADD  DEFAULT ('') FOR [da_gridname]
GO
ALTER TABLE [dbo].[dmdash] ADD  DEFAULT ((0)) FOR [da_c2id]
GO
ALTER TABLE [dbo].[dmdash] ADD  DEFAULT ('') FOR [da_prefilter]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_daid]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_brid]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_seq]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_start]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_end]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_descrip]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_filters]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_gridtype]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_display]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_formname]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_b2id]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_folder]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_advfilters]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_display2]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_advfilters2]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_favorite]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_grid]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_threshold]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_thresholdylw]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_thresholdred]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_sortorder]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_sortfields]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_sortsay]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('Actual Value') FOR [d2_sumtype]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('99,999,999.99') FOR [d2_sumformat]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_master]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ((0)) FOR [d2_jointo]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_jointocol]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_joinfromcol]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_joinalias]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_parameters]
GO
ALTER TABLE [dbo].[dmdash2] ADD  DEFAULT ('') FOR [d2_customfilters]
GO
ALTER TABLE [dbo].[dmdash3] ADD  DEFAULT ((0)) FOR [d3_daid]
GO
ALTER TABLE [dbo].[dmdash3] ADD  DEFAULT ((0)) FOR [d3_ugid]
GO
ALTER TABLE [dbo].[dmdash3] ADD  DEFAULT ((0)) FOR [d3_usid]
GO
ALTER TABLE [dbo].[dmdashparams] ADD  DEFAULT ((0)) FOR [dp_d2id]
GO
ALTER TABLE [dbo].[dmdashparams] ADD  DEFAULT ((0)) FOR [dp_index]
GO
ALTER TABLE [dbo].[dmdashparams] ADD  DEFAULT ('') FOR [dp_type]
GO
ALTER TABLE [dbo].[dmdashparams] ADD  DEFAULT ('') FOR [dp_value]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('') FOR [de_for]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_fornum]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('') FOR [de_forname]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('') FOR [de_on]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_onnum]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('') FOR [de_onname]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('') FOR [de_type]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_typenum]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_minimum]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT (NULL) FOR [de_start]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT (NULL) FOR [de_end]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((1)) FOR [de_active]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_waid]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('') FOR [de_descrip]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_override]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('to_orddate') FOR [de_basedon]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_unid]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('Specific Item') FOR [de_minbasis]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_fcid]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_frtcost]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_minunid]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('') FOR [de_expression]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ('dttord') FOR [de_table]
GO
ALTER TABLE [dbo].[dmdeal] ADD  DEFAULT ((0)) FOR [de_reid]
GO
ALTER TABLE [dbo].[dmdgrp] ADD  DEFAULT ('') FOR [dg_name]
GO
ALTER TABLE [dbo].[dmdgrp] ADD  DEFAULT ((1)) FOR [dg_active]
GO
ALTER TABLE [dbo].[dmdgrp] ADD  DEFAULT ((0)) FOR [dg_default]
GO
ALTER TABLE [dbo].[dmdgrp] ADD  DEFAULT ((0)) FOR [dg_consolidate]
GO
ALTER TABLE [dbo].[dmdgrp] ADD  DEFAULT ('') FOR [dg_type]
GO
ALTER TABLE [dbo].[dmdgrp] ADD  DEFAULT ((0)) FOR [dg_allpagenum]
GO
ALTER TABLE [dbo].[dmdgrp2] ADD  DEFAULT ((0)) FOR [d2_dgid]
GO
ALTER TABLE [dbo].[dmdgrp2] ADD  DEFAULT ('') FOR [d2_report]
GO
ALTER TABLE [dbo].[dmdgrp2] ADD  DEFAULT ((0)) FOR [d2_seq]
GO
ALTER TABLE [dbo].[dmdgrp2] ADD  DEFAULT ('') FOR [d2_partform]
GO
ALTER TABLE [dbo].[dmdgrp2] ADD  DEFAULT ('') FOR [d2_printwhen]
GO
ALTER TABLE [dbo].[dmdgrp2] ADD  DEFAULT ((0)) FOR [d2_dcid]
GO
ALTER TABLE [dbo].[dmdgrp2] ADD  DEFAULT ('') FOR [d2_attachedrec]
GO
ALTER TABLE [dbo].[dmdgrp2] ADD  DEFAULT ((0)) FOR [d2_ptid]
GO
ALTER TABLE [dbo].[dmdngr] ADD  DEFAULT ('') FOR [dn_name]
GO
ALTER TABLE [dbo].[dmdngr] ADD  DEFAULT ('') FOR [dn_hazard]
GO
ALTER TABLE [dbo].[dmdngr] ADD  DEFAULT ('') FOR [dn_packgroup]
GO
ALTER TABLE [dbo].[dmdngr] ADD  DEFAULT ((0)) FOR [dn_piid]
GO
ALTER TABLE [dbo].[dmdngr] ADD  DEFAULT ('') FOR [dn_regnum]
GO
ALTER TABLE [dbo].[dmdngr] ADD  DEFAULT ('') FOR [dn_shipname]
GO
ALTER TABLE [dbo].[dmdngr] ADD  DEFAULT ((1)) FOR [dn_active]
GO
ALTER TABLE [dbo].[dmdngr] ADD  DEFAULT ('') FOR [dn_subrisk]
GO
ALTER TABLE [dbo].[dmdngr] ADD  DEFAULT ('') FOR [dn_techname]
GO
ALTER TABLE [dbo].[dmdoccat] ADD  DEFAULT ('') FOR [dc_name]
GO
ALTER TABLE [dbo].[dmdoccat] ADD  DEFAULT ((1)) FOR [dc_active]
GO
ALTER TABLE [dbo].[dmdoccat] ADD  DEFAULT ((0)) FOR [dc_default]
GO
ALTER TABLE [dbo].[dmdoccat] ADD  DEFAULT ((0)) FOR [dc_esigrequired]
GO
ALTER TABLE [dbo].[dmdoccat2] ADD  DEFAULT ((0)) FOR [d2_access]
GO
ALTER TABLE [dbo].[dmdoccat2] ADD  DEFAULT ((0)) FOR [d2_dcid]
GO
ALTER TABLE [dbo].[dmdoccat2] ADD  DEFAULT ((0)) FOR [d2_ugid]
GO
ALTER TABLE [dbo].[dmdoccat2] ADD  DEFAULT ((0)) FOR [d2_usid]
GO
ALTER TABLE [dbo].[dmdock] ADD  DEFAULT ('') FOR [do_name]
GO
ALTER TABLE [dbo].[dmdock] ADD  DEFAULT ((1)) FOR [do_active]
GO
ALTER TABLE [dbo].[dmdock] ADD  DEFAULT ((0)) FOR [do_waid]
GO
ALTER TABLE [dbo].[dmdock] ADD  DEFAULT ('All') FOR [do_trantype]
GO
ALTER TABLE [dbo].[dmdock] ADD  DEFAULT ((0)) FOR [do_reid]
GO
ALTER TABLE [dbo].[dmdockloc] ADD  DEFAULT ((0)) FOR [dl_loid]
GO
ALTER TABLE [dbo].[dmdockloc] ADD  DEFAULT ((0)) FOR [dl_seq]
GO
ALTER TABLE [dbo].[dmdockloc] ADD  DEFAULT ((0)) FOR [dl_doid]
GO
ALTER TABLE [dbo].[dmdockloc] ADD  DEFAULT ((0)) FOR [dl_anchor]
GO
ALTER TABLE [dbo].[dmecommdoccat] ADD  DEFAULT ((0)) FOR [ed_dcid]
GO
ALTER TABLE [dbo].[dmecommdoccat] ADD  DEFAULT ('') FOR [ed_type]
GO
ALTER TABLE [dbo].[dmecommdoccat] ADD  DEFAULT ((0)) FOR [ed_csid]
GO
ALTER TABLE [dbo].[dmecommprod] ADD  DEFAULT ('') FOR [ep_name]
GO
ALTER TABLE [dbo].[dmecommprod] ADD  DEFAULT ('') FOR [ep_descrip]
GO
ALTER TABLE [dbo].[dmecommprod] ADD  DEFAULT ((0)) FOR [ep_csid]
GO
ALTER TABLE [dbo].[dmecommprod] ADD  DEFAULT ('') FOR [ep_notes]
GO
ALTER TABLE [dbo].[dmecommprod] ADD  DEFAULT ((1)) FOR [ep_active]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_name]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_ordtype]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((0)) FOR [ed_auto]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((0)) FOR [ed_freq]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_srcpath]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((1)) FOR [ed_active]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_flddel]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_linedel]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_fldother]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_lineother]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_sample]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_neword]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_newline]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((0)) FOR [ed_template]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_condtype]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_dstpath]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_skipline]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_ftpserver]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_ftpuser]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_ftppass]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_failpath]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((0)) FOR [ed_invssl]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((0)) FOR [ed_copyheader]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((1)) FOR [ed_binary]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((1)) FOR [ed_partialprocess]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((0)) FOR [ed_sftp]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((0)) FOR [ed_skipblanklines]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('s') FOR [ed_type]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ((0)) FOR [ed_ftpport]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_deleteline]
GO
ALTER TABLE [dbo].[dmedi] ADD  DEFAULT ('') FOR [ed_notes]
GO
ALTER TABLE [dbo].[dmedi2] ADD  DEFAULT ((0)) FOR [e2_edid]
GO
ALTER TABLE [dbo].[dmedi2] ADD  DEFAULT ('') FOR [e2_ifstate]
GO
ALTER TABLE [dbo].[dmedi2] ADD  DEFAULT ('') FOR [e2_parsecode]
GO
ALTER TABLE [dbo].[dmedi2] ADD  DEFAULT ('') FOR [e2_fldname]
GO
ALTER TABLE [dbo].[dmedi2] ADD  DEFAULT ('') FOR [e2_exprtype]
GO
ALTER TABLE [dbo].[dmedi2] ADD  DEFAULT ('') FOR [e2_table]
GO
ALTER TABLE [dbo].[dmedi2] ADD  DEFAULT ('') FOR [e2_lookexpr]
GO
ALTER TABLE [dbo].[dmedi2] ADD  DEFAULT ((0)) FOR [e2_sameas]
GO
ALTER TABLE [dbo].[dmedi3] ADD  DEFAULT ((0)) FOR [e3_time]
GO
ALTER TABLE [dbo].[dmedi3] ADD  DEFAULT (' ') FOR [e3_file]
GO
ALTER TABLE [dbo].[dmedi3] ADD  DEFAULT ((0)) FOR [e3_result]
GO
ALTER TABLE [dbo].[dmedi3] ADD  DEFAULT (' ') FOR [e3_error]
GO
ALTER TABLE [dbo].[dmemail] ADD  DEFAULT ('') FOR [em_name]
GO
ALTER TABLE [dbo].[dmemail] ADD  DEFAULT ((1)) FOR [em_active]
GO
ALTER TABLE [dbo].[dmemail] ADD  DEFAULT ('') FOR [em_subject]
GO
ALTER TABLE [dbo].[dmemail] ADD  DEFAULT ('') FOR [em_body]
GO
ALTER TABLE [dbo].[dmemail] ADD  DEFAULT ((1)) FOR [em_html]
GO
ALTER TABLE [dbo].[dmemail] ADD  DEFAULT ('') FOR [em_footer]
GO
ALTER TABLE [dbo].[dmemail2] ADD  DEFAULT ((0)) FOR [e2_emid]
GO
ALTER TABLE [dbo].[dmemail2] ADD  DEFAULT ((0)) FOR [e2_piid]
GO
ALTER TABLE [dbo].[dmemail2] ADD  DEFAULT ((0)) FOR [e2_seq]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ('') FOR [en_name]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ((1)) FOR [en_active]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ((0)) FOR [en_default]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ('') FOR [en_path]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ('') FOR [en_labcalc]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ((0)) FOR [en_burden]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ('Folder') FOR [en_type]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ('') FOR [en_database]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ('') FOR [en_engpkg]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ((0)) FOR [en_prid]
GO
ALTER TABLE [dbo].[dmeng] ADD  DEFAULT ('') FOR [en_groupby]
GO
ALTER TABLE [dbo].[dmengfields] ADD  DEFAULT ('') FOR [ef_fieldname]
GO
ALTER TABLE [dbo].[dmengfields] ADD  DEFAULT ('') FOR [ef_userfield]
GO
ALTER TABLE [dbo].[dmengfields] ADD  DEFAULT ((0)) FOR [ef_enid]
GO
ALTER TABLE [dbo].[dmexai] ADD  DEFAULT ((1)) FOR [ex_active]
GO
ALTER TABLE [dbo].[dmexai] ADD  DEFAULT ((0)) FOR [ex_ai]
GO
ALTER TABLE [dbo].[dmexai] ADD  DEFAULT ('') FOR [ex_form]
GO
ALTER TABLE [dbo].[dmexai] ADD  DEFAULT ('Exclude') FOR [ex_type]
GO
ALTER TABLE [dbo].[dmexai] ADD  DEFAULT ((0)) FOR [ex_toai]
GO
ALTER TABLE [dbo].[dmexai] ADD  DEFAULT ('') FOR [ex_table]
GO
ALTER TABLE [dbo].[dmexai] ADD  DEFAULT ((0)) FOR [ex_recid]
GO
ALTER TABLE [dbo].[dmexai] ADD  DEFAULT ((0)) FOR [ex_unid]
GO
ALTER TABLE [dbo].[dmexcl] ADD  DEFAULT ('') FOR [ex_name]
GO
ALTER TABLE [dbo].[dmexcl] ADD  DEFAULT ((1)) FOR [ex_active]
GO
ALTER TABLE [dbo].[dmexcl2] ADD  DEFAULT ((0)) FOR [e2_exid]
GO
ALTER TABLE [dbo].[dmexcl2] ADD  DEFAULT ((0)) FOR [e2_prid]
GO
ALTER TABLE [dbo].[dmexpprof] ADD  DEFAULT ('') FOR [ep_name]
GO
ALTER TABLE [dbo].[dmexpprof] ADD  DEFAULT ((0)) FOR [ep_type]
GO
ALTER TABLE [dbo].[dmexpprof] ADD  DEFAULT ((1)) FOR [ep_active]
GO
ALTER TABLE [dbo].[dmexpprof] ADD  DEFAULT ((0)) FOR [ep_default]
GO
ALTER TABLE [dbo].[dmexpprof] ADD  DEFAULT ((0)) FOR [ep_dsttype]
GO
ALTER TABLE [dbo].[dmexpprof] ADD  DEFAULT ((0)) FOR [ep_details]
GO
ALTER TABLE [dbo].[dmexpprof] ADD  DEFAULT ((0)) FOR [ep_formattype]
GO
ALTER TABLE [dbo].[dmexpprof] ADD  DEFAULT ((0)) FOR [ep_formatid]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ((0)) FOR [ft_waid1]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ((0)) FOR [ft_waid2]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ((0)) FOR [ft_leaddays]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ((0)) FOR [ft_useleaddays]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ((0)) FOR [ft_elimcredit]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ((0)) FOR [ft_elimdebit]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ((1)) FOR [ft_active]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ((1)) FOR [ft_seq]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ('all') FOR [ft_for]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ((0)) FOR [ft_fornum]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ('both') FOR [ft_icxmrp]
GO
ALTER TABLE [dbo].[dmfactran] ADD  DEFAULT ('Follow System Options') FOR [ft_crossrevict]
GO
ALTER TABLE [dbo].[dmfcur] ADD  DEFAULT ('') FOR [fc_name]
GO
ALTER TABLE [dbo].[dmfcur] ADD  DEFAULT ((1)) FOR [fc_rate]
GO
ALTER TABLE [dbo].[dmfcur] ADD  DEFAULT ((1)) FOR [fc_active]
GO
ALTER TABLE [dbo].[dmfcur] ADD  DEFAULT ((0)) FOR [fc_default]
GO
ALTER TABLE [dbo].[dmfcur] ADD  DEFAULT ('$') FOR [fc_symbol]
GO
ALTER TABLE [dbo].[dmfcur] ADD  DEFAULT ('dollars') FOR [fc_prtsay]
GO
ALTER TABLE [dbo].[dmfcur] ADD  DEFAULT ((0)) FOR [fc_currgain]
GO
ALTER TABLE [dbo].[dmfcur] ADD  DEFAULT ((1)) FOR [fc_autoconv]
GO
ALTER TABLE [dbo].[dmfcur2] ADD  DEFAULT ((0)) FOR [f2_fcid]
GO
ALTER TABLE [dbo].[dmfcur2] ADD  DEFAULT ((0)) FOR [f2_rate]
GO
ALTER TABLE [dbo].[dmfcur2] ADD  DEFAULT (NULL) FOR [f2_date]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ('') FOR [fe_name]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ((1)) FOR [fe_active]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ((1)) FOR [fe_quant]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ((0)) FOR [fe_endpt]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ((0)) FOR [fe_price]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ('') FOR [fe_notes]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ((0)) FOR [fe_multiple]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ((1)) FOR [fe_comm]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ((1)) FOR [fe_usedeals]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ((0)) FOR [fe_usepromos]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ((0)) FOR [fe_required]
GO
ALTER TABLE [dbo].[dmfeat] ADD  DEFAULT ('') FOR [fe_suffix]
GO
ALTER TABLE [dbo].[dmfeat2] ADD  DEFAULT ((0)) FOR [f2_parent]
GO
ALTER TABLE [dbo].[dmfeat2] ADD  DEFAULT ((0)) FOR [f2_child]
GO
ALTER TABLE [dbo].[dmfeat2] ADD  DEFAULT ((0)) FOR [f2_prid]
GO
ALTER TABLE [dbo].[dmfeat2] ADD  DEFAULT ((0)) FOR [f2_seq]
GO
ALTER TABLE [dbo].[dmfeat2] ADD  DEFAULT ((0)) FOR [f2_prid2]
GO
ALTER TABLE [dbo].[dmfeat2] ADD  DEFAULT ((0)) FOR [f2_caid]
GO
ALTER TABLE [dbo].[dmfeat2] ADD  DEFAULT ((0)) FOR [f2_c2id]
GO
ALTER TABLE [dbo].[dmfeat2] ADD  DEFAULT ((0)) FOR [f2_default]
GO
ALTER TABLE [dbo].[dmfeat3] ADD  DEFAULT ((0)) FOR [f3_prid]
GO
ALTER TABLE [dbo].[dmfeat3] ADD  DEFAULT ((0)) FOR [f3_feid]
GO
ALTER TABLE [dbo].[dmfeat4] ADD  DEFAULT ((0)) FOR [f4_parent]
GO
ALTER TABLE [dbo].[dmfeat4] ADD  DEFAULT ((0)) FOR [f4_child]
GO
ALTER TABLE [dbo].[dmfeat4] ADD  DEFAULT ((0)) FOR [f4_childvalue]
GO
ALTER TABLE [dbo].[dmfeat4] ADD  DEFAULT ((0)) FOR [f4_parentvalue]
GO
ALTER TABLE [dbo].[dmfeat4] ADD  DEFAULT ((0)) FOR [f4_exclude]
GO
ALTER TABLE [dbo].[dmfeat4] ADD  DEFAULT ((0)) FOR [f4_nocost]
GO
ALTER TABLE [dbo].[dmfeat4] ADD  DEFAULT ((0)) FOR [f4_caid]
GO
ALTER TABLE [dbo].[dmfeat4] ADD  DEFAULT ((0)) FOR [f4_c2id]
GO
ALTER TABLE [dbo].[dmfeat4] ADD  DEFAULT ((0)) FOR [f4_prid]
GO
ALTER TABLE [dbo].[dmfeat5] ADD  DEFAULT ('') FOR [f5_table]
GO
ALTER TABLE [dbo].[dmfeat5] ADD  DEFAULT ((0)) FOR [f5_recid]
GO
ALTER TABLE [dbo].[dmfeat5] ADD  DEFAULT ((0)) FOR [f5_feid]
GO
ALTER TABLE [dbo].[dmfeat5] ADD  DEFAULT ((0)) FOR [f5_feid2]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ((0)) FOR [f6_prid]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ((0)) FOR [f6_price]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ('Available') FOR [f6_avail]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ((0)) FOR [f6_quant]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ('') FOR [f6_notes]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ((0)) FOR [f6_f2id]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ((0)) FOR [f6_parent]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ((0)) FOR [f6_caid]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ((0)) FOR [f6_c2id]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ((0)) FOR [f6_comm]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT ((0)) FOR [f6_activeover]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT (NULL) FOR [f6_start]
GO
ALTER TABLE [dbo].[dmfeat6] ADD  DEFAULT (NULL) FOR [f6_end]
GO
ALTER TABLE [dbo].[dmfilt] ADD  DEFAULT ('') FOR [fi_name]
GO
ALTER TABLE [dbo].[dmfilt] ADD  DEFAULT ((0)) FOR [fi_usid]
GO
ALTER TABLE [dbo].[dmfilt] ADD  DEFAULT ('') FOR [fi_layout]
GO
ALTER TABLE [dbo].[dmfilt2] ADD  DEFAULT ('') FOR [f2_field]
GO
ALTER TABLE [dbo].[dmfilt2] ADD  DEFAULT ('') FOR [f2_logical]
GO
ALTER TABLE [dbo].[dmfilt2] ADD  DEFAULT ('') FOR [f2_oper]
GO
ALTER TABLE [dbo].[dmfilt2] ADD  DEFAULT ('') FOR [f2_value]
GO
ALTER TABLE [dbo].[dmfilt2] ADD  DEFAULT ((0)) FOR [f2_fiid]
GO
ALTER TABLE [dbo].[dmfilt2] ADD  DEFAULT ('Value') FOR [f2_type]
GO
ALTER TABLE [dbo].[dmfiltsort] ADD  DEFAULT ('') FOR [fs_field]
GO
ALTER TABLE [dbo].[dmfiltsort] ADD  DEFAULT ('asc') FOR [fs_order]
GO
ALTER TABLE [dbo].[dmfiltsort] ADD  DEFAULT ((0)) FOR [fs_fiid]
GO
ALTER TABLE [dbo].[dmfiltsort] ADD  DEFAULT ((0)) FOR [fs_seq]
GO
ALTER TABLE [dbo].[dmfin] ADD  DEFAULT ('') FOR [fi_name]
GO
ALTER TABLE [dbo].[dmfin] ADD  DEFAULT ((1)) FOR [fi_active]
GO
ALTER TABLE [dbo].[dmfin] ADD  DEFAULT ('') FOR [fi_header]
GO
ALTER TABLE [dbo].[dmfin] ADD  DEFAULT ('finstmt1') FOR [fi_report]
GO
ALTER TABLE [dbo].[dmfin] ADD  DEFAULT ('Balance sheet') FOR [fi_type]
GO
ALTER TABLE [dbo].[dmfin] ADD  DEFAULT ('a') FOR [fi_display]
GO
ALTER TABLE [dbo].[dmfin] ADD  DEFAULT ((1)) FOR [fi_fgid]
GO
ALTER TABLE [dbo].[dmfin] ADD  DEFAULT ('') FOR [fi_mask]
GO
ALTER TABLE [dbo].[dmfin] ADD  DEFAULT ('') FOR [fi_footer]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((0)) FOR [f2_fiid]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('') FOR [f2_title]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((0)) FOR [f2_sorter]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('') FOR [f2_format]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((0)) FOR [f2_extra]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((0)) FOR [f2_indent]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((0)) FOR [f2_reverse]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('') FOR [f2_account]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((0)) FOR [f2_currsign]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('') FOR [f2_calcname]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT (' ') FOR [f2_calcexpr]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((1)) FOR [f2_visible]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((0)) FOR [f2_hidezero]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((0)) FOR [f2_pos]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('0') FOR [f2_posval]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ((0)) FOR [f2_bold]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('e') FOR [f2_baltype]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('None') FOR [f2_underline]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('') FOR [f2_expression]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('Both') FOR [f2_display]
GO
ALTER TABLE [dbo].[dmfin2] ADD  DEFAULT ('') FOR [f2_mask]
GO
ALTER TABLE [dbo].[dmfingrp] ADD  DEFAULT ('') FOR [fg_name]
GO
ALTER TABLE [dbo].[dmfingrp] ADD  DEFAULT ((1)) FOR [fg_active]
GO
ALTER TABLE [dbo].[dmfingrp] ADD  DEFAULT ((0)) FOR [fg_default]
GO
ALTER TABLE [dbo].[dmfingrp2] ADD  DEFAULT ((0)) FOR [f2_fgid]
GO
ALTER TABLE [dbo].[dmfingrp2] ADD  DEFAULT ((0)) FOR [f2_ugid]
GO
ALTER TABLE [dbo].[dmfingrp2] ADD  DEFAULT ((0)) FOR [f2_access]
GO
ALTER TABLE [dbo].[dmfingrp2] ADD  DEFAULT ((0)) FOR [f2_usid]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ('') FOR [fo_name]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ('') FOR [fo_notes]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ((0)) FOR [fo_active]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ((0)) FOR [fo_usid]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ('Months') FOR [fo_bucktype]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ((0)) FOR [fo_fcid]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ((0)) FOR [fo_fcrate]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ('Months') FOR [fo_mrpbucktype]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ('Last day') FOR [fo_mrpbuckdate]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ((0)) FOR [fo_exmrp]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT (NULL) FOR [fo_created]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ((1)) FOR [fo_incmrp]
GO
ALTER TABLE [dbo].[dmforecast] ADD  DEFAULT ((0)) FOR [fo_bucketcount]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_foid]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT (NULL) FOR [f2_date]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_quant]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_prid]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_biid]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_shid]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_waid]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_price]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_origquant]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_stderr]
GO
ALTER TABLE [dbo].[dmforecast2] ADD  DEFAULT ((0)) FOR [f2_historical]
GO
ALTER TABLE [dbo].[dmforecastdateex] ADD  DEFAULT (NULL) FOR [fd_date]
GO
ALTER TABLE [dbo].[dmforecastdateex] ADD  DEFAULT ('') FOR [fd_day]
GO
ALTER TABLE [dbo].[dmforecastdateex] ADD  DEFAULT ((0)) FOR [fd_foid]
GO
ALTER TABLE [dbo].[dmform] ADD  DEFAULT ('') FOR [fo_name]
GO
ALTER TABLE [dbo].[dmform] ADD  DEFAULT ((1)) FOR [fo_active]
GO
ALTER TABLE [dbo].[dmform] ADD  DEFAULT ((0)) FOR [fo_default]
GO
ALTER TABLE [dbo].[dmfrominv] ADD  DEFAULT ((0)) FOR [fr_frominvprid]
GO
ALTER TABLE [dbo].[dmfrominv] ADD  DEFAULT ((0)) FOR [fr_prid]
GO
ALTER TABLE [dbo].[dmfrominv] ADD  DEFAULT ('') FOR [fr_type]
GO
ALTER TABLE [dbo].[dmfrominv] ADD  DEFAULT ((0)) FOR [fr_markup]
GO
ALTER TABLE [dbo].[dmfrominv] ADD  DEFAULT ('') FOR [fr_quantexpr]
GO
ALTER TABLE [dbo].[dmfrominv] ADD  DEFAULT ((1)) FOR [fr_facilityfilter]
GO
ALTER TABLE [dbo].[dmfrominv] ADD  DEFAULT ('quantity') FOR [fr_catchwgt]
GO
ALTER TABLE [dbo].[dmfrominv] ADD  DEFAULT ('') FOR [fr_notesexpr]
GO
ALTER TABLE [dbo].[dmfrominv] ADD  DEFAULT ((0)) FOR [fr_bymasterlot]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ('') FOR [fr_name]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ((0)) FOR [fr_dfltar]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ((0)) FOR [fr_dfltap]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ((1)) FOR [fr_active]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ('') FOR [fr_arap]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ((0)) FOR [fr_retain]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ((0)) FOR [fr_easypost]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ((0)) FOR [fr_easypostsig]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ('None') FOR [fr_easypostprompt]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ((0)) FOR [fr_easypostemail]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ((0)) FOR [fr_easypostsms]
GO
ALTER TABLE [dbo].[dmfrt] ADD  DEFAULT ('') FOR [fr_easypostexpr]
GO
ALTER TABLE [dbo].[dmgiftcard] ADD  DEFAULT ((0)) FOR [gc_amount]
GO
ALTER TABLE [dbo].[dmgiftcard] ADD  DEFAULT ((0)) FOR [gc_number]
GO
ALTER TABLE [dbo].[dmgiftcard] ADD  DEFAULT (NULL) FOR [gc_created]
GO
ALTER TABLE [dbo].[dmgiftcard] ADD  DEFAULT (NULL) FOR [gc_closed]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((0)) FOR [gr_usid]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((0)) FOR [gr_type]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_sumtitle]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_groupontitle]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('day') FOR [gr_groupby]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((0)) FOR [gr_pgid]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_graphbytitle]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((0)) FOR [gr_d2id]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_name]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_sumsmask]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_graphbyfield]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_sumfield]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_grouponfield]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((0)) FOR [gr_numfinperiods]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((0)) FOR [gr_thresholdred]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((0)) FOR [gr_thresholdylw]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('Graph By Value') FOR [gr_sortby]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('sum') FOR [gr_calc]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((0)) FOR [gr_futfinperiods]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_graphbyexp]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('') FOR [gr_grouponexp]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((50)) FOR [gr_cutoutpercent]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ((0)) FOR [gr_swapaxes]
GO
ALTER TABLE [dbo].[dmgraph] ADD  DEFAULT ('None') FOR [gr_trendlines]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ('') FOR [gr_name]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ((1)) FOR [gr_active]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ((0)) FOR [gr_default]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ((0)) FOR [gr_pastday]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ((0)) FOR [gr_exday]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ((0)) FOR [gr_credlim]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ((0)) FOR [gr_exceed]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT (NULL) FOR [gr_credhld]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ('') FOR [gr_collect]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT (NULL) FOR [gr_lastcred]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ((0)) FOR [gr_credflag]
GO
ALTER TABLE [dbo].[dmgrp] ADD  DEFAULT ((0)) FOR [gr_creddueshipdays]
GO
ALTER TABLE [dbo].[dmimpgrp] ADD  DEFAULT ('') FOR [ig_name]
GO
ALTER TABLE [dbo].[dmimpgrp] ADD  DEFAULT ((1)) FOR [ig_active]
GO
ALTER TABLE [dbo].[dmimpgrp2] ADD  DEFAULT ((0)) FOR [g2_imid]
GO
ALTER TABLE [dbo].[dmimpgrp2] ADD  DEFAULT ((0)) FOR [g2_igid]
GO
ALTER TABLE [dbo].[dmimpgrp2] ADD  DEFAULT ((0)) FOR [g2_sort]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_name]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_srcfile]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_srctype]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_dsttbl]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_srctbl]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_condition]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_dbpass]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_dbserver]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_dbname]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_dbuser]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('Full') FOR [im_update]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT (NULL) FOR [im_expires]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ((1)) FOR [im_active]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ((0)) FOR [im_freq]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ('') FOR [im_notes]
GO
ALTER TABLE [dbo].[dmimport] ADD  DEFAULT ((0)) FOR [im_seq]
GO
ALTER TABLE [dbo].[dmimport2] ADD  DEFAULT ('') FOR [i2_dstfld]
GO
ALTER TABLE [dbo].[dmimport2] ADD  DEFAULT ('') FOR [i2_fldexpr]
GO
ALTER TABLE [dbo].[dmimport2] ADD  DEFAULT ((0)) FOR [i2_imid]
GO
ALTER TABLE [dbo].[dmimport2] ADD  DEFAULT ((0)) FOR [i2_reqd]
GO
ALTER TABLE [dbo].[dmimport2] ADD  DEFAULT ((0)) FOR [i2_desig]
GO
ALTER TABLE [dbo].[dmimport2] ADD  DEFAULT ('') FOR [i2_relfld]
GO
ALTER TABLE [dbo].[dmimport2] ADD  DEFAULT ((0)) FOR [i2_addrec]
GO
ALTER TABLE [dbo].[dmimport2] ADD  DEFAULT ((0)) FOR [i2_skip]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_dbname]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_dbpass]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_dbserver]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_dbuser]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ((0)) FOR [i3_imid]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_srcfile]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_srctbl]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_srctype]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_mapfrom]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_mapto]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_maptable]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_sql]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_notes]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_dbtable]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ((0)) FOR [i3_sheet]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_dstpath]
GO
ALTER TABLE [dbo].[dmimport3] ADD  DEFAULT ('') FOR [i3_srcpath]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT (NULL) FOR [is_lastrun]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ((0)) FOR [is_imid]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ('') FOR [is_name]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ('Week') FOR [is_type]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ((1)) FOR [is_day]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ('00:00:00') FOR [is_time]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT (NULL) FOR [is_nextrun]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ('') FOR [is_schedtype]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ((0)) FOR [is_minutes]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ((0)) FOR [is_recid]
GO
ALTER TABLE [dbo].[dmimportsched] ADD  DEFAULT ((0)) FOR [is_seq]
GO
ALTER TABLE [dbo].[dmjcat] ADD  DEFAULT ('') FOR [jc_name]
GO
ALTER TABLE [dbo].[dmjcat] ADD  DEFAULT ((1)) FOR [jc_active]
GO
ALTER TABLE [dbo].[dmjcat] ADD  DEFAULT ((0)) FOR [jc_default]
GO
ALTER TABLE [dbo].[dmjcat] ADD  DEFAULT ('Follow System Options') FOR [jc_issuetype]
GO
ALTER TABLE [dbo].[dmjcat] ADD  DEFAULT ((0)) FOR [jc_jobstage]
GO
ALTER TABLE [dbo].[dmjcat] ADD  DEFAULT ('None') FOR [jc_esigtype]
GO
ALTER TABLE [dbo].[dmjcat] ADD  DEFAULT ((0)) FOR [jc_issuejobfin]
GO
ALTER TABLE [dbo].[dmjcat] ADD  DEFAULT ((0)) FOR [jc_esigcounts]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ('') FOR [la_name]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((1)) FOR [la_active]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_weekot]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_dayot]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_otfactr]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyin]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyout]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_latein]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_lateout]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealin3]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealin]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealin2]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealin4]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_nostart]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actin]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actout]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actin2]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actin3]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actin4]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actin5]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actout2]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actout3]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actout4]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actout5]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealin5]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyin2]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyin3]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyin4]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyin5]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyout2]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyout3]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyout4]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyout5]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_latein2]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_latein3]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_latein4]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_latein5]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_lateout2]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_lateout3]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_lateout4]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_lateout5]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actin6]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actin7]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actout6]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_actout7]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyin6]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyin7]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyout6]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_earlyout7]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_latein6]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_latein7]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_lateout6]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_lateout7]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealin6]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealin7]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealout]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealout2]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealout3]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealout4]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealout5]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealout6]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_mealout7]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_nostart2]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_nostart3]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_nostart4]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_nostart5]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_nostart6]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_nostart7]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_frominvprid]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_ceid]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_opid]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_joid]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_autologout]
GO
ALTER TABLE [dbo].[dmlab] ADD  DEFAULT ((0)) FOR [la_otchid]
GO
ALTER TABLE [dbo].[dmlabel] ADD  DEFAULT ((0)) FOR [la_prid]
GO
ALTER TABLE [dbo].[dmlabel] ADD  DEFAULT ((0)) FOR [la_rdid]
GO
ALTER TABLE [dbo].[dmlabel] ADD  DEFAULT ('') FOR [la_type]
GO
ALTER TABLE [dbo].[dmlabel] ADD  DEFAULT ('') FOR [la_printlabel]
GO
ALTER TABLE [dbo].[dmlabel] ADD  DEFAULT ('') FOR [la_userexpr]
GO
ALTER TABLE [dbo].[dmlabel] ADD  DEFAULT ((0)) FOR [la_parttype]
GO
ALTER TABLE [dbo].[dmlabel] ADD  DEFAULT ((1)) FOR [la_copies]
GO
ALTER TABLE [dbo].[dmlabel] ADD  DEFAULT ('All') FOR [la_app]
GO
ALTER TABLE [dbo].[dmlabel] ADD  DEFAULT ((0)) FOR [la_prtdfltqty]
GO
ALTER TABLE [dbo].[dmlatlng] ADD  DEFAULT ('') FOR [ll_address]
GO
ALTER TABLE [dbo].[dmlatlng] ADD  DEFAULT ((0)) FOR [ll_lat]
GO
ALTER TABLE [dbo].[dmlatlng] ADD  DEFAULT ((0)) FOR [ll_lng]
GO
ALTER TABLE [dbo].[dmletter] ADD  DEFAULT ('') FOR [le_name]
GO
ALTER TABLE [dbo].[dmletter] ADD  DEFAULT ('') FOR [le_doc]
GO
ALTER TABLE [dbo].[dmletter] ADD  DEFAULT ('') FOR [le_table]
GO
ALTER TABLE [dbo].[dmletter] ADD  DEFAULT ((1)) FOR [le_active]
GO
ALTER TABLE [dbo].[dmletter] ADD  DEFAULT ((0)) FOR [le_reid]
GO
ALTER TABLE [dbo].[dmlinkdoc] ADD  DEFAULT ((1)) FOR [li_active]
GO
ALTER TABLE [dbo].[dmlinkdoc] ADD  DEFAULT ('') FOR [li_sourcepath]
GO
ALTER TABLE [dbo].[dmlinkdoc] ADD  DEFAULT ('') FOR [li_destpath]
GO
ALTER TABLE [dbo].[dmlinkdoc] ADD  DEFAULT ('') FOR [li_failpath]
GO
ALTER TABLE [dbo].[dmlinkdoc] ADD  DEFAULT ((0)) FOR [li_freq]
GO
ALTER TABLE [dbo].[dmlinkdoc] ADD  DEFAULT ('') FOR [li_name]
GO
ALTER TABLE [dbo].[dmlinkdoc] ADD  DEFAULT ((0)) FOR [li_dcid]
GO
ALTER TABLE [dbo].[dmlinkdoc] ADD  DEFAULT ('') FOR [li_table]
GO
ALTER TABLE [dbo].[dmlinkdoc] ADD  DEFAULT ('') FOR [li_field]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ('') FOR [lo_name]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ((1)) FOR [lo_active]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ((0)) FOR [lo_ltid]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ((0)) FOR [lo_default]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ((0)) FOR [lo_capacity]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ((0)) FOR [lo_capunid]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ((0)) FOR [lo_haltposting]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ((0)) FOR [lo_seq]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ('') FOR [lo_descrip]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT ((0)) FOR [lo_repmin]
GO
ALTER TABLE [dbo].[dmloc] ADD  DEFAULT (NULL) FOR [lo_counted]
GO
ALTER TABLE [dbo].[dmlocsort] ADD  DEFAULT ((0)) FOR [ls_pyid]
GO
ALTER TABLE [dbo].[dmlocsort] ADD  DEFAULT ((0)) FOR [ls_loid]
GO
ALTER TABLE [dbo].[dmlocsort] ADD  DEFAULT ((1)) FOR [ls_seq]
GO
ALTER TABLE [dbo].[dmlocsort] ADD  DEFAULT ((1)) FOR [ls_active]
GO
ALTER TABLE [dbo].[dmloctype] ADD  DEFAULT ('') FOR [lt_name]
GO
ALTER TABLE [dbo].[dmloctype] ADD  DEFAULT ((1)) FOR [lt_active]
GO
ALTER TABLE [dbo].[dmloctype] ADD  DEFAULT ((0)) FOR [lt_default]
GO
ALTER TABLE [dbo].[dmloctype] ADD  DEFAULT ((1)) FOR [lt_waid]
GO
ALTER TABLE [dbo].[dmloctype] ADD  DEFAULT ('Follow Part') FOR [lt_neginv]
GO
ALTER TABLE [dbo].[dmloctype] ADD  DEFAULT ((0)) FOR [lt_haltposting]
GO
ALTER TABLE [dbo].[dmmarkets] ADD  DEFAULT ('') FOR [ma_name]
GO
ALTER TABLE [dbo].[dmmarkets] ADD  DEFAULT ((1)) FOR [ma_active]
GO
ALTER TABLE [dbo].[dmmarketsubs] ADD  DEFAULT ((0)) FOR [ms_maid]
GO
ALTER TABLE [dbo].[dmmarketsubs] ADD  DEFAULT ('') FOR [ms_name]
GO
ALTER TABLE [dbo].[dmmarketsubs] ADD  DEFAULT ((1)) FOR [ms_active]
GO
ALTER TABLE [dbo].[dmmoverule] ADD  DEFAULT ('') FOR [mr_name]
GO
ALTER TABLE [dbo].[dmmoverule] ADD  DEFAULT ((1)) FOR [mr_active]
GO
ALTER TABLE [dbo].[dmmoverule] ADD  DEFAULT ((0)) FOR [mr_waid]
GO
ALTER TABLE [dbo].[dmmoverule] ADD  DEFAULT ('') FOR [mr_trantype]
GO
ALTER TABLE [dbo].[dmmoverule] ADD  DEFAULT ((0)) FOR [mr_fromzone]
GO
ALTER TABLE [dbo].[dmmoverule] ADD  DEFAULT ((0)) FOR [mr_zonerestrict]
GO
ALTER TABLE [dbo].[dmmoverule] ADD  DEFAULT ((0)) FOR [mr_singleso]
GO
ALTER TABLE [dbo].[dmmoverulesort] ADD  DEFAULT ((0)) FOR [rs_mrid]
GO
ALTER TABLE [dbo].[dmmoverulesort] ADD  DEFAULT ((0)) FOR [rs_seq]
GO
ALTER TABLE [dbo].[dmmoverulesort] ADD  DEFAULT ('') FOR [rs_sort]
GO
ALTER TABLE [dbo].[dmmoverulesort] ADD  DEFAULT ('') FOR [rs_expression]
GO
ALTER TABLE [dbo].[dmmoverulesort] ADD  DEFAULT ('Ascending') FOR [rs_sortorder]
GO
ALTER TABLE [dbo].[dmmrogrp] ADD  DEFAULT ('') FOR [mg_name]
GO
ALTER TABLE [dbo].[dmmrogrp] ADD  DEFAULT ((1)) FOR [mg_active]
GO
ALTER TABLE [dbo].[dmmrpgrp] ADD  DEFAULT ('') FOR [mg_name]
GO
ALTER TABLE [dbo].[dmmrpgrp] ADD  DEFAULT ((1)) FOR [mg_active]
GO
ALTER TABLE [dbo].[dmnote] ADD  DEFAULT ('') FOR [no_name]
GO
ALTER TABLE [dbo].[dmnote] ADD  DEFAULT ('') FOR [no_note]
GO
ALTER TABLE [dbo].[dmnote] ADD  DEFAULT ((1)) FOR [no_active]
GO
ALTER TABLE [dbo].[dmnote] ADD  DEFAULT ('All') FOR [no_category]
GO
ALTER TABLE [dbo].[dmnote] ADD  DEFAULT ((1)) FOR [no_newline]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ('') FOR [op_name]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_workcnt]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_pieces]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_hours]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((1)) FOR [op_active]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_rate]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_chid]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_otchid]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_wip]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_default]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_burden]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_burchid]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_finlab]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_finbur]
GO
ALTER TABLE [dbo].[dmop] ADD  DEFAULT ((0)) FOR [op_certreqd]
GO
ALTER TABLE [dbo].[dmover] ADD  DEFAULT ('') FOR [ov_table]
GO
ALTER TABLE [dbo].[dmover] ADD  DEFAULT ((0)) FOR [ov_recid]
GO
ALTER TABLE [dbo].[dmover] ADD  DEFAULT ((0)) FOR [ov_pos]
GO
ALTER TABLE [dbo].[dmover] ADD  DEFAULT ((0)) FOR [ov_override]
GO
ALTER TABLE [dbo].[dmpackinst] ADD  DEFAULT ((1)) FOR [pi_active]
GO
ALTER TABLE [dbo].[dmpackinst] ADD  DEFAULT ('') FOR [pi_conttype]
GO
ALTER TABLE [dbo].[dmpackinst] ADD  DEFAULT ('') FOR [pi_detail]
GO
ALTER TABLE [dbo].[dmpackinst] ADD  DEFAULT ((0)) FOR [pi_diquant]
GO
ALTER TABLE [dbo].[dmpackinst] ADD  DEFAULT ((0)) FOR [pi_dryice]
GO
ALTER TABLE [dbo].[dmpackinst] ADD  DEFAULT ('') FOR [pi_name]
GO
ALTER TABLE [dbo].[dmpayevent] ADD  DEFAULT ('') FOR [pe_name]
GO
ALTER TABLE [dbo].[dmpayevent] ADD  DEFAULT ((1)) FOR [pe_active]
GO
ALTER TABLE [dbo].[dmpayevent] ADD  DEFAULT ((0)) FOR [pe_default]
GO
ALTER TABLE [dbo].[dmpcat] ADD  DEFAULT ('') FOR [pc_name]
GO
ALTER TABLE [dbo].[dmpcat] ADD  DEFAULT ((1)) FOR [pc_active]
GO
ALTER TABLE [dbo].[dmpcat] ADD  DEFAULT ((0)) FOR [pc_default]
GO
ALTER TABLE [dbo].[dmper] ADD  DEFAULT ('') FOR [pe_name]
GO
ALTER TABLE [dbo].[dmper] ADD  DEFAULT ((1)) FOR [pe_active]
GO
ALTER TABLE [dbo].[dmper] ADD  DEFAULT ((1)) FOR [pe_pgid]
GO
ALTER TABLE [dbo].[dmper] ADD  DEFAULT ((0)) FOR [pe_trailingmonths]
GO
ALTER TABLE [dbo].[dmper2] ADD  DEFAULT ((0)) FOR [p2_peid]
GO
ALTER TABLE [dbo].[dmper2] ADD  DEFAULT ('') FOR [p2_name]
GO
ALTER TABLE [dbo].[dmper2] ADD  DEFAULT (NULL) FOR [p2_start]
GO
ALTER TABLE [dbo].[dmper2] ADD  DEFAULT (NULL) FOR [p2_end]
GO
ALTER TABLE [dbo].[dmper2] ADD  DEFAULT ((1)) FOR [p2_quarter]
GO
ALTER TABLE [dbo].[dmpergrp] ADD  DEFAULT ('') FOR [pg_name]
GO
ALTER TABLE [dbo].[dmpergrp] ADD  DEFAULT ((1)) FOR [pg_active]
GO
ALTER TABLE [dbo].[dmpergrp] ADD  DEFAULT ((0)) FOR [pg_default]
GO
ALTER TABLE [dbo].[dmphas] ADD  DEFAULT ('') FOR [ph_name]
GO
ALTER TABLE [dbo].[dmphas] ADD  DEFAULT ((1)) FOR [ph_active]
GO
ALTER TABLE [dbo].[dmphas] ADD  DEFAULT ((0)) FOR [ph_default]
GO
ALTER TABLE [dbo].[dmpo1] ADD  DEFAULT ('') FOR [p1_name]
GO
ALTER TABLE [dbo].[dmpo1] ADD  DEFAULT ((1)) FOR [p1_active]
GO
ALTER TABLE [dbo].[dmpo1] ADD  DEFAULT ((0)) FOR [p1_default]
GO
ALTER TABLE [dbo].[dmpo2] ADD  DEFAULT ('') FOR [p2_name]
GO
ALTER TABLE [dbo].[dmpo2] ADD  DEFAULT ((1)) FOR [p2_active]
GO
ALTER TABLE [dbo].[dmpo2] ADD  DEFAULT ((0)) FOR [p2_default]
GO
ALTER TABLE [dbo].[dmpos] ADD  DEFAULT ((0)) FOR [po_number]
GO
ALTER TABLE [dbo].[dmpos] ADD  DEFAULT ((0)) FOR [po_mask]
GO
ALTER TABLE [dbo].[dmpos] ADD  DEFAULT ('') FOR [po_name]
GO
ALTER TABLE [dbo].[dmposbutton] ADD  DEFAULT ('') FOR [pb_function]
GO
ALTER TABLE [dbo].[dmposbutton] ADD  DEFAULT ((0)) FOR [pb_overc2id]
GO
ALTER TABLE [dbo].[dmposbutton] ADD  DEFAULT ((0)) FOR [pb_caid]
GO
ALTER TABLE [dbo].[dmposbutton] ADD  DEFAULT ((0)) FOR [pb_c2id]
GO
ALTER TABLE [dbo].[dmposbutton] ADD  DEFAULT ((0)) FOR [pb_seq]
GO
ALTER TABLE [dbo].[dmposbutton] ADD  DEFAULT ((1)) FOR [pb_active]
GO
ALTER TABLE [dbo].[dmposname] ADD  DEFAULT ((0)) FOR [pn_poid]
GO
ALTER TABLE [dbo].[dmposname] ADD  DEFAULT ('') FOR [pn_name]
GO
ALTER TABLE [dbo].[dmposname] ADD  DEFAULT ((0)) FOR [pn_value]
GO
ALTER TABLE [dbo].[dmposset] ADD  DEFAULT ('') FOR [ps_mac]
GO
ALTER TABLE [dbo].[dmposset] ADD  DEFAULT ((0)) FOR [ps_comport]
GO
ALTER TABLE [dbo].[dmposset] ADD  DEFAULT ('') FOR [ps_terminalid]
GO
ALTER TABLE [dbo].[dmposset] ADD  DEFAULT ('') FOR [ps_securedevice]
GO
ALTER TABLE [dbo].[dmposset] ADD  DEFAULT ('0010010010') FOR [ps_sequenceno]
GO
ALTER TABLE [dbo].[dmposset] ADD  DEFAULT ((0)) FOR [ps_listenerport]
GO
ALTER TABLE [dbo].[dmposset] ADD  DEFAULT ((0)) FOR [ps_ccid]
GO
ALTER TABLE [dbo].[dmposset] ADD  DEFAULT ((0)) FOR [ps_usid]
GO
ALTER TABLE [dbo].[dmpr1] ADD  DEFAULT ('') FOR [p1_name]
GO
ALTER TABLE [dbo].[dmpr1] ADD  DEFAULT ((1)) FOR [p1_active]
GO
ALTER TABLE [dbo].[dmpr1] ADD  DEFAULT ((0)) FOR [p1_default]
GO
ALTER TABLE [dbo].[dmpr1] ADD  DEFAULT ((0)) FOR [p1_restricted]
GO
ALTER TABLE [dbo].[dmpr2] ADD  DEFAULT ('') FOR [p2_name]
GO
ALTER TABLE [dbo].[dmpr2] ADD  DEFAULT ((1)) FOR [p2_active]
GO
ALTER TABLE [dbo].[dmpr2] ADD  DEFAULT ((0)) FOR [p2_default]
GO
ALTER TABLE [dbo].[dmpr2] ADD  DEFAULT ((0)) FOR [p2_restricted]
GO
ALTER TABLE [dbo].[dmpr3] ADD  DEFAULT ('') FOR [p3_name]
GO
ALTER TABLE [dbo].[dmpr3] ADD  DEFAULT ((1)) FOR [p3_active]
GO
ALTER TABLE [dbo].[dmpr3] ADD  DEFAULT ((0)) FOR [p3_default]
GO
ALTER TABLE [dbo].[dmpr3] ADD  DEFAULT ((0)) FOR [p3_restricted]
GO
ALTER TABLE [dbo].[dmpr4] ADD  DEFAULT ('') FOR [p4_name]
GO
ALTER TABLE [dbo].[dmpr4] ADD  DEFAULT ((1)) FOR [p4_active]
GO
ALTER TABLE [dbo].[dmpr4] ADD  DEFAULT ((0)) FOR [p4_default]
GO
ALTER TABLE [dbo].[dmpr4] ADD  DEFAULT ((0)) FOR [p4_restricted]
GO
ALTER TABLE [dbo].[dmpr5] ADD  DEFAULT ('') FOR [p5_name]
GO
ALTER TABLE [dbo].[dmpr5] ADD  DEFAULT ((1)) FOR [p5_active]
GO
ALTER TABLE [dbo].[dmpr5] ADD  DEFAULT ((0)) FOR [p5_default]
GO
ALTER TABLE [dbo].[dmpr5] ADD  DEFAULT ((0)) FOR [p5_restricted]
GO
ALTER TABLE [dbo].[dmpref] ADD  DEFAULT (' ') FOR [pr_name]
GO
ALTER TABLE [dbo].[dmpref] ADD  DEFAULT ((0)) FOR [pr_usid]
GO
ALTER TABLE [dbo].[dmpref] ADD  DEFAULT (' ') FOR [pr_descrip]
GO
ALTER TABLE [dbo].[dmpref] ADD  DEFAULT ((0)) FOR [pr_default]
GO
ALTER TABLE [dbo].[dmpref] ADD  DEFAULT ((0)) FOR [pr_fiid]
GO
ALTER TABLE [dbo].[dmpref2] ADD  DEFAULT (' ') FOR [p2_field]
GO
ALTER TABLE [dbo].[dmpref2] ADD  DEFAULT (' ') FOR [p2_value]
GO
ALTER TABLE [dbo].[dmpref2] ADD  DEFAULT ((0)) FOR [p2_prid]
GO
ALTER TABLE [dbo].[dmpref2] ADD  DEFAULT (' ') FOR [p2_oper]
GO
ALTER TABLE [dbo].[dmpref2] ADD  DEFAULT (' ') FOR [p2_logical]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_codenum]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_descrip]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((50)) FOR [pr_level]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_buid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_caid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_lispric]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_stanlab]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_stanmat]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_stantot]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_active]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_taxable]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_unitwgt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_ware1]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_control]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_drwcode]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_reorder]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_salable]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_purable]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_stocked]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('A') FOR [pr_abc]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_user1]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_user2]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_user3]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_user4]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_notes]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_make]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('n') FOR [pr_ordtype]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_frtclas]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_retail]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_burden]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_prunid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_prfact]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_scrap]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_purpric]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_c2id]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_discoun]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_unquant]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_singord]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_chid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_invchid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_matexp]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_invadj]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_cogpro]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_rdid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_unitvol]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_unitcub]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_reorder2]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_puradj]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_hazard]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_matbur]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_buracct]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_salunid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_salfact]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finmat]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finlab]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finbur]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_specpar]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_density]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT (NULL) FOR [pr_counted]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_cntflag]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_fixstan]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_invgain]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_user5]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_user6]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('Never') FOR [pr_neginv]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_maxquan1]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_maxquan2]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_fixmat]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_fixlab]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_fixbur]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_fixmbur]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT (NULL) FOR [pr_fixupdt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_mrp]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_catch]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_catchwgt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_tranvar]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_xferexp]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_loadcalc1]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_loadcalc2]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_loadcalc3]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_burcalc]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_matburcalc]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('Purchase Price') FOR [pr_purtype]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_taxpo]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_popso]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_poppo]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_custinv]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_qcid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_quota]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_lifocost]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_tgid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_user7]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_user8]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_user9]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_rdid2]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_secure]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_hazflag]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_stanfrt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_fixfrt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_frtchid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_phid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_shelf]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_commable]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finwip]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_custreq]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_poquan]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_soquan]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_jobquan]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_makeord]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_inherit]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_minmar]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_tarmar]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_msfactor]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_allowbom]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('By quantity') FOR [pr_prtlabel]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_futmat]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_futlab]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_futbur]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_futmbur]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_futfrt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_futstan]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_timemrp]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_nosub]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finpart]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_purunid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_unid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_lotreqd]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_orddays]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_qcfreq]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_lotrecv]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_vendreq]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_cofaid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_polabid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_solabid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_itemlabid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_msdsid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_joblabid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finback]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_lotlabid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_markup]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_xfermarkchid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT (NULL) FOR [pr_stanupdt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT (NULL) FOR [pr_futupdt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_psid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_serial]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_featcost]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_reqfacility]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_routing]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_issueoverlimit]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_issuelimitenforce]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_porecvlimit]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_porecvlimitenforce]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_secureprice]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_xfercost]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_s1id]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_s2id]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_backjob]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_splitjobs]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_overissue]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_unitlen]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_loid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_jobmin]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_ltid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_qclead]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_trakid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_trak2id]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_minquant]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('Every X Lots') FOR [pr_qcfreqtype]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_serialcont]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_jobmgid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_separatejobs]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_rollupmats]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_rolluplabor]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_rollupburden]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_tarewgt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finasissued]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_countunid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_palunid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_picture]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_popjob]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_routesale]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_contprid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finmatwiploc]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_scrapcost]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_rollupwgt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_xferchid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_measured]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_creditcost]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_routereturn]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_combinepos]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_definqty]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_incquant]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_shoprel]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_frominvprid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_minsale]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_incsale]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_separatepos]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_splitpos]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_recatrisk]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('Default') FOR [pr_shipquan]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_salediscchid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_mrpjobsubasm]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('c') FOR [pr_taretype]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('') FOR [pr_tareexp]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_rollupvol]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_minwgt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_maxwgt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_haltposting]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_contunid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_commexp]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_zoneput]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_frtexpchid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_jobinc]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_dnid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_safedays]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_prtjobpl]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_restrictjobquant]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_frtrevchid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_qcmrpjobplan]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_reqexpdate]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((2)) FOR [pr_minpallet]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_qcid2]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('FIFO') FOR [pr_pickorder]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_wipinv]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('None') FOR [pr_splitposby]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_issueunderlimit]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_issueunderenforce]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('None') FOR [pr_iataunit]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_roundupbom]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finseqstage]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_recalcbomcalcs]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_subordjob]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_suggestbefore]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_dockrel]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_restrictjobinc]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_deresqty]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_restrictloc]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_forecastback]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_forecastforward]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_backordpo]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_pickunit]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_leadmins]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_makemlfinish]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_xfacmarkchid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_custreqxfer]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_backordso]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finishltid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_finishloid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_receiveloid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_receiveltid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_autofinunid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_autofinish]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_rolluprstypes]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_purdis]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('Same Day') FOR [pr_splitjobson]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_bomunid]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_separateicxfers]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_poallocatable]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ('Default') FOR [pr_autoaltwgt]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_totalcatchml]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_dfltreserveloc]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_autolinkmrpjobs]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((0)) FOR [pr_makemlreceive]
GO
ALTER TABLE [dbo].[dmprod] ADD  DEFAULT ((1)) FOR [pr_allowlistprice]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_prid]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_veid]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ('') FOR [p2_vndcode]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ('') FOR [p2_vnddesc]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_orddays]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_unquant]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_totcost]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((1)) FOR [p2_active]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_vndunid]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_prunid]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_prfact]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ('') FOR [p2_notes]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ('None') FOR [p2_retail]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_prefer]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_shelf]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_waid]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_qcid]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT (NULL) FOR [p2_qcexpires]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_poquan]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_minquant]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_incquant]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((1)) FOR [p2_usemrp]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT (NULL) FOR [p2_approvalexpires]
GO
ALTER TABLE [dbo].[dmprod2] ADD  DEFAULT ((0)) FOR [p2_contunid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_prid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_waid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_reorder]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_reorder2]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_maxquan1]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_maxquan2]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_lispric]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_stanmat]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_stanlab]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_burden]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_matbur]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_purpric]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_fixmat]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_fixlab]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_fixbur]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_fixmbur]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_fixstan]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT (NULL) FOR [p3_fixupdt]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_usecosts]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((1)) FOR [p3_usereorder]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_stantot]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_useprices]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_stanfrt]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_fixfrt]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_useflags]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_purable]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_salable]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_poquan]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_soquan]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_jobquan]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ('') FOR [p3_ware1]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_futmat]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_futlab]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_futbur]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_futmbur]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_futfrt]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_futstan]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_orddays]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_make]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ('A') FOR [p3_abc]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ('') FOR [p3_hazard]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_hazflag]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_xfercost]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_loid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_jobmin]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_minquant]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_ltid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_incquant]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_minsale]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_incsale]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_jobinc]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_zoid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_scrapissueoverride]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_scrap]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_scrapcost]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_overissue]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_cntflag]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT (NULL) FOR [p3_counted]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_incict]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_minict]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_suggestbefore]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_forecastback]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_forecastforward]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_definqty]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_leadmins]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((1)) FOR [p3_usephyscyclesettings]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_finishltid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_finishloid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_receiveltid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_receiveloid]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_mrpjobsubasm]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_subordjob]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((1)) FOR [p3_recalcbomcalcs]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_dfltreserveloc]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ((0)) FOR [p3_haltposting]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ('Follow Item Master') FOR [p3_lotreqd]
GO
ALTER TABLE [dbo].[dmprod3] ADD  DEFAULT ('Follow Item Master') FOR [p3_lotrecv]
GO
ALTER TABLE [dbo].[dmprod4] ADD  DEFAULT ((0)) FOR [p4_prid]
GO
ALTER TABLE [dbo].[dmprod4] ADD  DEFAULT ('') FOR [p4_codenum]
GO
ALTER TABLE [dbo].[dmprod4] ADD  DEFAULT ('') FOR [p4_descrip]
GO
ALTER TABLE [dbo].[dmprod4] ADD  DEFAULT ((0)) FOR [p4_default]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT ((0)) FOR [p5_prid]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT ((0)) FOR [p5_veid]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT ((0)) FOR [p5_quant]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT ((0)) FOR [p5_price]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT (NULL) FOR [p5_start]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT (NULL) FOR [p5_end]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT ((0)) FOR [p5_p2id]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT ((0)) FOR [p5_frtcost]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT ('Ordered') FOR [p5_datebasedon]
GO
ALTER TABLE [dbo].[dmprod5] ADD  DEFAULT ((0)) FOR [p5_matbur]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((0)) FOR [pg_prognum]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ('') FOR [pg_descrip]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT (NULL) FOR [pg_date]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((1)) FOR [pg_active]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((0)) FOR [pg_pcid]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ('') FOR [pg_notes]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((0)) FOR [pg_biid]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((0)) FOR [pg_shid]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT (NULL) FOR [pg_complete]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((0)) FOR [pg_waid]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((0)) FOR [pg_teid]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ('') FOR [pg_billpo]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((0)) FOR [pg_estmarg]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((0)) FOR [pg_basedon]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((1)) FOR [pg_fcid]
GO
ALTER TABLE [dbo].[dmprog] ADD  DEFAULT ((1)) FOR [pg_fcrate]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT ((0)) FOR [p2_seq]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT ((0)) FOR [p2_prid]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT ((0)) FOR [p2_amount]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT (NULL) FOR [p2_sched]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT ((0)) FOR [p2_pjid]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT ((0)) FOR [p2_billed]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT ('') FOR [p2_notes]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT ((0)) FOR [p2_retper]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT ((0)) FOR [p2_rettot]
GO
ALTER TABLE [dbo].[dmprog2] ADD  DEFAULT ((0)) FOR [p2_pgid]
GO
ALTER TABLE [dbo].[dmprojnotetype] ADD  DEFAULT ((1)) FOR [pe_active]
GO
ALTER TABLE [dbo].[dmprojnotetype] ADD  DEFAULT ((0)) FOR [pe_default]
GO
ALTER TABLE [dbo].[dmprojnotetype] ADD  DEFAULT ('') FOR [pe_name]
GO
ALTER TABLE [dbo].[dmprojnotetype] ADD  DEFAULT ((0)) FOR [pe_noid]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_prid]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_descrip]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((1)) FOR [pm_active]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_for]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_forname]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_fornum]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_minimum]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_on]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_onname]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_onnum]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_type]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_typenum]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_waid]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT (NULL) FOR [pm_start]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT (NULL) FOR [pm_end]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_limitorder]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_limitcat]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_flexible]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_auto]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_buyqty]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_freeqty]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_unid]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_mintype]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_minnum]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_minname]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('Shipped') FOR [pm_quantsbasedon]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_sorttobottom]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('to_orddate') FOR [pm_basedon]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_line]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_edicode]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('All') FOR [pm_inventory]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('Order') FOR [pm_linetype]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('promotion') FOR [pm_trantype]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((1)) FOR [pm_countinpricingorder]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('') FOR [pm_expression]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('Shipped') FOR [pm_appliedon]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_limitcust]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((1)) FOR [pm_includenegatives]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_backord]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ('Quantity') FOR [pm_minimumtype]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_uselinequant]
GO
ALTER TABLE [dbo].[dmpromo] ADD  DEFAULT ((0)) FOR [pm_forecastlift]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ('') FOR [pt_name]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ('') FOR [pt_notes]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ('') FOR [pt_report]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ('') FOR [pt_type]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ((0)) FOR [pt_default]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ('') FOR [pt_user]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT (' ') FOR [pt_printer]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ('') FOR [pt_archive]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ('') FOR [pt_sortexp]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ((0)) FOR [pt_attached]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ((0)) FOR [pt_language]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ((0)) FOR [pt_pdid]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ('') FOR [pt_emailexp]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ('') FOR [pt_emailsubexp]
GO
ALTER TABLE [dbo].[dmprt] ADD  DEFAULT ((1)) FOR [pt_active]
GO
ALTER TABLE [dbo].[dmprt2] ADD  DEFAULT ((0)) FOR [p2_ptid]
GO
ALTER TABLE [dbo].[dmprt2] ADD  DEFAULT ((0)) FOR [p2_copy]
GO
ALTER TABLE [dbo].[dmprt2] ADD  DEFAULT ('') FOR [p2_say]
GO
ALTER TABLE [dbo].[dmprtdest] ADD  DEFAULT ('') FOR [pd_name]
GO
ALTER TABLE [dbo].[dmprtdest] ADD  DEFAULT ('') FOR [pd_printer]
GO
ALTER TABLE [dbo].[dmprtdest] ADD  DEFAULT ((1)) FOR [pd_active]
GO
ALTER TABLE [dbo].[dmprtdest] ADD  DEFAULT ((0)) FOR [pd_useroverride]
GO
ALTER TABLE [dbo].[dmprtdestover] ADD  DEFAULT ((0)) FOR [po_pdid]
GO
ALTER TABLE [dbo].[dmprtdestover] ADD  DEFAULT ('') FOR [po_table]
GO
ALTER TABLE [dbo].[dmprtdestover] ADD  DEFAULT ((0)) FOR [po_recid]
GO
ALTER TABLE [dbo].[dmprtdestover] ADD  DEFAULT ('') FOR [po_printer]
GO
ALTER TABLE [dbo].[dmprtdsd] ADD  DEFAULT ('') FOR [pd_name]
GO
ALTER TABLE [dbo].[dmprtdsd] ADD  DEFAULT ((1)) FOR [pd_active]
GO
ALTER TABLE [dbo].[dmprtdsd] ADD  DEFAULT ((0)) FOR [pd_default]
GO
ALTER TABLE [dbo].[dmprtdsd] ADD  DEFAULT ('') FOR [pd_report]
GO
ALTER TABLE [dbo].[dmprtdsd] ADD  DEFAULT ('Invoice') FOR [pd_reporttype]
GO
ALTER TABLE [dbo].[dmprtsub] ADD  DEFAULT ('') FOR [ps_name]
GO
ALTER TABLE [dbo].[dmprtsub] ADD  DEFAULT ((1)) FOR [ps_active]
GO
ALTER TABLE [dbo].[dmprtsub2] ADD  DEFAULT ((0)) FOR [p2_psid]
GO
ALTER TABLE [dbo].[dmprtsub2] ADD  DEFAULT ('') FOR [p2_subtype]
GO
ALTER TABLE [dbo].[dmprtsub2] ADD  DEFAULT ('') FOR [p2_baserep]
GO
ALTER TABLE [dbo].[dmprtsub2] ADD  DEFAULT ('') FOR [p2_subrep]
GO
ALTER TABLE [dbo].[dmprtsub2] ADD  DEFAULT ((0)) FOR [p2_baseform]
GO
ALTER TABLE [dbo].[dmprtsub2] ADD  DEFAULT ((0)) FOR [p2_subform]
GO
ALTER TABLE [dbo].[dmprtsub2] ADD  DEFAULT ((0)) FOR [p2_basecat]
GO
ALTER TABLE [dbo].[dmprtsub2] ADD  DEFAULT ((0)) FOR [p2_subcat]
GO
ALTER TABLE [dbo].[dmprtsub2] ADD  DEFAULT ((0)) FOR [p2_ptid]
GO
ALTER TABLE [dbo].[dmpsize] ADD  DEFAULT ('') FOR [ps_name]
GO
ALTER TABLE [dbo].[dmpsize] ADD  DEFAULT ((0)) FOR [ps_width]
GO
ALTER TABLE [dbo].[dmpsize] ADD  DEFAULT ((0)) FOR [ps_height]
GO
ALTER TABLE [dbo].[dmpsize] ADD  DEFAULT ((0)) FOR [ps_default]
GO
ALTER TABLE [dbo].[dmpsize] ADD  DEFAULT ((1)) FOR [ps_active]
GO
ALTER TABLE [dbo].[dmpsize] ADD  DEFAULT ((0)) FOR [ps_partform]
GO
ALTER TABLE [dbo].[dmpsize] ADD  DEFAULT ((0)) FOR [ps_defaultpf]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ('All Part Numbers') FOR [py_fortype]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ((0)) FOR [py_for]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ('All Locations') FOR [py_totype]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ((0)) FOR [py_to]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ('From Location') FOR [py_captype]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ((0)) FOR [py_capunid]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ((0)) FOR [py_capacity]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ('Closest') FOR [py_sort]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ('Any Parts') FOR [py_existinginv]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ('All') FOR [py_invtype]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ('All') FOR [py_qcstatus]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ('All') FOR [py_lot]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ((1)) FOR [py_active]
GO
ALTER TABLE [dbo].[dmputaway] ADD  DEFAULT ((0)) FOR [py_fillpartialloc]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ('') FOR [qc_name]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((1)) FOR [qc_active]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_default]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ('c') FOR [qc_status]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT (NULL) FOR [qc_saved]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ('') FOR [qc_savetime]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_approval]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_afterprod]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_daysopen]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_esig]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_groupnum]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_completeempty]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((1)) FOR [qc_copyqc]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_failtoquar]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((1)) FOR [qc_approvaltype]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_esigforresult]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ('None') FOR [qc_esigapprovaltype]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_trakid]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_trak2id]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_esigcounts]
GO
ALTER TABLE [dbo].[dmqc] ADD  DEFAULT ((0)) FOR [qc_resultsesigcounts]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_qcid]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_d1id]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_seq]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_min]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_max]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ('') FOR [q2_target]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ('') FOR [q2_notes]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ('') FOR [q2_name]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ('') FOR [q2_picture]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_required]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_q3id]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_mustpass]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((1)) FOR [q2_print]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ('Last') FOR [q2_formcalc]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((1)) FOR [q2_printpo]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_qgid]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_mindet]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ((0)) FOR [q2_requirenotes]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ('') FOR [q2_defaultvalue]
GO
ALTER TABLE [dbo].[dmqc2] ADD  DEFAULT ('') FOR [q2_printmask]
GO
ALTER TABLE [dbo].[dmqc3] ADD  DEFAULT ((1)) FOR [q3_active]
GO
ALTER TABLE [dbo].[dmqc3] ADD  DEFAULT ('') FOR [q3_name]
GO
ALTER TABLE [dbo].[dmqc3] ADD  DEFAULT ('') FOR [q3_method]
GO
ALTER TABLE [dbo].[dmqc3] ADD  DEFAULT ((0)) FOR [q3_unid]
GO
ALTER TABLE [dbo].[dmqc3] ADD  DEFAULT ('None') FOR [q3_combineresults]
GO
ALTER TABLE [dbo].[dmqc3] ADD  DEFAULT ('') FOR [q3_picture]
GO
ALTER TABLE [dbo].[dmqc3] ADD  DEFAULT ('') FOR [q3_printmask]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ('dmrev') FOR [q6_table]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ((0)) FOR [q6_recid]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ('Every X Lots') FOR [q6_freqtype]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ((0)) FOR [q6_frequency]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ((0)) FOR [q6_qcid]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ((0)) FOR [q6_stabdays]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ((0)) FOR [q6_seq]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ('All') FOR [q6_ordtype]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ((0)) FOR [q6_offset]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ((0)) FOR [q6_offsetfromqfid]
GO
ALTER TABLE [dbo].[dmqc6] ADD  DEFAULT ('Follow Inventory Options') FOR [q6_qcfreqlottype]
GO
ALTER TABLE [dbo].[dmqcgrp] ADD  DEFAULT ('') FOR [qg_name]
GO
ALTER TABLE [dbo].[dmqcgrp] ADD  DEFAULT ((1)) FOR [qg_active]
GO
ALTER TABLE [dbo].[dmqcgrp] ADD  DEFAULT ((0)) FOR [qg_default]
GO
ALTER TABLE [dbo].[dmqcgrp2] ADD  DEFAULT ((0)) FOR [q2_access]
GO
ALTER TABLE [dbo].[dmqcgrp2] ADD  DEFAULT ((0)) FOR [q2_qgid]
GO
ALTER TABLE [dbo].[dmqcgrp2] ADD  DEFAULT ((0)) FOR [q2_ugid]
GO
ALTER TABLE [dbo].[dmqcgrp2] ADD  DEFAULT ((0)) FOR [q2_usid]
GO
ALTER TABLE [dbo].[dmquery] ADD  DEFAULT ((0)) FOR [qu_usid]
GO
ALTER TABLE [dbo].[dmquery] ADD  DEFAULT ('') FOR [qu_name]
GO
ALTER TABLE [dbo].[dmquery] ADD  DEFAULT ((0)) FOR [qu_default]
GO
ALTER TABLE [dbo].[dmquery] ADD  DEFAULT ('') FOR [qu_query]
GO
ALTER TABLE [dbo].[dmquery] ADD  DEFAULT ('') FOR [qu_prefilter]
GO
ALTER TABLE [dbo].[dmquery] ADD  DEFAULT ((0)) FOR [qu_publish]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ('') FOR [rd_name]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ((1)) FOR [rd_active]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT (' ') FOR [rd_printer]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ('') FOR [rd_doc]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ('Item label') FOR [rd_deftype]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ((0)) FOR [rd_reid]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ('Designer') FOR [rd_printmethod]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ('') FOR [rd_zebraform]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ((0)) FOR [rd_language]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ('always') FOR [rd_printertype]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ((0)) FOR [rd_prtdfltqty]
GO
ALTER TABLE [dbo].[dmrdoc] ADD  DEFAULT ((0)) FOR [rd_pdid]
GO
ALTER TABLE [dbo].[dmrdoctag] ADD  DEFAULT ('') FOR [rt_name]
GO
ALTER TABLE [dbo].[dmrdoctag] ADD  DEFAULT ((1)) FOR [rt_active]
GO
ALTER TABLE [dbo].[dmrdoctag] ADD  DEFAULT ('') FOR [rt_basetag]
GO
ALTER TABLE [dbo].[dmrdoctag] ADD  DEFAULT ('') FOR [rt_filter]
GO
ALTER TABLE [dbo].[dmrdoctag] ADD  DEFAULT ('') FOR [rt_sort]
GO
ALTER TABLE [dbo].[dmrdoctag] ADD  DEFAULT ('') FOR [rt_fields]
GO
ALTER TABLE [dbo].[dmrdoctag] ADD  DEFAULT ((0)) FOR [rt_distinct]
GO
ALTER TABLE [dbo].[dmrdoctag] ADD  DEFAULT ('') FOR [rt_separator]
GO
ALTER TABLE [dbo].[dmrdoctag] ADD  DEFAULT ('') FOR [rt_groupby]
GO
ALTER TABLE [dbo].[dmreas] ADD  DEFAULT ('') FOR [re_name]
GO
ALTER TABLE [dbo].[dmreas] ADD  DEFAULT ((1)) FOR [re_active]
GO
ALTER TABLE [dbo].[dmreas] ADD  DEFAULT ((0)) FOR [re_default]
GO
ALTER TABLE [dbo].[dmreas] ADD  DEFAULT ((0)) FOR [re_invadj]
GO
ALTER TABLE [dbo].[dmreg] ADD  DEFAULT ('') FOR [re_name]
GO
ALTER TABLE [dbo].[dmreg] ADD  DEFAULT ((1)) FOR [re_active]
GO
ALTER TABLE [dbo].[dmreg] ADD  DEFAULT ((0)) FOR [re_default]
GO
ALTER TABLE [dbo].[dmreggrp] ADD  DEFAULT (' ') FOR [rg_name]
GO
ALTER TABLE [dbo].[dmreggrp] ADD  DEFAULT ((1)) FOR [rg_active]
GO
ALTER TABLE [dbo].[dmreggrp2] ADD  DEFAULT ((0)) FOR [r2_rgid]
GO
ALTER TABLE [dbo].[dmreggrp2] ADD  DEFAULT ((0)) FOR [r2_shid]
GO
ALTER TABLE [dbo].[dmreggrp2] ADD  DEFAULT ((0)) FOR [r2_rdid]
GO
ALTER TABLE [dbo].[dmreggrp2] ADD  DEFAULT (' ') FOR [r2_report]
GO
ALTER TABLE [dbo].[dmregister] ADD  DEFAULT ('') FOR [rg_name]
GO
ALTER TABLE [dbo].[dmregister] ADD  DEFAULT ((1)) FOR [rg_active]
GO
ALTER TABLE [dbo].[dmregister] ADD  DEFAULT ((0)) FOR [rg_default]
GO
ALTER TABLE [dbo].[dmregister] ADD  DEFAULT (' ') FOR [rg_printer]
GO
ALTER TABLE [dbo].[dmregister] ADD  DEFAULT ((0)) FOR [rg_waid]
GO
ALTER TABLE [dbo].[dmregister] ADD  DEFAULT ('') FOR [rg_terminalid]
GO
ALTER TABLE [dbo].[dmregister] ADD  DEFAULT ((0)) FOR [rg_ccid]
GO
ALTER TABLE [dbo].[dmregisterprinter] ADD  DEFAULT ((0)) FOR [rp_rgid]
GO
ALTER TABLE [dbo].[dmregisterprinter] ADD  DEFAULT ('') FOR [rp_printer]
GO
ALTER TABLE [dbo].[dmregisterprinter] ADD  DEFAULT ((0)) FOR [rp_default]
GO
ALTER TABLE [dbo].[dmregisterscale] ADD  DEFAULT ((0)) FOR [rs_rgid]
GO
ALTER TABLE [dbo].[dmregisterscale] ADD  DEFAULT ((0)) FOR [rs_smid]
GO
ALTER TABLE [dbo].[dmregisterscale] ADD  DEFAULT ((0)) FOR [rs_default]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ('') FOR [re_name]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ('') FOR [re_type]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_width]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_mtop]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_mright]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_mbottom]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_mleft]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_system]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ('Portrait') FOR [re_orient]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT (' ') FOR [re_orderby]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_psid]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_sumnewpage]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_includeheadsum]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((0)) FOR [re_includefootsum]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ((1)) FOR [re_clientrender]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ('') FOR [re_backimage]
GO
ALTER TABLE [dbo].[dmreport] ADD  DEFAULT ('') FOR [re_backimagename]
GO
ALTER TABLE [dbo].[dmreportband] ADD  DEFAULT ((0)) FOR [rb_reid]
GO
ALTER TABLE [dbo].[dmreportband] ADD  DEFAULT ((0)) FOR [rb_rgid]
GO
ALTER TABLE [dbo].[dmreportband] ADD  DEFAULT ((0)) FOR [rb_height]
GO
ALTER TABLE [dbo].[dmreportband] ADD  DEFAULT ('') FOR [rb_type]
GO
ALTER TABLE [dbo].[dmreportband] ADD  DEFAULT ((0)) FOR [rb_pagethresh]
GO
ALTER TABLE [dbo].[dmreportband] ADD  DEFAULT ((0)) FOR [rb_remove]
GO
ALTER TABLE [dbo].[dmreportgrp] ADD  DEFAULT ((0)) FOR [rg_level]
GO
ALTER TABLE [dbo].[dmreportgrp] ADD  DEFAULT ('') FOR [rg_name]
GO
ALTER TABLE [dbo].[dmreportgrp] ADD  DEFAULT ('') FOR [rg_expression]
GO
ALTER TABLE [dbo].[dmreportgrp] ADD  DEFAULT ((0)) FOR [rg_reid]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_reid]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_rbid]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_class]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_width]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_height]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_top]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_left]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_borderstyle]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_bordercolor]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_borderweight]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_printwhen]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_bgcolor]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((1)) FOR [ro_printrep]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_corners]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_hshadow]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_vshadow]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_shadowblur]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_shadowcolor]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_zindex]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_align]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_font]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_fontsize]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_fieldtype]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_expression]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_c2id]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_fgcolor]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_grow]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('Top') FOR [ro_position]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_format]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_backimage]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_backimagename]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('None') FOR [ro_blocktype]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_rbeid]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_remove]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('none') FOR [ro_encoding]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((4)) FOR [ro_bcheight]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_imgtable]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_imgrecidex]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ('') FOR [ro_imgdescripex]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_rotation]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_split]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_systemlogo]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_righttoleft]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((1)) FOR [ro_textspacing]
GO
ALTER TABLE [dbo].[dmreportobj] ADD  DEFAULT ((0)) FOR [ro_limitposition]
GO
ALTER TABLE [dbo].[dmreportorderby] ADD  DEFAULT ((0)) FOR [ry_reid]
GO
ALTER TABLE [dbo].[dmreportorderby] ADD  DEFAULT ('') FOR [ry_orderby]
GO
ALTER TABLE [dbo].[dmreportorderby] ADD  DEFAULT ((0)) FOR [ry_seq]
GO
ALTER TABLE [dbo].[dmreportorderby] ADD  DEFAULT ((0)) FOR [ry_descending]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ((0)) FOR [rv_reid]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ('') FOR [rv_expression]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ('') FOR [rv_name]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ('None') FOR [rv_reset]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ((0)) FOR [rv_sequence]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ('None') FOR [rv_calctype]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ('') FOR [rv_initvalue]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ((0)) FOR [rv_min]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ((0)) FOR [rv_max]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ('None') FOR [rv_parametertype]
GO
ALTER TABLE [dbo].[dmreportvar] ADD  DEFAULT ((0)) FOR [rv_required]
GO
ALTER TABLE [dbo].[dmretreas] ADD  DEFAULT ('') FOR [rt_name]
GO
ALTER TABLE [dbo].[dmretreas] ADD  DEFAULT ('') FOR [rt_moveto]
GO
ALTER TABLE [dbo].[dmretreas] ADD  DEFAULT ((0)) FOR [rt_active]
GO
ALTER TABLE [dbo].[dmretreas] ADD  DEFAULT ((0)) FOR [rt_noinv]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ('') FOR [re_name]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT (NULL) FOR [re_date]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ('') FOR [re_notes]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_default]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_prid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((1)) FOR [re_active]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_userid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ('') FOR [re_history]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((1)) FOR [re_yield]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_private]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT (NULL) FOR [re_lastrev]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_qcid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ('Specified') FOR [re_batyld]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_regulat]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ('c') FOR [re_status]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT (NULL) FOR [re_saved]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ('') FOR [re_savetime]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((1)) FOR [re_foid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_trakid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_trak2id]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_unid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_shid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_revnum]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_finatrisk]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_waid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_jcid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ((0)) FOR [re_dflttrakid]
GO
ALTER TABLE [dbo].[dmrev] ADD  DEFAULT ('p') FOR [re_subtype]
GO
ALTER TABLE [dbo].[dmrev2] ADD  DEFAULT ((0)) FOR [r2_prid]
GO
ALTER TABLE [dbo].[dmrev2] ADD  DEFAULT ((0)) FOR [r2_reid]
GO
ALTER TABLE [dbo].[dmrev2] ADD  DEFAULT ((1)) FOR [r2_unid]
GO
ALTER TABLE [dbo].[dmrev2] ADD  DEFAULT ('') FOR [r2_notes]
GO
ALTER TABLE [dbo].[dmrevconstraint] ADD  DEFAULT ((0)) FOR [rc_reid]
GO
ALTER TABLE [dbo].[dmrevconstraint] ADD  DEFAULT ('') FOR [rc_constraint]
GO
ALTER TABLE [dbo].[dmrevconstraint] ADD  DEFAULT (' ') FOR [rc_source]
GO
ALTER TABLE [dbo].[dmrevconstraint] ADD  DEFAULT ((0)) FOR [rc_forid]
GO
ALTER TABLE [dbo].[dmrevconstraint] ADD  DEFAULT ((0)) FOR [rc_min]
GO
ALTER TABLE [dbo].[dmrevconstraint] ADD  DEFAULT ((0)) FOR [rc_max]
GO
ALTER TABLE [dbo].[dmrevconstraint] ADD  DEFAULT ((0)) FOR [rc_d1id]
GO
ALTER TABLE [dbo].[dmrevconstraint] ADD  DEFAULT ((0)) FOR [rc_q3id]
GO
ALTER TABLE [dbo].[dmrevsec] ADD  DEFAULT ((0)) FOR [rs_ugid]
GO
ALTER TABLE [dbo].[dmrevsec] ADD  DEFAULT ((0)) FOR [rs_waid]
GO
ALTER TABLE [dbo].[dmrevsec] ADD  DEFAULT ('') FOR [rs_security]
GO
ALTER TABLE [dbo].[dmrnd] ADD  DEFAULT ((1)) FOR [rn_active]
GO
ALTER TABLE [dbo].[dmrnd] ADD  DEFAULT ((0)) FOR [rn_min]
GO
ALTER TABLE [dbo].[dmrnd] ADD  DEFAULT ((0)) FOR [rn_max]
GO
ALTER TABLE [dbo].[dmrnd] ADD  DEFAULT ((0)) FOR [rn_rndpt]
GO
ALTER TABLE [dbo].[dmrnd] ADD  DEFAULT ((0)) FOR [rn_downpt]
GO
ALTER TABLE [dbo].[dmrnd] ADD  DEFAULT ((0)) FOR [rn_rndto]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ('') FOR [ro_name]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ((1)) FOR [ro_active]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ('c') FOR [ro_status]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ((0)) FOR [ro_size]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ((0)) FOR [ro_recalcbatchlab]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ((0)) FOR [ro_waid]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ((0)) FOR [ro_usemrp]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ((0)) FOR [ro_jobmin]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ((0)) FOR [ro_jobquan]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ((0)) FOR [ro_jobinc]
GO
ALTER TABLE [dbo].[dmrout] ADD  DEFAULT ((0)) FOR [ro_continuous]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_prid]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_seq]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_opid]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_ceid]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_pieces]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_hours]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_workers]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ('') FOR [r2_notes]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_batch]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_roid]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_multiday]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_leadtime]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_crid]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_woid]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((1)) FOR [r2_finish]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ('end') FOR [r2_leadtype]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ('none') FOR [r2_restrict]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((1)) FOR [r2_includeoptimize]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_unavailnextseq]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((0)) FOR [r2_zerocost]
GO
ALTER TABLE [dbo].[dmrout2] ADD  DEFAULT ((1)) FOR [r2_schedblackout]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_r2id]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_ceid]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_seq]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_pieces]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_hours]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_workers]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ('') FOR [rc_notes]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_leadtime]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ('end') FOR [rc_leadtype]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_multiday]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_inherit]
GO
ALTER TABLE [dbo].[dmrout2cent] ADD  DEFAULT ((0)) FOR [rc_default]
GO
ALTER TABLE [dbo].[dmrout3] ADD  DEFAULT ((0)) FOR [r3_reid]
GO
ALTER TABLE [dbo].[dmrout3] ADD  DEFAULT ((0)) FOR [r3_roid]
GO
ALTER TABLE [dbo].[dmrout3] ADD  DEFAULT ((0)) FOR [r3_default]
GO
ALTER TABLE [dbo].[dmrsellgrp] ADD  DEFAULT ((0)) FOR [rs_active]
GO
ALTER TABLE [dbo].[dmrsellgrp] ADD  DEFAULT ('') FOR [rs_name]
GO
ALTER TABLE [dbo].[dmrsellgrp] ADD  DEFAULT (NULL) FOR [rs_start]
GO
ALTER TABLE [dbo].[dmrsellgrp] ADD  DEFAULT (NULL) FOR [rs_end]
GO
ALTER TABLE [dbo].[dmrsellgrp] ADD  DEFAULT ((0)) FOR [rs_interval]
GO
ALTER TABLE [dbo].[dmrsellgrp] ADD  DEFAULT ((0)) FOR [rs_amount]
GO
ALTER TABLE [dbo].[dmrsellgrp] ADD  DEFAULT ((0)) FOR [rs_unid]
GO
ALTER TABLE [dbo].[dmrsellgrp] ADD  DEFAULT ('to_orddate') FOR [rs_basedon]
GO
ALTER TABLE [dbo].[dmrsellprod] ADD  DEFAULT ((0)) FOR [rp_rtid]
GO
ALTER TABLE [dbo].[dmrsellprod] ADD  DEFAULT ((0)) FOR [rp_prid]
GO
ALTER TABLE [dbo].[dmrsellprod] ADD  DEFAULT ((0)) FOR [rp_min]
GO
ALTER TABLE [dbo].[dmrsellprod] ADD  DEFAULT ((0)) FOR [rp_max]
GO
ALTER TABLE [dbo].[dmrsellprod] ADD  DEFAULT ((0)) FOR [rp_percentof]
GO
ALTER TABLE [dbo].[dmrsellprod] ADD  DEFAULT ((0)) FOR [rp_waid]
GO
ALTER TABLE [dbo].[dmrselltype] ADD  DEFAULT ('') FOR [rt_name]
GO
ALTER TABLE [dbo].[dmrselltype] ADD  DEFAULT ((1)) FOR [rt_active]
GO
ALTER TABLE [dbo].[dmsalut] ADD  DEFAULT ('') FOR [sa_name]
GO
ALTER TABLE [dbo].[dmsalut] ADD  DEFAULT ((1)) FOR [sa_active]
GO
ALTER TABLE [dbo].[dmsalut] ADD  DEFAULT ((0)) FOR [sa_default]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('') FOR [sm_name]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ((1)) FOR [sm_active]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ((0)) FOR [sm_default]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ((9600)) FOR [sm_baud]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('8') FOR [sm_databits]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('1') FOR [sm_stopbits]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('None') FOR [sm_parity]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('None') FOR [sm_handshake]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('Single') FOR [sm_mode]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('') FOR [sm_wgtmsgformat]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('') FOR [sm_intprecision]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('') FOR [sm_decprecision]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('') FOR [sm_decdelim]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('') FOR [sm_stabmsgformat]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('COM1') FOR [sm_com]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('W') FOR [sm_pollmsg]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ((1000)) FOR [sm_pollfreq]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ((1)) FOR [sm_promptoverweight]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ((0)) FOR [sm_minwgt]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ((0)) FOR [sm_maxwgt]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('') FOR [sm_noteexp]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ((0)) FOR [sm_unid]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('') FOR [sm_taremsg]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ('') FOR [sm_zeromsg]
GO
ALTER TABLE [dbo].[dmscalemodel] ADD  DEFAULT ((1)) FOR [sm_zerofinish]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((1)) FOR [sc_active]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_monstart]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_tuestart]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_wedstart]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_thustart]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_fristart]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_satstart]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_sunstart]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_monend]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_tueend]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_wedend]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_thuend]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_friend]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_satend]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_sunend]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ('') FOR [sc_type]
GO
ALTER TABLE [dbo].[dmsched] ADD  DEFAULT ((0)) FOR [sc_typeid]
GO
ALTER TABLE [dbo].[dmsched2] ADD  DEFAULT ((0)) FOR [s2_scid]
GO
ALTER TABLE [dbo].[dmsched2] ADD  DEFAULT ((0)) FOR [s2_dow]
GO
ALTER TABLE [dbo].[dmsched2] ADD  DEFAULT ((0)) FOR [s2_starttime]
GO
ALTER TABLE [dbo].[dmsched2] ADD  DEFAULT ((0)) FOR [s2_endtime]
GO
ALTER TABLE [dbo].[dmsched2] ADD  DEFAULT ('Specified') FOR [s2_avail]
GO
ALTER TABLE [dbo].[dmsched3] ADD  DEFAULT ('') FOR [s3_type]
GO
ALTER TABLE [dbo].[dmsched3] ADD  DEFAULT ((0)) FOR [s3_typeid]
GO
ALTER TABLE [dbo].[dmsched3] ADD  DEFAULT (NULL) FOR [s3_start]
GO
ALTER TABLE [dbo].[dmsched3] ADD  DEFAULT (NULL) FOR [s3_end]
GO
ALTER TABLE [dbo].[dmsched3] ADD  DEFAULT ((1)) FOR [s3_active]
GO
ALTER TABLE [dbo].[dmsched3] ADD  DEFAULT ((0)) FOR [s3_endtime]
GO
ALTER TABLE [dbo].[dmsched3] ADD  DEFAULT ((0)) FOR [s3_starttime]
GO
ALTER TABLE [dbo].[dmsched3] ADD  DEFAULT ('Un-Available') FOR [s3_avail]
GO
ALTER TABLE [dbo].[dmsched3] ADD  DEFAULT ('') FOR [s3_name]
GO
ALTER TABLE [dbo].[dmschedrule] ADD  DEFAULT ('') FOR [sr_name]
GO
ALTER TABLE [dbo].[dmschedrule] ADD  DEFAULT ((1)) FOR [sr_active]
GO
ALTER TABLE [dbo].[dmschedrulesort] ADD  DEFAULT ((0)) FOR [ss_srid]
GO
ALTER TABLE [dbo].[dmschedrulesort] ADD  DEFAULT ((0)) FOR [ss_seq]
GO
ALTER TABLE [dbo].[dmschedrulesort] ADD  DEFAULT ((0)) FOR [ss_opid]
GO
ALTER TABLE [dbo].[dmschedrulesort] ADD  DEFAULT ('Certified Operation') FOR [ss_type]
GO
ALTER TABLE [dbo].[dmschedrulesort] ADD  DEFAULT ('') FOR [ss_expression]
GO
ALTER TABLE [dbo].[dmsecquest] ADD  DEFAULT ('') FOR [sq_question]
GO
ALTER TABLE [dbo].[dmsecquest] ADD  DEFAULT ((1)) FOR [sq_active]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_name]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_street]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_street2]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_city]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_state]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_zip]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_phone]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_fax]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_contact]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ((0)) FOR [se_default]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ((1)) FOR [se_active]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_phext]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ((0)) FOR [se_shid]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT (' ') FOR [se_ccode]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_email]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_country]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_county]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ((0)) FOR [se_tranwaid]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ((0)) FOR [se_cyid]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_street3]
GO
ALTER TABLE [dbo].[dmsend] ADD  DEFAULT ('') FOR [se_dba]
GO
ALTER TABLE [dbo].[dmseq1] ADD  DEFAULT ('') FOR [s1_name]
GO
ALTER TABLE [dbo].[dmseq1] ADD  DEFAULT ((1)) FOR [s1_active]
GO
ALTER TABLE [dbo].[dmseq1] ADD  DEFAULT ((0)) FOR [s1_seq]
GO
ALTER TABLE [dbo].[dmseq2] ADD  DEFAULT ('') FOR [s2_name]
GO
ALTER TABLE [dbo].[dmseq2] ADD  DEFAULT ((1)) FOR [s2_active]
GO
ALTER TABLE [dbo].[dmseq2] ADD  DEFAULT ((0)) FOR [s2_seq]
GO
ALTER TABLE [dbo].[dmsgrp] ADD  DEFAULT ('') FOR [sg_name]
GO
ALTER TABLE [dbo].[dmsgrp] ADD  DEFAULT ((1)) FOR [sg_active]
GO
ALTER TABLE [dbo].[dmsgrp] ADD  DEFAULT ((0)) FOR [sg_default]
GO
ALTER TABLE [dbo].[dmsgrp] ADD  DEFAULT ((0)) FOR [sg_quota]
GO
ALTER TABLE [dbo].[dmshift] ADD  DEFAULT ('') FOR [sf_name]
GO
ALTER TABLE [dbo].[dmshift] ADD  DEFAULT ((1)) FOR [sf_active]
GO
ALTER TABLE [dbo].[dmshift] ADD  DEFAULT ((0)) FOR [sf_actualstart]
GO
ALTER TABLE [dbo].[dmshift] ADD  DEFAULT ((0)) FOR [sf_actualend]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_name]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_biid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_brid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_s1id]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_s2id]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_smid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_street]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_street2]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_city]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_state]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_zip]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_phone]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_fax]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_contact]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_trid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_waid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((1)) FOR [sh_active]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_statax]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_loctax]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_notes]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_country]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT (' ') FOR [sh_ccode]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_default]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_county]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_custid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_email]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_frid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_s3id]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_webname]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_webpass]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_s4id]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_s5id]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_credlim]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_pastday]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT (NULL) FOR [sh_credhld]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_collect]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((1)) FOR [sh_teid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_phext]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT (NULL) FOR [sh_lastcred]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_nextact]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT (NULL) FOR [sh_nextdate]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_exid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_dear]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_said]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_tranwaid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((1)) FOR [sh_fcid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_pjid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_popup]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_quota]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_exempt]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((1)) FOR [sh_service]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_exceed]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_exday]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_credflag]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_dgid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_psid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_poreqd]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_pomask]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_waretaxover]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_shelfpct]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_popupship]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_dba]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_trakid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_trak2id]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_shelfdays]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_sotrakid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((5)) FOR [sh_prior]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_crosswaid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_bomon]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_bofulltr]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_bofullpl]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_botue]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_bowed]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_bothu]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_bofri]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_bosat]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_bosun]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((1)) FOR [sh_exreserve]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_routeacct]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_latitude]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_longitude]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('follow') FOR [sh_shortship]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((1)) FOR [sh_reqdsdsig]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_shipzone]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_reqcpart]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_availall]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_street3]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_ccid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('Printer') FOR [sh_prtdgrpto]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_caid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_noinvdflt]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_noreserve]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_retattrib1]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_retattrib2]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_retattrib3]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_retdates]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT (NULL) FOR [sh_laststateprint]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_creddueshipdays]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_ttid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT (NULL) FOR [sh_addressvalid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_svctype]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_edishiptopo]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_edishiptopodays]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_retainreservedbo]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT (NULL) FOR [sh_exemptexpires]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('Reserved') FOR [sh_linkedjobfinish]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_vatid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_cyid]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ((0)) FOR [sh_serializeonreserve]
GO
ALTER TABLE [dbo].[dmship] ADD  DEFAULT ('') FOR [sh_taxexemptcode]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ((0)) FOR [sa_shid]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ((0)) FOR [sa_trid]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ((1)) FOR [sa_active]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ((0)) FOR [sa_default]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ('') FOR [sa_descrip]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ('') FOR [sa_name]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ('') FOR [sa_account]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ('') FOR [sa_svctype]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ('') FOR [sa_svcprovider]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ((0)) FOR [sa_biid]
GO
ALTER TABLE [dbo].[dmshipacc] ADD  DEFAULT ((0)) FOR [sa_billtype]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_shid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_waid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_s1id]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_s2id]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_s3id]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_s4id]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_s5id]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_brid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_trid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_frid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_dgid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_psid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_sotrakid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_pjid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ((0)) FOR [sf_fcid]
GO
ALTER TABLE [dbo].[dmshipfacility] ADD  DEFAULT ('') FOR [sf_shipzone]
GO
ALTER TABLE [dbo].[dmshop] ADD  DEFAULT ('') FOR [sh_name]
GO
ALTER TABLE [dbo].[dmshop] ADD  DEFAULT ((1)) FOR [sh_active]
GO
ALTER TABLE [dbo].[dmshop] ADD  DEFAULT ((0)) FOR [sh_default]
GO
ALTER TABLE [dbo].[dmshop] ADD  DEFAULT ((0)) FOR [sh_waid]
GO
ALTER TABLE [dbo].[dmshoploc] ADD  DEFAULT ((0)) FOR [sl_loid]
GO
ALTER TABLE [dbo].[dmshoploc] ADD  DEFAULT ((0)) FOR [sl_seq]
GO
ALTER TABLE [dbo].[dmshoploc] ADD  DEFAULT ((0)) FOR [sl_shid]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_fname]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_lname]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_street]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_street2]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_city]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_state]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_zip]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_hphone]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_fax]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_cphone]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_beeper]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ((1)) FOR [sm_active]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ((0)) FOR [sm_default]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_webname]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_webpass]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ((1)) FOR [sm_sgid]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ((0)) FOR [sm_quota]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_email]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ((0)) FOR [sm_mobileid]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ((1)) FOR [sm_eligible]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT (' ') FOR [sm_ccode]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ((0)) FOR [sm_veid]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ((0)) FOR [sm_cyid]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ('') FOR [sm_repid]
GO
ALTER TABLE [dbo].[dmsman] ADD  DEFAULT ((0)) FOR [sm_managersmid]
GO
ALTER TABLE [dbo].[dmsman2] ADD  DEFAULT ((0)) FOR [s2_smid]
GO
ALTER TABLE [dbo].[dmsman2] ADD  DEFAULT ((0)) FOR [s2_pct]
GO
ALTER TABLE [dbo].[dmsman2] ADD  DEFAULT ('') FOR [s2_table]
GO
ALTER TABLE [dbo].[dmsman2] ADD  DEFAULT ((0)) FOR [s2_recid]
GO
ALTER TABLE [dbo].[dmsman2] ADD  DEFAULT ((0)) FOR [s2_primary]
GO
ALTER TABLE [dbo].[dmsman2] ADD  DEFAULT ((0)) FOR [s2_changeuser]
GO
ALTER TABLE [dbo].[dmsman2] ADD  DEFAULT ((0)) FOR [s2_scid]
GO
ALTER TABLE [dbo].[dmsman2cat] ADD  DEFAULT ('') FOR [sc_name]
GO
ALTER TABLE [dbo].[dmsman2cat] ADD  DEFAULT ((1)) FOR [sc_active]
GO
ALTER TABLE [dbo].[dmso1] ADD  DEFAULT ('') FOR [s1_name]
GO
ALTER TABLE [dbo].[dmso1] ADD  DEFAULT ((1)) FOR [s1_active]
GO
ALTER TABLE [dbo].[dmso1] ADD  DEFAULT ((0)) FOR [s1_default]
GO
ALTER TABLE [dbo].[dmso1] ADD  DEFAULT ((0)) FOR [s1_quota]
GO
ALTER TABLE [dbo].[dmso2] ADD  DEFAULT ((1)) FOR [s2_active]
GO
ALTER TABLE [dbo].[dmso2] ADD  DEFAULT ((0)) FOR [s2_default]
GO
ALTER TABLE [dbo].[dmso2] ADD  DEFAULT ('') FOR [s2_name]
GO
ALTER TABLE [dbo].[dmso2] ADD  DEFAULT ((0)) FOR [s2_quota]
GO
ALTER TABLE [dbo].[dmso3] ADD  DEFAULT ('') FOR [s3_name]
GO
ALTER TABLE [dbo].[dmso3] ADD  DEFAULT ((1)) FOR [s3_active]
GO
ALTER TABLE [dbo].[dmso3] ADD  DEFAULT ((0)) FOR [s3_default]
GO
ALTER TABLE [dbo].[dmso3] ADD  DEFAULT ((0)) FOR [s3_quota]
GO
ALTER TABLE [dbo].[dmso4] ADD  DEFAULT ((1)) FOR [s4_active]
GO
ALTER TABLE [dbo].[dmso4] ADD  DEFAULT ((0)) FOR [s4_default]
GO
ALTER TABLE [dbo].[dmso4] ADD  DEFAULT ('') FOR [s4_name]
GO
ALTER TABLE [dbo].[dmso4] ADD  DEFAULT ((0)) FOR [s4_quota]
GO
ALTER TABLE [dbo].[dmso5] ADD  DEFAULT ((1)) FOR [s5_active]
GO
ALTER TABLE [dbo].[dmso5] ADD  DEFAULT ((0)) FOR [s5_default]
GO
ALTER TABLE [dbo].[dmso5] ADD  DEFAULT ('') FOR [s5_name]
GO
ALTER TABLE [dbo].[dmso5] ADD  DEFAULT ((0)) FOR [s5_quota]
GO
ALTER TABLE [dbo].[dmstability] ADD  DEFAULT ((0)) FOR [st_reid]
GO
ALTER TABLE [dbo].[dmstability] ADD  DEFAULT ((0)) FOR [st_qcid]
GO
ALTER TABLE [dbo].[dmstability] ADD  DEFAULT ((0)) FOR [st_days]
GO
ALTER TABLE [dbo].[dmstability] ADD  DEFAULT ('Days') FOR [st_freqtype]
GO
ALTER TABLE [dbo].[dmstat] ADD  DEFAULT ((0)) FOR [st_active]
GO
ALTER TABLE [dbo].[dmstat] ADD  DEFAULT ((0)) FOR [st_default]
GO
ALTER TABLE [dbo].[dmstat] ADD  DEFAULT (' ') FOR [st_name]
GO
ALTER TABLE [dbo].[dmstat] ADD  DEFAULT ((0)) FOR [st_level]
GO
ALTER TABLE [dbo].[dmstat] ADD  DEFAULT ((0)) FOR [st_dxnew]
GO
ALTER TABLE [dbo].[dmstat] ADD  DEFAULT ((0)) FOR [st_resolve]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ((0)) FOR [su_child]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ((0)) FOR [su_parent]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ((1)) FOR [su_quant]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ((1)) FOR [su_factor]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ((0)) FOR [su_priority]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ('All') FOR [su_subtype]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ('') FOR [su_table]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT (NULL) FOR [su_start]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT (NULL) FOR [su_end]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ((0)) FOR [su_boid]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ((0)) FOR [su_suball]
GO
ALTER TABLE [dbo].[dmsubs] ADD  DEFAULT ((0)) FOR [su_recid]
GO
ALTER TABLE [dbo].[dmsvccontract] ADD  DEFAULT ((1)) FOR [sc_active]
GO
ALTER TABLE [dbo].[dmsvccontract] ADD  DEFAULT ((0)) FOR [sc_default]
GO
ALTER TABLE [dbo].[dmsvccontract] ADD  DEFAULT ('') FOR [sc_name]
GO
ALTER TABLE [dbo].[dmsvccontract] ADD  DEFAULT ('') FOR [sc_descrip]
GO
ALTER TABLE [dbo].[dmsvccontract] ADD  DEFAULT ((0)) FOR [sc_priority]
GO
ALTER TABLE [dbo].[dmsvcitem] ADD  DEFAULT ('') FOR [si_name]
GO
ALTER TABLE [dbo].[dmsvcitem] ADD  DEFAULT ((0)) FOR [si_prid]
GO
ALTER TABLE [dbo].[dmsvcitem] ADD  DEFAULT ('') FOR [si_serial]
GO
ALTER TABLE [dbo].[dmsvcitem] ADD  DEFAULT ((0)) FOR [si_scid]
GO
ALTER TABLE [dbo].[dmsvcitem] ADD  DEFAULT ((0)) FOR [si_biid]
GO
ALTER TABLE [dbo].[dmsvcitem] ADD  DEFAULT ((0)) FOR [si_shid]
GO
ALTER TABLE [dbo].[dmsvcitem] ADD  DEFAULT ((1)) FOR [si_active]
GO
ALTER TABLE [dbo].[dmsvcitem] ADD  DEFAULT ((0)) FOR [si_default]
GO
ALTER TABLE [dbo].[dmsvclabor] ADD  DEFAULT ('') FOR [sl_name]
GO
ALTER TABLE [dbo].[dmsvclabor] ADD  DEFAULT ((0)) FOR [sl_opid]
GO
ALTER TABLE [dbo].[dmsvclabor] ADD  DEFAULT ((0)) FOR [sl_prid]
GO
ALTER TABLE [dbo].[dmsvclabor] ADD  DEFAULT ('') FOR [sl_table]
GO
ALTER TABLE [dbo].[dmsvclabor] ADD  DEFAULT ((0)) FOR [sl_recid]
GO
ALTER TABLE [dbo].[dmtaskcat] ADD  DEFAULT ((1)) FOR [tc_active]
GO
ALTER TABLE [dbo].[dmtaskcat] ADD  DEFAULT ((0)) FOR [tc_default]
GO
ALTER TABLE [dbo].[dmtaskcat] ADD  DEFAULT ('') FOR [tc_name]
GO
ALTER TABLE [dbo].[dmtaskcat] ADD  DEFAULT ((0)) FOR [tc_weight]
GO
ALTER TABLE [dbo].[dmtaskcatstat] ADD  DEFAULT ((1)) FOR [ts_active]
GO
ALTER TABLE [dbo].[dmtaskcatstat] ADD  DEFAULT ((0)) FOR [ts_default]
GO
ALTER TABLE [dbo].[dmtaskcatstat] ADD  DEFAULT ((1)) FOR [ts_incperc]
GO
ALTER TABLE [dbo].[dmtaskcatstat] ADD  DEFAULT ('') FOR [ts_name]
GO
ALTER TABLE [dbo].[dmtaskcatstat] ADD  DEFAULT ((0)) FOR [ts_percentage]
GO
ALTER TABLE [dbo].[dmtaskcatstat] ADD  DEFAULT ((0)) FOR [ts_tcid]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ('') FOR [ta_name]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ((0)) FOR [ta_chid]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ((0)) FOR [ta_rate]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ((1)) FOR [ta_active]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ((0)) FOR [ta_default]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ('Sales') FOR [ta_type]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ((0)) FOR [ta_maxtax]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ((0)) FOR [ta_pochid]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ('Sales') FOR [ta_apply]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ('') FOR [ta_notes]
GO
ALTER TABLE [dbo].[dmtax] ADD  DEFAULT ((0)) FOR [ta_taxjar]
GO
ALTER TABLE [dbo].[dmtaxlink] ADD  DEFAULT ((0)) FOR [tl_recid]
GO
ALTER TABLE [dbo].[dmtaxlink] ADD  DEFAULT ('') FOR [tl_table]
GO
ALTER TABLE [dbo].[dmtaxlink] ADD  DEFAULT ((0)) FOR [tl_taid]
GO
ALTER TABLE [dbo].[dmtaxlink] ADD  DEFAULT ((1)) FOR [tl_active]
GO
ALTER TABLE [dbo].[dmtaxlink] ADD  DEFAULT ((0)) FOR [tl_rate]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_discoun]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_discday]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((1)) FOR [te_active]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_endday]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_dueday]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_finchar]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_future]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ('Invoice') FOR [te_billtype]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ('Number of Days') FOR [te_duetype]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ('Number of Days') FOR [te_disctype]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ('') FOR [te_name]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_discmon]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_duemon]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_multipay]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_payments]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_reqauth]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_interest]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ('') FOR [te_notes]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ('None') FOR [te_ccprocess]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_ccperc]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT (NULL) FOR [te_discdayyear]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT (NULL) FOR [te_duedayyear]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_prepay]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((0)) FOR [te_multibackord]
GO
ALTER TABLE [dbo].[dmterm] ADD  DEFAULT ((1)) FOR [te_reauthbackord]
GO
ALTER TABLE [dbo].[dmterm2] ADD  DEFAULT ((0)) FOR [t2_teid]
GO
ALTER TABLE [dbo].[dmterm2] ADD  DEFAULT ('') FOR [t2_table]
GO
ALTER TABLE [dbo].[dmterm2] ADD  DEFAULT ((0)) FOR [t2_recid]
GO
ALTER TABLE [dbo].[dmterritory] ADD  DEFAULT ('') FOR [tt_name]
GO
ALTER TABLE [dbo].[dmterritory] ADD  DEFAULT ((1)) FOR [tt_active]
GO
ALTER TABLE [dbo].[dmterritorygrp] ADD  DEFAULT ('') FOR [tg_name]
GO
ALTER TABLE [dbo].[dmterritorygrp] ADD  DEFAULT ((1)) FOR [tg_active]
GO
ALTER TABLE [dbo].[dmterritorygrp] ADD  DEFAULT ((0)) FOR [tg_default]
GO
ALTER TABLE [dbo].[dmterritorygrplink] ADD  DEFAULT ((0)) FOR [tl_tgid]
GO
ALTER TABLE [dbo].[dmterritorygrplink] ADD  DEFAULT ((0)) FOR [tl_ttid]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ((0)) FOR [te_tcid]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT (' ') FOR [te_name]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ('') FOR [te_valid]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ((0)) FOR [te_usid]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ((1)) FOR [te_active]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ('') FOR [te_code]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ((0)) FOR [te_recurring]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ('') FOR [te_notes]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ((999)) FOR [te_seq]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT (' ') FOR [te_impact]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ('Low') FOR [te_stability]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT (' ') FOR [te_ref]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ((0)) FOR [te_tsid]
GO
ALTER TABLE [dbo].[dmtest] ADD  DEFAULT ('') FOR [te_depends]
GO
ALTER TABLE [dbo].[dmtestcat] ADD  DEFAULT (' ') FOR [tc_name]
GO
ALTER TABLE [dbo].[dmtestcat] ADD  DEFAULT ((1)) FOR [tc_active]
GO
ALTER TABLE [dbo].[dmtestcatsub] ADD  DEFAULT (' ') FOR [ts_name]
GO
ALTER TABLE [dbo].[dmtestcatsub] ADD  DEFAULT ((0)) FOR [ts_tcid]
GO
ALTER TABLE [dbo].[dmtestcatsub] ADD  DEFAULT ((1)) FOR [ts_active]
GO
ALTER TABLE [dbo].[dmtgrp] ADD  DEFAULT ('') FOR [tg_name]
GO
ALTER TABLE [dbo].[dmtgrp] ADD  DEFAULT ((1)) FOR [tg_active]
GO
ALTER TABLE [dbo].[dmtgrp] ADD  DEFAULT ((0)) FOR [tg_default]
GO
ALTER TABLE [dbo].[dmtgrp] ADD  DEFAULT ('') FOR [tg_code]
GO
ALTER TABLE [dbo].[dmtgrp2] ADD  DEFAULT ((0)) FOR [t2_tgid]
GO
ALTER TABLE [dbo].[dmtgrp2] ADD  DEFAULT ((0)) FOR [t2_shid]
GO
ALTER TABLE [dbo].[dmti1] ADD  DEFAULT ('') FOR [t1_name]
GO
ALTER TABLE [dbo].[dmti1] ADD  DEFAULT ((1)) FOR [t1_active]
GO
ALTER TABLE [dbo].[dmti1] ADD  DEFAULT ((0)) FOR [t1_default]
GO
ALTER TABLE [dbo].[dmti2] ADD  DEFAULT ('') FOR [t2_name]
GO
ALTER TABLE [dbo].[dmti2] ADD  DEFAULT ((1)) FOR [t2_active]
GO
ALTER TABLE [dbo].[dmti2] ADD  DEFAULT ((0)) FOR [t2_default]
GO
ALTER TABLE [dbo].[dmti3] ADD  DEFAULT ('') FOR [t3_name]
GO
ALTER TABLE [dbo].[dmti3] ADD  DEFAULT ((1)) FOR [t3_active]
GO
ALTER TABLE [dbo].[dmti3] ADD  DEFAULT ((0)) FOR [t3_default]
GO
ALTER TABLE [dbo].[dmti4] ADD  DEFAULT ('') FOR [t4_name]
GO
ALTER TABLE [dbo].[dmti4] ADD  DEFAULT ((1)) FOR [t4_active]
GO
ALTER TABLE [dbo].[dmti4] ADD  DEFAULT ((0)) FOR [t4_default]
GO
ALTER TABLE [dbo].[dmti5] ADD  DEFAULT ('') FOR [t5_name]
GO
ALTER TABLE [dbo].[dmti5] ADD  DEFAULT ((1)) FOR [t5_active]
GO
ALTER TABLE [dbo].[dmti5] ADD  DEFAULT ((0)) FOR [t5_default]
GO
ALTER TABLE [dbo].[dmticketcats] ADD  DEFAULT ((1)) FOR [tc_active]
GO
ALTER TABLE [dbo].[dmticketcats] ADD  DEFAULT ('') FOR [tc_name]
GO
ALTER TABLE [dbo].[dmticketcats] ADD  DEFAULT ((0)) FOR [tc_default]
GO
ALTER TABLE [dbo].[dmticketcatsec] ADD  DEFAULT ('') FOR [ts_access]
GO
ALTER TABLE [dbo].[dmticketcatsec] ADD  DEFAULT ((0)) FOR [ts_tcid]
GO
ALTER TABLE [dbo].[dmticketcatsec] ADD  DEFAULT ((0)) FOR [ts_ugid]
GO
ALTER TABLE [dbo].[dmticknotetype] ADD  DEFAULT ((1)) FOR [te_active]
GO
ALTER TABLE [dbo].[dmticknotetype] ADD  DEFAULT ((0)) FOR [te_default]
GO
ALTER TABLE [dbo].[dmticknotetype] ADD  DEFAULT ('') FOR [te_name]
GO
ALTER TABLE [dbo].[dmticknotetype] ADD  DEFAULT ((0)) FOR [te_noid]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_name]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((1)) FOR [tr_active]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_default]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_contact]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_street]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_street2]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_city]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_state]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_zip]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_phone]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_fax]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_email]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_maxwgt]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT (' ') FOR [tr_ccode]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('None') FOR [tr_svctype]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_loadunid]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_loadsize]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_splitload]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_carcode]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_veid]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_cyid]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((1)) FOR [tr_packinstreq]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_picktime]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('M') FOR [tr_pickday]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('M') FOR [tr_shipday]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('M') FOR [tr_delday]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_minord]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_labor]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_burden]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_approvalreq]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_dsdinvsync]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_dsdinvsyncloc]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_svcprovider]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_shipdays]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_deliverydays]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('None') FOR [tr_splitloadsize]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('') FOR [tr_country]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_deliverto]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_dsdloid]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ((0)) FOR [tr_dsdchid]
GO
ALTER TABLE [dbo].[dmtruk] ADD  DEFAULT ('All') FOR [tr_ordtype]
GO
ALTER TABLE [dbo].[dmtrukauth] ADD  DEFAULT ((0)) FOR [ta_shid]
GO
ALTER TABLE [dbo].[dmtrukauth] ADD  DEFAULT ((0)) FOR [ta_trid]
GO
ALTER TABLE [dbo].[dmtrukauth] ADD  DEFAULT ((0)) FOR [ta_waid]
GO
ALTER TABLE [dbo].[dmtrukauth] ADD  DEFAULT ((0)) FOR [ta_minord]
GO
ALTER TABLE [dbo].[dmtrukauth] ADD  DEFAULT ((0)) FOR [ta_labor]
GO
ALTER TABLE [dbo].[dmtrukauth] ADD  DEFAULT ((0)) FOR [ta_burden]
GO
ALTER TABLE [dbo].[dmtrukauth] ADD  DEFAULT ((1)) FOR [ta_overridedefault]
GO
ALTER TABLE [dbo].[dmtrukauth] ADD  DEFAULT ((0)) FOR [ta_seq]
GO
ALTER TABLE [dbo].[dmtrukfacility] ADD  DEFAULT ((0)) FOR [tf_trid]
GO
ALTER TABLE [dbo].[dmtrukfacility] ADD  DEFAULT ((0)) FOR [tf_waid]
GO
ALTER TABLE [dbo].[dmtrukfacility] ADD  DEFAULT ('All') FOR [tf_ordtype]
GO
ALTER TABLE [dbo].[dmtrukpickdays] ADD  DEFAULT ((0)) FOR [td_trid]
GO
ALTER TABLE [dbo].[dmtrukpickdays] ADD  DEFAULT ('') FOR [td_day]
GO
ALTER TABLE [dbo].[dmtype] ADD  DEFAULT (' ') FOR [ty_name]
GO
ALTER TABLE [dbo].[dmtype] ADD  DEFAULT ((0)) FOR [ty_active]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ('') FOR [un_name]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ((1)) FOR [un_active]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ((0)) FOR [un_default]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ('e') FOR [un_type]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ((0)) FOR [un_base]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ((1)) FOR [un_factor]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ((0)) FOR [un_shipmins]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ((0)) FOR [un_recmins]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ((0)) FOR [un_restcontunid]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ((1)) FOR [un_fedexfactor]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ('EA') FOR [un_fedexunit]
GO
ALTER TABLE [dbo].[dmunit] ADD  DEFAULT ('') FOR [un_edicode]
GO
ALTER TABLE [dbo].[dmunitmins] ADD  DEFAULT ((0)) FOR [um_recid]
GO
ALTER TABLE [dbo].[dmunitmins] ADD  DEFAULT ('') FOR [um_table]
GO
ALTER TABLE [dbo].[dmunitmins] ADD  DEFAULT ((0)) FOR [um_unid]
GO
ALTER TABLE [dbo].[dmunitmins] ADD  DEFAULT ((0)) FOR [um_recmins]
GO
ALTER TABLE [dbo].[dmunitmins] ADD  DEFAULT ((0)) FOR [um_shipmins]
GO
ALTER TABLE [dbo].[dmunitmins] ADD  DEFAULT ((0)) FOR [um_restrictreceiveunit]
GO
ALTER TABLE [dbo].[dmunitmins] ADD  DEFAULT ((0)) FOR [um_restrictcountunit]
GO
ALTER TABLE [dbo].[dmunitmins] ADD  DEFAULT ((0)) FOR [um_restrictedsalesunit]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_usid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_waid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_smid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_foid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_lgid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_reid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((1)) FOR [ur_allow]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_sgid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_ordenter]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_purenter]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_daid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_mobileid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_buid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_biid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_brid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_shid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_veid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT (NULL) FOR [ur_lastemailpull]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_zoid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ('Both') FOR [ur_interface]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_coid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_mrid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_ttid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_tgid]
GO
ALTER TABLE [dbo].[dmurst] ADD  DEFAULT ((0)) FOR [ur_facpartsrestrict]
GO
ALTER TABLE [dbo].[dmuserlayout] ADD  DEFAULT ('') FOR [ul_class]
GO
ALTER TABLE [dbo].[dmuserlayout] ADD  DEFAULT ('') FOR [ul_descrip]
GO
ALTER TABLE [dbo].[dmuserlayout] ADD  DEFAULT ('') FOR [ul_fortype]
GO
ALTER TABLE [dbo].[dmuserlayout] ADD  DEFAULT ((0)) FOR [ul_c2id]
GO
ALTER TABLE [dbo].[dmuserlayout] ADD  DEFAULT ((0)) FOR [ul_forid]
GO
ALTER TABLE [dbo].[dmuserlayout] ADD  DEFAULT ((1)) FOR [ul_active]
GO
ALTER TABLE [dbo].[dmuserlayout] ADD  DEFAULT ('All') FOR [ul_device]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ('') FOR [uc_type]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ('') FOR [uc_function]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_parent]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_seq]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_column]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_disable]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_hide]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_require]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_c2id]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_ulid]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ('No') FOR [uc_unique]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ('') FOR [uc_defaultvalue]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_scaleinput]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ('') FOR [uc_searchboxoverride]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] ADD  DEFAULT ((0)) FOR [uc_srnumber]
GO
ALTER TABLE [dbo].[dmuserlayoutdeletion] ADD  DEFAULT ('') FOR [ud_function]
GO
ALTER TABLE [dbo].[dmuserlayoutdeletion] ADD  DEFAULT ((0)) FOR [ud_ulid]
GO
ALTER TABLE [dbo].[dmuserlayoutproperty] ADD  DEFAULT ((0)) FOR [up_ulid]
GO
ALTER TABLE [dbo].[dmuserlayoutproperty] ADD  DEFAULT ((0)) FOR [up_ucid]
GO
ALTER TABLE [dbo].[dmuserlayoutproperty] ADD  DEFAULT ('') FOR [up_property]
GO
ALTER TABLE [dbo].[dmuserlayoutproperty] ADD  DEFAULT ((0)) FOR [up_intval]
GO
ALTER TABLE [dbo].[dmuserlayoutproperty] ADD  DEFAULT ('') FOR [up_charval]
GO
ALTER TABLE [dbo].[dmuserlayoutproperty] ADD  DEFAULT ('') FOR [up_memoval]
GO
ALTER TABLE [dbo].[dmuserprtdest] ADD  DEFAULT ((0)) FOR [ud_pdid]
GO
ALTER TABLE [dbo].[dmuserprtdest] ADD  DEFAULT ('') FOR [ud_printer]
GO
ALTER TABLE [dbo].[dmuserprtdest] ADD  DEFAULT ((0)) FOR [ud_usid]
GO
ALTER TABLE [dbo].[dmvalid] ADD  DEFAULT ('') FOR [va_validnum]
GO
ALTER TABLE [dbo].[dmvalid] ADD  DEFAULT ((1)) FOR [va_active]
GO
ALTER TABLE [dbo].[dmvat] ADD  DEFAULT ('') FOR [va_name]
GO
ALTER TABLE [dbo].[dmvat] ADD  DEFAULT ('') FOR [va_type]
GO
ALTER TABLE [dbo].[dmvat] ADD  DEFAULT ((0)) FOR [va_typeid]
GO
ALTER TABLE [dbo].[dmvat] ADD  DEFAULT ('') FOR [va_on]
GO
ALTER TABLE [dbo].[dmvat] ADD  DEFAULT ((0)) FOR [va_onid]
GO
ALTER TABLE [dbo].[dmvat] ADD  DEFAULT ((0)) FOR [va_saleschid]
GO
ALTER TABLE [dbo].[dmvat] ADD  DEFAULT ((0)) FOR [va_purchasechid]
GO
ALTER TABLE [dbo].[dmvatrate] ADD  DEFAULT ((0)) FOR [vr_rate]
GO
ALTER TABLE [dbo].[dmvatrate] ADD  DEFAULT (NULL) FOR [vr_startdate]
GO
ALTER TABLE [dbo].[dmvatrate] ADD  DEFAULT (NULL) FOR [vr_enddate]
GO
ALTER TABLE [dbo].[dmvatrate] ADD  DEFAULT ((0)) FOR [vr_vaid]
GO
ALTER TABLE [dbo].[dmvehicle] ADD  DEFAULT ('') FOR [vc_vehicle]
GO
ALTER TABLE [dbo].[dmvehicle] ADD  DEFAULT ((1)) FOR [vc_active]
GO
ALTER TABLE [dbo].[dmvehicle] ADD  DEFAULT ((0)) FOR [vc_waid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_name]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_street]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_street2]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_city]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_state]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_zip]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_contact]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_phone]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_fax]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((1)) FOR [ve_active]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_teid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_trid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_taxid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_socsec]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_1099]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_edi]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_notes]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rname]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rstreet]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rstreet2]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rcity]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rstate]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rzip]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_takedis]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_highcrd]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_potype]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_p1id]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_p2id]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_county]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_vendid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_email]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_dfltinv]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_frid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_dftchid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_webname]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_webpass]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_vgid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((1)) FOR [ve_backord]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rcontact]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_remail]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rfax]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rphone]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_phext]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rphext]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((1)) FOR [ve_waid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_taid1]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_taid2]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((1)) FOR [ve_fcid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_autoinv]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_popup]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_country]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_frtdisc]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT (' ') FOR [ve_ccode]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_apchid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_mobileid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_coid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_popuprecv]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rcountry]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_trakid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_trak2id]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_potrakid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('tp_date') FOR [ve_pricingbasedon]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_copyqc]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_vendordate]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_posuspchid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_street3]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_rstreet3]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_routpo]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((1)) FOR [ve_retainqc]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_retattrib1]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_retattrib2]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_retattrib3]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_retdates]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_minunid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_minunit]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_minext]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_availall]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_cyid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_rcyid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_caid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_invuniquenum]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_tyid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((1)) FOR [ve_linkposearch]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_pjid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_c3id]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_requiremfgvendor]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT (NULL) FOR [ve_approvalexpires]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('MISC') FOR [ve_1099type]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_psid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_vendorhold]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_invoicehold]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_paymenthold]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ('') FOR [ve_vatid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_brid]
GO
ALTER TABLE [dbo].[dmvend] ADD  DEFAULT ((0)) FOR [ve_baid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_veid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_waid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_vgid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_teid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_frid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_trid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_p1id]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_p2id]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_coid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_fcid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_potrakid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ('Public') FOR [vf_potype]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_tyid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ('Order Date') FOR [vf_pricingbasedon]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_pjid]
GO
ALTER TABLE [dbo].[dmvendfacility] ADD  DEFAULT ((0)) FOR [vf_brid]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_name]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ((1)) FOR [vg_active]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_street]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_street2]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_city]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_state]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_zip]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_street3]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_ccode]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_phone]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_fax]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_remitname]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ((0)) FOR [vg_baid]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_country]
GO
ALTER TABLE [dbo].[dmvgrp] ADD  DEFAULT ('') FOR [vg_email]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_name]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_active]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_default]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_exid]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_taid1]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_taid2]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('Follow Part') FOR [wa_neginv]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_reid]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_icxfer]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_street]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_street2]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_city]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_state]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_zip]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_phone]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fax]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_reqid]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_psid]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_markup]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('Cost Plus %') FOR [wa_marktype]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_biid]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT (' ') FOR [wa_ccode]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_haltposting]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_lottrackdsd]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('First Expired') FOR [wa_prodrel]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_shiponsave]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('COM1') FOR [wa_comport]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('9600') FOR [wa_baudrate]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('1') FOR [wa_stopbits]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('None') FOR [wa_parity]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('None') FOR [wa_handshake]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('8') FOR [wa_databits]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_custfirst]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_retainicloc]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_finlinkjob]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_addthandle]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_emergency]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_ictautoreceive]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_cyid]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_country]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_gln]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_fcid]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_tranholdlotcont]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_overissueprompt]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_overreserveprompt]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('none') FOR [wa_wmsincreserve]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('none') FOR [wa_wmsincissue]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_underissueprompt]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_restrictop]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_taxjaroverride]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_issuinggroupby]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('Lot') FOR [wa_ictrecqty]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_linkedsoallocate]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_splitmrojobs]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedacc]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedpass]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedauth]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedmeternum]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedshipacc]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_fedtest]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_fedusefacility]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_upsacc]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_upspass]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_upsauthkey]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_upsshipnum]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_upstest]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_upsusefacility]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((1)) FOR [wa_ecomminv]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_ccprocid]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('Follow Sales Options') FOR [wa_taxtype]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_tjkey]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_taxuser]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_taxpass]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_tjname]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_taxsandboxmode]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_taxexemptapis]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_easypostapikey]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_taxcompcode]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('Follow Sales Options') FOR [wa_shipquan]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('Follow System Options') FOR [wa_defissquan]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedacclegacy]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedpasslegacy]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedauthlegacy]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedshipacclegacy]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_fedmeternumlegacy]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_retainlotcost]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ('') FOR [wa_xfercostexp]
GO
ALTER TABLE [dbo].[dmware] ADD  DEFAULT ((0)) FOR [wa_recmarkupover]
GO
ALTER TABLE [dbo].[dmware2] ADD  DEFAULT ((0)) FOR [w2_pos]
GO
ALTER TABLE [dbo].[dmware2] ADD  DEFAULT ((0)) FOR [w2_override]
GO
ALTER TABLE [dbo].[dmware2] ADD  DEFAULT ((0)) FOR [w2_waid]
GO
ALTER TABLE [dbo].[dmware3] ADD  DEFAULT ((0)) FOR [w3_waid]
GO
ALTER TABLE [dbo].[dmware3] ADD  DEFAULT ((0)) FOR [w3_reid]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_usid]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_ugid]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ('') FOR [wm_name]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_visible]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ('') FOR [wm_form]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_order]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_default]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ('Default') FOR [wm_defaultvalue]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((1)) FOR [wm_commitonscan]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_bfid]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ('Save / Reset') FOR [wm_savetype]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ('') FOR [wm_formfor]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_formid]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_dupscan]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_readprompts]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_voiceoutput]
GO
ALTER TABLE [dbo].[dmwmslayout] ADD  DEFAULT ((0)) FOR [wm_voiceconfirm]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_fname]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_lname]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_laid]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_street]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_street2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_city]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_state]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_zip]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_phone]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((1)) FOR [wo_active]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_rate]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_burden]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_salary]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_socsec]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_usid]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_weekot]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_dayot]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT (NULL) FOR [wo_hired]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_otfactr]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_user1]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_default]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_nostart]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyin]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyout]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_latein]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_lateout]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealin2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealin]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealout2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealout]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actin]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actin2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actin3]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actin4]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actin5]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actout]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actout2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actout3]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actout4]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actout5]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actin6]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actin7]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actout6]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_actout7]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyin2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyin3]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyin4]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyin5]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyin6]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyin7]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyout2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyout3]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyout4]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyout5]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyout6]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_earlyout7]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_latein2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_latein3]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_latein4]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_latein5]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_latein6]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_latein7]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_lateout2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_lateout3]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_lateout4]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_lateout5]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_lateout6]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_lateout7]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealin3]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealin4]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealin5]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealin6]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealin7]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealout3]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealout4]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealout5]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealout6]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_mealout7]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_nostart2]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_nostart3]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_nostart4]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_nostart5]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_nostart6]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_nostart7]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT (' ') FOR [wo_ccode]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ('') FOR [wo_birthday]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_ceid]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_crid]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_cyid]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_inactivityjob]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_waid]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_opid]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_seq]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_scheddaysweek]
GO
ALTER TABLE [dbo].[dmwork] ADD  DEFAULT ((0)) FOR [wo_schedconsecdays]
GO
ALTER TABLE [dbo].[dmworkcert] ADD  DEFAULT ((0)) FOR [wc_woid]
GO
ALTER TABLE [dbo].[dmworkcert] ADD  DEFAULT ((0)) FOR [wc_opid]
GO
ALTER TABLE [dbo].[dmzip] ADD  DEFAULT ('') FOR [zi_zipcode]
GO
ALTER TABLE [dbo].[dmzip] ADD  DEFAULT ((0)) FOR [zi_taid1]
GO
ALTER TABLE [dbo].[dmzip] ADD  DEFAULT ((0)) FOR [zi_taid2]
GO
ALTER TABLE [dbo].[dmzip] ADD  DEFAULT ((1)) FOR [zi_active]
GO
ALTER TABLE [dbo].[dmzone] ADD  DEFAULT ('') FOR [zo_name]
GO
ALTER TABLE [dbo].[dmzone] ADD  DEFAULT ((1)) FOR [zo_active]
GO
ALTER TABLE [dbo].[dmzone] ADD  DEFAULT ((0)) FOR [zo_default]
GO
ALTER TABLE [dbo].[dmzone] ADD  DEFAULT ((0)) FOR [zo_waid]
GO
ALTER TABLE [dbo].[dmzone] ADD  DEFAULT ((0)) FOR [zo_haltposting]
GO
ALTER TABLE [dbo].[dmzone] ADD  DEFAULT ((0)) FOR [zo_distinct]
GO
ALTER TABLE [dbo].[dmzone] ADD  DEFAULT ((0)) FOR [zo_prid]
GO
ALTER TABLE [dbo].[dmzoneloc] ADD  DEFAULT ((0)) FOR [zl_zoid]
GO
ALTER TABLE [dbo].[dmzoneloc] ADD  DEFAULT ((0)) FOR [zl_loid]
GO
ALTER TABLE [dbo].[dtap] ADD  DEFAULT ((0)) FOR [ap_purnum]
GO
ALTER TABLE [dbo].[dtap] ADD  DEFAULT ((0)) FOR [ap_chid]
GO
ALTER TABLE [dbo].[dtap] ADD  DEFAULT ((0)) FOR [ap_debits]
GO
ALTER TABLE [dbo].[dtap] ADD  DEFAULT ((0)) FOR [ap_credits]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ('') FOR [af_attrib1]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ('') FOR [af_attrib2]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ('') FOR [af_attrib3]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((0)) FOR [af_cancel]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ('') FOR [af_container]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((0)) FOR [af_density]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ('') FOR [af_error]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT (NULL) FOR [af_expires]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((1)) FOR [af_iscatch]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((0)) FOR [af_iscontainer]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((1)) FOR [af_isserial]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((0)) FOR [af_quantity]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT (NULL) FOR [af_recdate]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((0)) FOR [af_retry]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ('') FOR [af_apname]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ('') FOR [af_arname]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ('') FOR [af_serial]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ('') FOR [af_source]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((0)) FOR [af_status]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((0)) FOR [af_weight]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((0)) FOR [af_validate]
GO
ALTER TABLE [dbo].[dtautofinish] ADD  DEFAULT ((0)) FOR [af_finweight]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ('') FOR [ap_name]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ('') FOR [ap_source]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ('') FOR [ap_arname]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_palnum]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT (NULL) FOR [ap_recdate]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_quantity]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_weight]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ('') FOR [ap_first]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ('') FOR [ap_last]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_masterlot]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_printlabel]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_status]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ('') FOR [ap_error]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_cancel]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_retry]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_validate]
GO
ALTER TABLE [dbo].[dtautopallet] ADD  DEFAULT ((0)) FOR [ap_mlid]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ((0)) FOR [ar_closejob]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ('') FOR [ar_codenum]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT (NULL) FOR [ar_end]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ((0)) FOR [ar_jobnum]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ((0)) FOR [ar_linenum]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ((0)) FOR [ar_loid]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ('') FOR [ar_loname]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT (NULL) FOR [ar_lotdate]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ('') FOR [ar_ltname]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ('') FOR [ar_name]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ('') FOR [ar_printer]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ((0)) FOR [ar_quantity]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ((0)) FOR [ar_rellab]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ((0)) FOR [ar_relmat]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ((0)) FOR [ar_seq]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ('') FOR [ar_source]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT (NULL) FOR [ar_start]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ('') FOR [ar_userlot]
GO
ALTER TABLE [dbo].[dtautorun] ADD  DEFAULT ((0)) FOR [ar_waid]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_orid]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_prid]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_quant]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_ljid]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((1)) FOR [b2_unid]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_boid]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ('') FOR [b2_source]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_estcost]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_seq]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_scrap]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_overissue]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_nonprop]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_byproduct]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_subid]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((1)) FOR [b2_active]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_group]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_balance]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((1)) FOR [b2_factor]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_reqseq]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ('') FOR [b2_groupby]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_uselot]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_suball]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ('') FOR [b2_notes]
GO
ALTER TABLE [dbo].[dtbom2] ADD  DEFAULT ((0)) FOR [b2_issueunid]
GO
ALTER TABLE [dbo].[dtcalcs] ADD  DEFAULT ('') FOR [cs_value]
GO
ALTER TABLE [dbo].[dtcalcs] ADD  DEFAULT ((0)) FOR [cs_caid]
GO
ALTER TABLE [dbo].[dtcalcs] ADD  DEFAULT ((0)) FOR [cs_numval]
GO
ALTER TABLE [dbo].[dtcalcs] ADD  DEFAULT (NULL) FOR [cs_dateval]
GO
ALTER TABLE [dbo].[dtcalcs] ADD  DEFAULT ('') FOR [cs_table]
GO
ALTER TABLE [dbo].[dtcalcs] ADD  DEFAULT ((0)) FOR [cs_recid]
GO
ALTER TABLE [dbo].[dtcalcs] ADD  DEFAULT ('') FOR [cs_memo]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT (NULL) FOR [ca_date]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_arap]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_postref]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_c3id]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_check]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_cashamt]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_totamt]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_compnum]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_chid]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_vgid]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((1)) FOR [ca_fcid]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((1)) FOR [ca_fcrate]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_cashsale]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_validnum]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_usid]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT (NULL) FOR [ca_recdate]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_fccashamt]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_fctotamt]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_depositnum]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_name]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_street]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_street2]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_city]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_state]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_zip]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_emv]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_processdata]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_acqrefdata]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_refno]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_acctno]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_applabel]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_authcode]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_captstat]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_cardtype]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_emvdate]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_entrymethod]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_invoiceno]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_merchid]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_opid]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_terminalid]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_emvtime]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_trancode]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_emvpurchase]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_emvauthorized]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_aid]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_tvr]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_iad]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_tsi]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_arc]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_cvm]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_notes]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ((0)) FOR [ca_gcid]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_last4]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_street3]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_country]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_email]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_phone]
GO
ALTER TABLE [dbo].[dtcash] ADD  DEFAULT ('') FOR [ca_fax]
GO
ALTER TABLE [dbo].[dtcash2] ADD  DEFAULT ('') FOR [c2_postref]
GO
ALTER TABLE [dbo].[dtcash2] ADD  DEFAULT ((0)) FOR [c2_ordnum]
GO
ALTER TABLE [dbo].[dtcash2] ADD  DEFAULT ((0)) FOR [c2_chid]
GO
ALTER TABLE [dbo].[dtcash2] ADD  DEFAULT ((0)) FOR [c2_debits]
GO
ALTER TABLE [dbo].[dtcash2] ADD  DEFAULT ((0)) FOR [c2_credits]
GO
ALTER TABLE [dbo].[dtcash2] ADD  DEFAULT ((0)) FOR [c2_shid]
GO
ALTER TABLE [dbo].[dtcash2] ADD  DEFAULT ('Unknown') FOR [c2_type]
GO
ALTER TABLE [dbo].[dtcash2] ADD  DEFAULT ((0)) FOR [c2_fcdebits]
GO
ALTER TABLE [dbo].[dtcash2] ADD  DEFAULT ((0)) FOR [c2_fccredits]
GO
ALTER TABLE [dbo].[dtcheck] ADD  DEFAULT ((0)) FOR [ck_chid]
GO
ALTER TABLE [dbo].[dtcheck] ADD  DEFAULT ((0)) FOR [ck_number]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT ((0)) FOR [ci_shid]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT ((0)) FOR [ci_prid]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT ((0)) FOR [ci_quant]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT ((0)) FOR [ci_ordnum]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT (NULL) FOR [ci_zeroed]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT ((0)) FOR [ci_balance]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT ('') FOR [ci_serial]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT ((0)) FOR [ci_biid]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT ((0)) FOR [ci_siid]
GO
ALTER TABLE [dbo].[dtcinv] ADD  DEFAULT ((0)) FOR [ci_crid]
GO
ALTER TABLE [dbo].[dtcontrecents] ADD  DEFAULT ((0)) FOR [re_usid]
GO
ALTER TABLE [dbo].[dtcontrecents] ADD  DEFAULT ((0)) FOR [re_coid]
GO
ALTER TABLE [dbo].[dtcontrecents] ADD  DEFAULT (NULL) FOR [re_lastvisit]
GO
ALTER TABLE [dbo].[dtcontrecents] ADD  DEFAULT ('') FOR [re_timevisit]
GO
ALTER TABLE [dbo].[dtcount] ADD  DEFAULT ('') FOR [co_name]
GO
ALTER TABLE [dbo].[dtcount] ADD  DEFAULT ((0)) FOR [co_phid]
GO
ALTER TABLE [dbo].[dtcount] ADD  DEFAULT ('') FOR [co_team]
GO
ALTER TABLE [dbo].[dtcount] ADD  DEFAULT ((1)) FOR [co_active]
GO
ALTER TABLE [dbo].[dtcount] ADD  DEFAULT ((0)) FOR [co_usid]
GO
ALTER TABLE [dbo].[dtcount] ADD  DEFAULT (NULL) FOR [co_edited]
GO
ALTER TABLE [dbo].[dtcount] ADD  DEFAULT ('Main App') FOR [co_source]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_coid]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_prid]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_quant]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_seq]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ('') FOR [c2_loc]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ('') FOR [c2_userlot]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_syslot]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_loid]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_unid]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ('') FOR [c2_serial]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_catchwgt]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_container]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ('') FOR [c2_contnum]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_contunid]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT (NULL) FOR [c2_lotdate]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ('') FOR [c2_notes]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ('') FOR [c2_attrib1]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ('') FOR [c2_attrib2]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ('') FOR [c2_attrib3]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT ((0)) FOR [c2_tarewgt]
GO
ALTER TABLE [dbo].[dtcount2] ADD  DEFAULT (NULL) FOR [c2_expires]
GO
ALTER TABLE [dbo].[dtcrmproj] ADD  DEFAULT ('') FOR [cp_name]
GO
ALTER TABLE [dbo].[dtcrmproj] ADD  DEFAULT ((0)) FOR [cp_ccid]
GO
ALTER TABLE [dbo].[dtcrmproj] ADD  DEFAULT ('') FOR [cp_notes]
GO
ALTER TABLE [dbo].[dtcrmproj] ADD  DEFAULT ((0)) FOR [cp_coid]
GO
ALTER TABLE [dbo].[dtcrmproj] ADD  DEFAULT ('Open') FOR [cp_status]
GO
ALTER TABLE [dbo].[dtcrmproj] ADD  DEFAULT ((0)) FOR [cp_cpid]
GO
ALTER TABLE [dbo].[dtcrmproj] ADD  DEFAULT ((0)) FOR [cp_trak2id]
GO
ALTER TABLE [dbo].[dtcrmproj] ADD  DEFAULT ((0)) FOR [cp_trakid]
GO
ALTER TABLE [dbo].[dtcrmprojmilestone] ADD  DEFAULT ((1)) FOR [mn_active]
GO
ALTER TABLE [dbo].[dtcrmprojmilestone] ADD  DEFAULT ((0)) FOR [mn_default]
GO
ALTER TABLE [dbo].[dtcrmprojmilestone] ADD  DEFAULT (NULL) FOR [mn_targetdate]
GO
ALTER TABLE [dbo].[dtcrmprojmilestone] ADD  DEFAULT ('') FOR [mn_name]
GO
ALTER TABLE [dbo].[dtcrmprojmilestone] ADD  DEFAULT ((0)) FOR [mn_cpid]
GO
ALTER TABLE [dbo].[dtcrmprojmilestone] ADD  DEFAULT ('') FOR [mn_notes]
GO
ALTER TABLE [dbo].[dtcrmprojmilestone] ADD  DEFAULT ((0)) FOR [mn_seq]
GO
ALTER TABLE [dbo].[dtcrmprojnote] ADD  DEFAULT ((0)) FOR [pn_cpid]
GO
ALTER TABLE [dbo].[dtcrmprojnote] ADD  DEFAULT (NULL) FOR [pn_date]
GO
ALTER TABLE [dbo].[dtcrmprojnote] ADD  DEFAULT ('') FOR [pn_note]
GO
ALTER TABLE [dbo].[dtcrmprojnote] ADD  DEFAULT ((0)) FOR [pn_peid]
GO
ALTER TABLE [dbo].[dtcrmprojnote] ADD  DEFAULT ((0)) FOR [pn_time]
GO
ALTER TABLE [dbo].[dtcrmprojnote] ADD  DEFAULT ((0)) FOR [pn_usid]
GO
ALTER TABLE [dbo].[dtcrmprojnote] ADD  DEFAULT ((0)) FOR [pn_contactpersonid]
GO
ALTER TABLE [dbo].[dtcrmprojtask] ADD  DEFAULT ((1)) FOR [pt_active]
GO
ALTER TABLE [dbo].[dtcrmprojtask] ADD  DEFAULT ((0)) FOR [pt_cpid]
GO
ALTER TABLE [dbo].[dtcrmprojtask] ADD  DEFAULT (NULL) FOR [pt_end]
GO
ALTER TABLE [dbo].[dtcrmprojtask] ADD  DEFAULT ('') FOR [pt_name]
GO
ALTER TABLE [dbo].[dtcrmprojtask] ADD  DEFAULT ((0)) FOR [pt_seq]
GO
ALTER TABLE [dbo].[dtcrmprojtask] ADD  DEFAULT (NULL) FOR [pt_start]
GO
ALTER TABLE [dbo].[dtcrmprojtask] ADD  DEFAULT ((0)) FOR [pt_tcid]
GO
ALTER TABLE [dbo].[dtcrmprojtask] ADD  DEFAULT ((0)) FOR [pt_tsid]
GO
ALTER TABLE [dbo].[dtcrmprojtask] ADD  DEFAULT ((0)) FOR [pt_mnid]
GO
ALTER TABLE [dbo].[dtcrmprojtick] ADD  DEFAULT ((0)) FOR [ct_cpid]
GO
ALTER TABLE [dbo].[dtcrmprojtick] ADD  DEFAULT ((0)) FOR [ct_tiid]
GO
ALTER TABLE [dbo].[dtcrmprojtick] ADD  DEFAULT ((0)) FOR [ct_seq]
GO
ALTER TABLE [dbo].[dtcrmprojtick] ADD  DEFAULT ((0)) FOR [ct_mnid]
GO
ALTER TABLE [dbo].[dtd2] ADD  DEFAULT ((0)) FOR [d2_d1id]
GO
ALTER TABLE [dbo].[dtd2] ADD  DEFAULT ((0)) FOR [d2_recid]
GO
ALTER TABLE [dbo].[dtd2] ADD  DEFAULT ((0)) FOR [d2_group]
GO
ALTER TABLE [dbo].[dtd2] ADD  DEFAULT ('') FOR [d2_value]
GO
ALTER TABLE [dbo].[dtd2] ADD  DEFAULT ('') FOR [d2_memo]
GO
ALTER TABLE [dbo].[dtemailcode] ADD  DEFAULT ((0)) FOR [ec_usid]
GO
ALTER TABLE [dbo].[dtemailcode] ADD  DEFAULT ('') FOR [ec_code]
GO
ALTER TABLE [dbo].[dtemailcode] ADD  DEFAULT (NULL) FOR [ec_start]
GO
ALTER TABLE [dbo].[dtemailcode] ADD  DEFAULT (NULL) FOR [ec_end]
GO
ALTER TABLE [dbo].[dtemailcode] ADD  DEFAULT ((0)) FOR [ec_success]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_orid]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_ordnum]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_ts]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_bs]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_type]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_span]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_leftoh]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_righoh]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_toplum]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_botlum]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_ply]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_spacing]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_file]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_height]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_joints]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_sticks]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_linfeet]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_brdfeet]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_mats]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_labor]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_burden]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_picture1]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_picture2]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_lheel]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_rheel]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((-1)) FOR [in_toid]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_lispric]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_lumcost]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_platecost]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ('') FOR [in_notes]
GO
ALTER TABLE [dbo].[dteng] ADD  DEFAULT ((0)) FOR [in_uniquesticks]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT (NULL) FOR [fi_date]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT (NULL) FOR [fi_lotdate]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_lotnum]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_userlot]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_prid]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT (NULL) FOR [fi_zeroed]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_quant]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_balance]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_cost]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_postref]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_action]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT (' ') FOR [fi_loc]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_allonum]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_type]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_group]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_waid]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_chid]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_orid]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_exten]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_catchwgt]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_serial]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT (NULL) FOR [fi_expires]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_invcost]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_attrib1]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_attrib2]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_attrib3]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_descrip]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_q4group]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_qc]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_masterlot]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_tally]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_loid]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_notes]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_container]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT (' ') FOR [fi_contnum]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_atrisk]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_density]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT (NULL) FOR [fi_recdate]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_rtid]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_contunid]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ('') FOR [fi_origpostref]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_vcid]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_crid]
GO
ALTER TABLE [dbo].[dtfifo] ADD  DEFAULT ((0)) FOR [fi_tarewgt]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT (NULL) FOR [f2_date]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ((0)) FOR [f2_prid]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ((0)) FOR [f2_fiid]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ('') FOR [f2_postref]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ((0)) FOR [f2_oldquan]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ((0)) FOR [f2_newquan]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ((0)) FOR [f2_cost]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ('') FOR [f2_action]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ((0)) FOR [f2_group]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ((0)) FOR [f2_expense]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ((0)) FOR [f2_exten]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ((0)) FOR [f2_invcost]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT ('') FOR [f2_notes]
GO
ALTER TABLE [dbo].[dtfifo2] ADD  DEFAULT (NULL) FOR [f2_recdate]
GO
ALTER TABLE [dbo].[dtfifocust] ADD  DEFAULT ('') FOR [fc_table]
GO
ALTER TABLE [dbo].[dtfifocust] ADD  DEFAULT ((0)) FOR [fc_recid]
GO
ALTER TABLE [dbo].[dtfifocust] ADD  DEFAULT ('') FOR [fc_lotnum]
GO
ALTER TABLE [dbo].[dtfifocust] ADD  DEFAULT ('') FOR [fc_userlot]
GO
ALTER TABLE [dbo].[dtfifoesig] ADD  DEFAULT ((0)) FOR [fe_fiid]
GO
ALTER TABLE [dbo].[dtfifoesig] ADD  DEFAULT ('') FOR [fe_signature]
GO
ALTER TABLE [dbo].[dtfifoesig] ADD  DEFAULT (NULL) FOR [fe_date]
GO
ALTER TABLE [dbo].[dtfifoesig] ADD  DEFAULT ((0)) FOR [fe_time]
GO
ALTER TABLE [dbo].[dtfifoesig] ADD  DEFAULT ((0)) FOR [fe_usid]
GO
ALTER TABLE [dbo].[dtfifoesig] ADD  DEFAULT ('') FOR [fe_type]
GO
ALTER TABLE [dbo].[dtfifoesig] ADD  DEFAULT ((0)) FOR [fe_allonum]
GO
ALTER TABLE [dbo].[dtfreightship] ADD  DEFAULT ((1)) FOR [fs_active]
GO
ALTER TABLE [dbo].[dtfreightship] ADD  DEFAULT ((0)) FOR [fs_dnid]
GO
ALTER TABLE [dbo].[dtfreightship] ADD  DEFAULT ('') FOR [fs_label]
GO
ALTER TABLE [dbo].[dtfreightship] ADD  DEFAULT ((0)) FOR [fs_loadandcount]
GO
ALTER TABLE [dbo].[dtfreightship] ADD  DEFAULT ((0)) FOR [fs_ordnum]
GO
ALTER TABLE [dbo].[dtfreightship] ADD  DEFAULT ((0)) FOR [fs_piid]
GO
ALTER TABLE [dbo].[dtfreightship] ADD  DEFAULT ('Shipper') FOR [fs_role]
GO
ALTER TABLE [dbo].[dtfreightship] ADD  DEFAULT ('') FOR [fs_bookingnum]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ((1)) FOR [fl_active]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ('') FOR [fl_class]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ('') FOR [fl_description]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ((0)) FOR [fl_fsid]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ((0)) FOR [fl_handlingunits]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ((0)) FOR [fl_height]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ((0)) FOR [fl_length]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ('') FOR [fl_packtype]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ((0)) FOR [fl_pieces]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ((0)) FOR [fl_seq]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ((0)) FOR [fl_width]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ('IN') FOR [fl_units]
GO
ALTER TABLE [dbo].[dtfreightshipline] ADD  DEFAULT ((0)) FOR [fl_weight]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT (NULL) FOR [gl_date]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((0)) FOR [gl_group]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ('') FOR [gl_postref]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((0)) FOR [gl_debits]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((0)) FOR [gl_credits]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ('') FOR [gl_action]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((0)) FOR [gl_bankrec]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ('') FOR [gl_descrip]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((0)) FOR [gl_chid]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((1)) FOR [gl_usid]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT (NULL) FOR [gl_cleared]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((1)) FOR [gl_fcid]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((1)) FOR [gl_fcrate]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT (NULL) FOR [gl_recdate]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((0)) FOR [gl_fcdebits]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((0)) FOR [gl_fccredits]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT ((0)) FOR [gl_apprusid]
GO
ALTER TABLE [dbo].[dtgl] ADD  DEFAULT (NULL) FOR [gl_apprdate]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_jobnum]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_date]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_started]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_closed]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_prtwork]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ('') FOR [jo_notes]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ('a') FOR [jo_type]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_jcid]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_wipjob]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_waid]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_due]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((1)) FOR [jo_sched]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((5)) FOR [jo_prior]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ('') FOR [jo_descrip]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_synch]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ('') FOR [jo_remarks]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ('') FOR [jo_history]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_shid]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_userdate4]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_userdate5]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_trakid]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_trak2id]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ('Manual') FOR [jo_schedby]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_userdate1]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_planstart]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_planfinish]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_userdate2]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_userdate3]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ('P') FOR [jo_jobtype]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((1)) FOR [jo_reworklabor]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT (NULL) FOR [jo_prtpickdate]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ('') FOR [jo_prtpicktime]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_seqjob]
GO
ALTER TABLE [dbo].[dtjob] ADD  DEFAULT ((0)) FOR [jo_pjid]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_jobnum]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_seq]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_ceid]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_opid]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT (NULL) FOR [j2_start]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT (NULL) FOR [j2_due]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_pieces]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_hours]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ('') FOR [j2_notes]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_batch]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_done]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_ljid]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((1)) FOR [j2_priority]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_duetime]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_size]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_multiday]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_workers]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_leadtime]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_planhours]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_crid]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_woid]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((1)) FOR [j2_finish]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ('end') FOR [j2_leadtype]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_r2id]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((1)) FOR [j2_includeoptimize]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_unavailnextseq]
GO
ALTER TABLE [dbo].[dtjob2] ADD  DEFAULT ((0)) FOR [j2_unavailseqid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_jobnum]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT (NULL) FOR [j3_datein]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT (NULL) FOR [j3_dateout]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_timein]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_timeout]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_woid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_ceid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_cenrate]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_seq]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_opid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_quant]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_rate]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_ratefac]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_otfactr]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_hours]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT (NULL) FOR [j3_relieve]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT (NULL) FOR [j3_modd1]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT (NULL) FOR [j3_modd2]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_modt1]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_modt2]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_modhour]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_othours]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_modot]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_group]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT (NULL) FOR [j3_posted]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ('') FOR [j3_postref]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_chid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_otchid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_crid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ('Unknown') FOR [j3_source]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_burchid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_laid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_sfid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_ptid]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_calctime]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_splithours]
GO
ALTER TABLE [dbo].[dtjob3] ADD  DEFAULT ((0)) FOR [j3_burdenrate]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_jobnum]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_ljid]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT (NULL) FOR [j4_date]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_quant]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_crid]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_prid]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_stantot]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_unitcos]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_fiid]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT (NULL) FOR [j4_nextstab]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_stid]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_catchwgt]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_matcost]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_labcost]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_purcost]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_centcost]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_burcost]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_meter]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_finlab]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_finbur]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT (NULL) FOR [j4_recdate]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_sfid]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_fixmat]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_fixlab]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_fixbur]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_fixmbur]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_fixfrt]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_f2group]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_glfingrp]
GO
ALTER TABLE [dbo].[dtjob4] ADD  DEFAULT ((0)) FOR [j4_glrelgrp]
GO
ALTER TABLE [dbo].[dtjobsched] ADD  DEFAULT ((0)) FOR [js_j2id]
GO
ALTER TABLE [dbo].[dtjobsched] ADD  DEFAULT (NULL) FOR [js_due]
GO
ALTER TABLE [dbo].[dtjobsched] ADD  DEFAULT ((0)) FOR [js_duetime]
GO
ALTER TABLE [dbo].[dtjobsched] ADD  DEFAULT ((0)) FOR [js_duration]
GO
ALTER TABLE [dbo].[dtjobsched] ADD  DEFAULT ((0)) FOR [js_jobnum]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT (NULL) FOR [jr_date]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_group]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ('') FOR [jr_postref]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_debits]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_credits]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ('') FOR [jr_action]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_bankrec]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ('') FOR [jr_descrip]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_chid]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_usid]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((1)) FOR [jr_fcid]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((1)) FOR [jr_fcrate]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT (NULL) FOR [jr_recdate]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((1)) FOR [jr_active]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_fcdebits]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_fccredits]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT (NULL) FOR [jr_apprdate]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_apprusid]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ('') FOR [jr_type]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ('') FOR [jr_occurson]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ((0)) FOR [jr_occurences]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT (NULL) FOR [jr_reverses]
GO
ALTER TABLE [dbo].[dtjour] ADD  DEFAULT ('') FOR [jr_glpostref]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_jobnum]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_linenum]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_prid]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_quant]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_ordnum]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_orid]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ('') FOR [lj_descrip]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ('') FOR [lj_user1]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_reid]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ('') FOR [lj_feattree]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_joid]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_qcid]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_approved]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_failed]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_roid]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_nextstid]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT (NULL) FOR [lj_nextstab]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ('') FOR [lj_tally]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_planquant]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_ceid]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ((0)) FOR [lj_cmid]
GO
ALTER TABLE [dbo].[dtljob] ADD  DEFAULT ('') FOR [lj_cpcost]
GO
ALTER TABLE [dbo].[dtlock] ADD  DEFAULT ('') FOR [lk_table]
GO
ALTER TABLE [dbo].[dtlock] ADD  DEFAULT ((0)) FOR [lk_usid]
GO
ALTER TABLE [dbo].[dtlock] ADD  DEFAULT ((0)) FOR [lk_recid]
GO
ALTER TABLE [dbo].[dtlock] ADD  DEFAULT ('') FOR [lk_action]
GO
ALTER TABLE [dbo].[dtlock] ADD  DEFAULT ((0)) FOR [lk_critical]
GO
ALTER TABLE [dbo].[dtlock] ADD  DEFAULT (NULL) FOR [lk_date]
GO
ALTER TABLE [dbo].[dtlock] ADD  DEFAULT ('') FOR [lk_time]
GO
ALTER TABLE [dbo].[dtlock] ADD  DEFAULT ((0)) FOR [lk_token]
GO
ALTER TABLE [dbo].[dtlock] ADD  DEFAULT ((1)) FOR [lk_expire]
GO
ALTER TABLE [dbo].[dtmasterlot] ADD  DEFAULT ('') FOR [ml_lot]
GO
ALTER TABLE [dbo].[dtmasterlot] ADD  DEFAULT ((0)) FOR [ml_totwgt]
GO
ALTER TABLE [dbo].[dtmasterlot] ADD  DEFAULT ('Open') FOR [ml_status]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_pickbytime]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT (NULL) FOR [ms_pickbydate]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_priority]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_usid]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT (NULL) FOR [ms_loadstartdate]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT (NULL) FOR [ms_loadenddate]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_loadstarttime]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_loadendtime]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT (NULL) FOR [ms_unloadstartdate]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT (NULL) FOR [ms_unloadenddate]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_unloadstarttime]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_unloadendtime]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_quant]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_loadedquant]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_unloadedquant]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_loid]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_destloid]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_mrid]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_waid]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_vcid]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_ordnum]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_prid]
GO
ALTER TABLE [dbo].[dtmovesched] ADD  DEFAULT ((0)) FOR [ms_orid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_ordnum]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_linenum]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_chid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_cogsid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_prid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_quant]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_qship]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_price]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_exten]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ('') FOR [or_notes]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_taxable]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_stocked]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_control]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT (NULL) FOR [or_wanted]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT (NULL) FOR [or_promise]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT (NULL) FOR [or_dueship]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT (NULL) FOR [or_confirm]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT (NULL) FOR [or_expires]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_jobnum]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ('') FOR [or_user1]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_prunid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_prfact]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_unitwgt]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_taid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_unitcos]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_subtot]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_discoun]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ('') FOR [or_tally]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_lispric]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_stantot]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_purnum]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_loadcos]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ('') FOR [or_prictyp]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_phid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((1)) FOR [or_salunid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((1)) FOR [or_salfact]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT (NULL) FOR [or_release]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_toid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_special]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_tranrecv]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ('') FOR [or_feattree]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_override]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_origprice]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_dealpric]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_avgcost]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_cuid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_linedisc]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_origprod]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_sizeprod]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_quotedcost]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_catchwgt]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_blanket]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_blanketid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_inclfeat]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_featpric]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_pmid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_pmfact]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_p4id]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_noinv]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_ordquant]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_shipquant]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT (NULL) FOR [or_duedock]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_rtid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_dockmins]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_tarewgt]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ('') FOR [or_packages]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_cogsdelta]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_frtcost]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT (NULL) FOR [or_overridedate]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ('') FOR [or_overrideuser]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_priceordnum]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_planquant]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_qplan]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_totalorder]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_scid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_siid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_backquant]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_autoaddfreight]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_discountid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_noreserve]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_commable]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_promoamt]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_poallocatable]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_pickunit]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_linejob]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_repack]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_shid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_masterorid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_trid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_frid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_doid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_actualfrtcost]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_gcid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_vaid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_laborcogsid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_burdencogsid]
GO
ALTER TABLE [dbo].[dtord] ADD  DEFAULT ((0)) FOR [or_pricefactor]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_orid]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_feid]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_feid2]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_quant]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ('') FOR [o2_fename]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ('') FOR [o2_fename2]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ('') FOR [o2_seq]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_endpt]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_price]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_parent]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_prid]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ('') FOR [o2_comments]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_prid2]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_f2id]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_multiple]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ('') FOR [o2_notes]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_f2id2]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_nocost]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((1)) FOR [o2_usedeals]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((1)) FOR [o2_usepromos]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_comm]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_required]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ((0)) FOR [o2_basequant]
GO
ALTER TABLE [dbo].[dtord2] ADD  DEFAULT ('') FOR [o2_suffix]
GO
ALTER TABLE [dbo].[dtordpricealloc] ADD  DEFAULT ((0)) FOR [oa_orid]
GO
ALTER TABLE [dbo].[dtordpricealloc] ADD  DEFAULT ((0)) FOR [oa_price]
GO
ALTER TABLE [dbo].[dtordpricealloc] ADD  DEFAULT ((0)) FOR [oa_account]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_name]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_confirm]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_weight]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_totalcharge]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((1)) FOR [pa_active]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_charge]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_addthandle]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_cargoair]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_offeror]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_shipname]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_signame]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_sigtitle]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('LB') FOR [pa_unit]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_aescomp]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_length]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_width]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_height]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('IN') FOR [pa_dimunits]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_bookingnum]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_loadandcount]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_overpack]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('') FOR [pa_easypostid]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ((0)) FOR [pa_cod]
GO
ALTER TABLE [dbo].[dtpackage] ADD  DEFAULT ('Customer Supplied') FOR [pa_packtype]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_paid]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_orid]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_quant]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((1)) FOR [pl_active]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_piid]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_linenum]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_value]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ('') FOR [pl_harmonizedcode]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_weight]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ('LB') FOR [pl_unit]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_dnid]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ('') FOR [pl_label]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ('') FOR [pl_authorization]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_lotnum]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ((0)) FOR [pl_compprid]
GO
ALTER TABLE [dbo].[dtpackageline] ADD  DEFAULT ('') FOR [pl_compcodenum]
GO
ALTER TABLE [dbo].[dtpaybreak] ADD  DEFAULT ((0)) FOR [pb_breakin]
GO
ALTER TABLE [dbo].[dtpaybreak] ADD  DEFAULT ((0)) FOR [pb_breakout]
GO
ALTER TABLE [dbo].[dtpaybreak] ADD  DEFAULT ((0)) FOR [pb_ptid]
GO
ALTER TABLE [dbo].[dtpaybreak] ADD  DEFAULT (NULL) FOR [pb_datein]
GO
ALTER TABLE [dbo].[dtpaybreak] ADD  DEFAULT (NULL) FOR [pb_dateout]
GO
ALTER TABLE [dbo].[dtpaysched] ADD  DEFAULT ('') FOR [ps_table]
GO
ALTER TABLE [dbo].[dtpaysched] ADD  DEFAULT ((0)) FOR [ps_recid]
GO
ALTER TABLE [dbo].[dtpaysched] ADD  DEFAULT (NULL) FOR [ps_date]
GO
ALTER TABLE [dbo].[dtpaysched] ADD  DEFAULT ((0)) FOR [ps_totdue]
GO
ALTER TABLE [dbo].[dtpaysched] ADD  DEFAULT ((0)) FOR [ps_peid]
GO
ALTER TABLE [dbo].[dtpaysched] ADD  DEFAULT ((0)) FOR [ps_deposit]
GO
ALTER TABLE [dbo].[dtpaysched] ADD  DEFAULT (NULL) FOR [ps_antcash]
GO
ALTER TABLE [dbo].[dtpaysched] ADD  DEFAULT ((0)) FOR [ps_balance]
GO
ALTER TABLE [dbo].[dtpaysched] ADD  DEFAULT (NULL) FOR [ps_colldate]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_timein]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_timeout]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_woid]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_crid]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT (NULL) FOR [pt_datein]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT (NULL) FOR [pt_dateout]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_overtime]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_otfactr]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_otchid]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_rate]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_chid]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_waid]
GO
ALTER TABLE [dbo].[dtpaytime] ADD  DEFAULT ((0)) FOR [pt_burdenrate]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT (NULL) FOR [ph_date]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT ('') FOR [ph_name]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT (NULL) FOR [ph_complete]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT ((0)) FOR [ph_waid]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT ('') FOR [ph_filter]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT ((1)) FOR [ph_active]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT ('') FOR [ph_grouping]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT ('') FOR [ph_lotattributes]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT ('') FOR [ph_lotdate]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT ((0)) FOR [ph_cyclecount]
GO
ALTER TABLE [dbo].[dtphys] ADD  DEFAULT ('') FOR [ph_containergrpby]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_phid]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_prid]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_onhand]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_adjust]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_seq]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_location]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_userlot]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_cost]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_newloc]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_serial]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_allonum]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_allotype]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_orid]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_attrib1]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_attrib2]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_attrib3]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_basedon]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_newcost]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_syslot]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_complete]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_loid]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_newloid]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_qc]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT (NULL) FOR [p2_expires]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_masterlot]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_density]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_catchwgt]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_contunid]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_container]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_contnum]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_postref]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_origpostref]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT (NULL) FOR [p2_lotdate]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_notes]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_newattrib1]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_newattrib2]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ('') FOR [p2_newattrib3]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT (NULL) FOR [p2_newlotdate]
GO
ALTER TABLE [dbo].[dtphys2] ADD  DEFAULT ((0)) FOR [p2_tarewgt]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ((0)) FOR [pq_prid]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ((0)) FOR [pq_veid]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ('') FOR [pq_userlot]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ((1)) FOR [pq_active]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ((0)) FOR [pq_waid]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ((0)) FOR [pq_reid]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ('') FOR [pq_attrib1]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ('') FOR [pq_attrib2]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ('') FOR [pq_attrib3]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT ((0)) FOR [pq_p2id]
GO
ALTER TABLE [dbo].[dtprerecqc] ADD  DEFAULT (NULL) FOR [pq_lotdate]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT ('') FOR [rv_name]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT ('') FOR [rv_title]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT ('') FOR [rv_review]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT ((0)) FOR [rv_rating]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT ((0)) FOR [rv_prid]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT (NULL) FOR [rv_date]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT ((0)) FOR [rv_visible]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT ((0)) FOR [rv_csid]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT ((0)) FOR [rv_epid]
GO
ALTER TABLE [dbo].[dtprodreviews] ADD  DEFAULT ((0)) FOR [rv_cuid]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ('') FOR [pj_name]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ((0)) FOR [pj_projnum]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT (NULL) FOR [pj_created]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ((1)) FOR [pj_active]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ('') FOR [pj_notes]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ((0)) FOR [pj_budget]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ((0)) FOR [pj_wipinv]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ((0)) FOR [pj_finmat]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ((0)) FOR [pj_finlab]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ((0)) FOR [pj_finbur]
GO
ALTER TABLE [dbo].[dtproj] ADD  DEFAULT ((0)) FOR [pj_matexp]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_purnum]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_linenum]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_prid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ('') FOR [pu_vnddesc]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ('') FOR [pu_ourcode]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_ordman]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_recman]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_quant]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_price]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_stancos]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_exten]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_qship]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ('') FOR [pu_notes]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_stocked]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_jobnum]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT (NULL) FOR [pu_wanted]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT (NULL) FOR [pu_promise]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT (NULL) FOR [pu_duedock]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT (NULL) FOR [pu_confirm]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT (NULL) FOR [pu_expires]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT (NULL) FOR [pu_relieve]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_prfact]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_prunid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_unitwgt]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_chid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ('') FOR [pu_tally]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_ordnum]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_p2id]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ('') FOR [pu_vndcode]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ('') FOR [pu_user1]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_orid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_stanmat]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_discoun]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_taid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_taxable]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_tpid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_approved]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_failed]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_tranship]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_shipman]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_blanket]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_blanketid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ('') FOR [pu_hazard]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_hazflag]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_frtcost]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_noinv]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT (NULL) FOR [pu_release]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ('') FOR [pu_prictyp]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_purunid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_dockmins]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_biid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_adjustpuid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_backquant]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_totalorder]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_pjid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_1099]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_tyid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_unitcos]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_mfgveid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_matbur]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_vaid]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_invoiceprice]
GO
ALTER TABLE [dbo].[dtpur] ADD  DEFAULT ((0)) FOR [pu_pricefactor]
GO
ALTER TABLE [dbo].[dtpur2] ADD  DEFAULT ((0)) FOR [p2_fiid]
GO
ALTER TABLE [dbo].[dtpur2] ADD  DEFAULT ((0)) FOR [p2_puid]
GO
ALTER TABLE [dbo].[dtpur2] ADD  DEFAULT ((0)) FOR [p2_srcloid]
GO
ALTER TABLE [dbo].[dtpurlinkedso] ADD  DEFAULT ((0)) FOR [pl_orid]
GO
ALTER TABLE [dbo].[dtpurlinkedso] ADD  DEFAULT ((0)) FOR [pl_puid]
GO
ALTER TABLE [dbo].[dtpurlinkedso] ADD  DEFAULT ((0)) FOR [pl_quant]
GO
ALTER TABLE [dbo].[dtpurlinkedso] ADD  DEFAULT ((0)) FOR [pl_seq]
GO
ALTER TABLE [dbo].[dtpurlinkedso] ADD  DEFAULT ((0)) FOR [pl_ordnum]
GO
ALTER TABLE [dbo].[dtpurlinkedso] ADD  DEFAULT ((0)) FOR [pl_freightpo]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((0)) FOR [q4_q2id]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ('') FOR [q4_value]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ('') FOR [q4_table]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((0)) FOR [q4_recid]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ('') FOR [q4_notes]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((0)) FOR [q4_ordnum]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((1)) FOR [q4_pass]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((0)) FOR [q4_lineid]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((0)) FOR [q4_complete]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((0)) FOR [q4_group]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((0)) FOR [q4_mindet]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((0)) FOR [q4_stid]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ((0)) FOR [q4_usid]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT (NULL) FOR [q4_date]
GO
ALTER TABLE [dbo].[dtqc4] ADD  DEFAULT ('') FOR [q4_time]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ((0)) FOR [q5_usid]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT (NULL) FOR [q5_date]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ('') FOR [q5_table]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ((0)) FOR [q5_recid]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ('') FOR [q5_time]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ('Approved') FOR [q5_action]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ((0)) FOR [q5_ordnum]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ((0)) FOR [q5_lineid]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ((0)) FOR [q5_q4group]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ('') FOR [q5_notes]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ('') FOR [q5_signature]
GO
ALTER TABLE [dbo].[dtqc5] ADD  DEFAULT ((0)) FOR [q5_pass]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT ((0)) FOR [qf_senttoqc]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT (NULL) FOR [qf_date]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT ((0)) FOR [qf_revnum]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT ((0)) FOR [qf_prid]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT ((0)) FOR [qf_qcid]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT ('') FOR [qf_linetable]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT ((0)) FOR [qf_lineid]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT ((0)) FOR [qf_q6id]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT ((0)) FOR [qf_waid]
GO
ALTER TABLE [dbo].[dtqcfreq] ADD  DEFAULT ((0)) FOR [qf_p2id]
GO
ALTER TABLE [dbo].[dtqcfreqassgn] ADD  DEFAULT ((0)) FOR [qa_lotnum]
GO
ALTER TABLE [dbo].[dtqcfreqassgn] ADD  DEFAULT ((0)) FOR [qa_qfid]
GO
ALTER TABLE [dbo].[dtqcfreqassgn] ADD  DEFAULT ('') FOR [qa_userlot]
GO
ALTER TABLE [dbo].[dtqclots] ADD  DEFAULT ((0)) FOR [ql_q4group]
GO
ALTER TABLE [dbo].[dtqclots] ADD  DEFAULT ((0)) FOR [ql_fiid]
GO
ALTER TABLE [dbo].[dtqclots] ADD  DEFAULT ((0)) FOR [ql_approved]
GO
ALTER TABLE [dbo].[dtqclots] ADD  DEFAULT ((0)) FOR [ql_failed]
GO
ALTER TABLE [dbo].[dtqclots] ADD  DEFAULT ((0)) FOR [ql_ljid]
GO
ALTER TABLE [dbo].[dtqclots] ADD  DEFAULT ((0)) FOR [ql_origgroup]
GO
ALTER TABLE [dbo].[dtqclots] ADD  DEFAULT ((0)) FOR [ql_pqid]
GO
ALTER TABLE [dbo].[dtqclots] ADD  DEFAULT ((0)) FOR [ql_ungrouped]
GO
ALTER TABLE [dbo].[dtqcprerecpo] ADD  DEFAULT ((0)) FOR [qp_pqid]
GO
ALTER TABLE [dbo].[dtqcprerecpo] ADD  DEFAULT ((0)) FOR [qp_tpid]
GO
ALTER TABLE [dbo].[dtregisterrec] ADD  DEFAULT ('') FOR [rr_postref]
GO
ALTER TABLE [dbo].[dtregisterrec] ADD  DEFAULT ((0)) FOR [rr_c3id]
GO
ALTER TABLE [dbo].[dtregisterrec] ADD  DEFAULT ((0)) FOR [rr_rgid]
GO
ALTER TABLE [dbo].[dtregisterrec] ADD  DEFAULT ((0)) FOR [rr_endbal]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT (NULL) FOR [ru_startdate]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT ((0)) FOR [ru_starttime]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT (NULL) FOR [ru_enddate]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT ((0)) FOR [ru_endtime]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT ((0)) FOR [ru_usid]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT ('') FOR [ru_deviceid]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT ((0)) FOR [ru_loid]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT ((0)) FOR [ru_trid]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT ((0)) FOR [ru_ltid]
GO
ALTER TABLE [dbo].[dtroute] ADD  DEFAULT ((0)) FOR [ru_chid]
GO
ALTER TABLE [dbo].[dtrss] ADD  DEFAULT ('') FOR [rs_descrip]
GO
ALTER TABLE [dbo].[dtrss] ADD  DEFAULT ('') FOR [rs_link]
GO
ALTER TABLE [dbo].[dtrss] ADD  DEFAULT (NULL) FOR [rs_date]
GO
ALTER TABLE [dbo].[dtrss] ADD  DEFAULT ((0)) FOR [rs_coid]
GO
ALTER TABLE [dbo].[dtstaging] ADD  DEFAULT ((0)) FOR [st_figroup]
GO
ALTER TABLE [dbo].[dtstaging] ADD  DEFAULT ((0)) FOR [st_jobnum]
GO
ALTER TABLE [dbo].[dtstaging] ADD  DEFAULT ((0)) FOR [st_f2group]
GO
ALTER TABLE [dbo].[dtstaging] ADD  DEFAULT ((0)) FOR [st_ordnum]
GO
ALTER TABLE [dbo].[dtstaging] ADD  DEFAULT ((0)) FOR [st_stagcnt]
GO
ALTER TABLE [dbo].[dtstaging] ADD  DEFAULT ((0)) FOR [st_boid]
GO
ALTER TABLE [dbo].[dttestresult] ADD  DEFAULT ((0)) FOR [tr_build]
GO
ALTER TABLE [dbo].[dttestresult] ADD  DEFAULT ((0)) FOR [tr_passed]
GO
ALTER TABLE [dbo].[dttestresult] ADD  DEFAULT ((0)) FOR [tr_failed]
GO
ALTER TABLE [dbo].[dttestresult] ADD  DEFAULT ((0)) FOR [tr_teid]
GO
ALTER TABLE [dbo].[dttestresult] ADD  DEFAULT ((0)) FOR [tr_usid]
GO
ALTER TABLE [dbo].[dttestresult] ADD  DEFAULT ('') FOR [tr_log]
GO
ALTER TABLE [dbo].[dttestresult] ADD  DEFAULT ((0)) FOR [tr_verifiedby]
GO
ALTER TABLE [dbo].[dttestresult] ADD  DEFAULT ('') FOR [tr_validations]
GO
ALTER TABLE [dbo].[dttestresult] ADD  DEFAULT ((0)) FOR [tr_seq]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_ticknum]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_primuser]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_usid]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT (NULL) FOR [ti_cdate]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_ctime]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT (NULL) FOR [ti_pprovdate]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_pprovtime]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT (NULL) FOR [ti_promdate]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT (NULL) FOR [ti_exdate]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT (NULL) FOR [ti_resdate]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT (NULL) FOR [ti_lastdate]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_lasttime]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_t1id]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_t2id]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_t3id]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_t4id]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_t5id]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ('') FOR [ti_summary]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ('') FOR [ti_detail]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_trakid]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_trak2id]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ('') FOR [ti_tickettype]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_assignuser]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ('') FOR [ti_resolution]
GO
ALTER TABLE [dbo].[dttick] ADD  DEFAULT ((0)) FOR [ti_tcid]
GO
ALTER TABLE [dbo].[dttickcont] ADD  DEFAULT ((0)) FOR [tt_tiid]
GO
ALTER TABLE [dbo].[dttickcont] ADD  DEFAULT ((0)) FOR [tt_coid]
GO
ALTER TABLE [dbo].[dttickcont] ADD  DEFAULT ('') FOR [tt_memo]
GO
ALTER TABLE [dbo].[dttickcont] ADD  DEFAULT ((0)) FOR [tt_cpid]
GO
ALTER TABLE [dbo].[dtticknote] ADD  DEFAULT ((0)) FOR [tn_tiid]
GO
ALTER TABLE [dbo].[dtticknote] ADD  DEFAULT (NULL) FOR [tn_date]
GO
ALTER TABLE [dbo].[dtticknote] ADD  DEFAULT ((0)) FOR [tn_time]
GO
ALTER TABLE [dbo].[dtticknote] ADD  DEFAULT ((0)) FOR [tn_usid]
GO
ALTER TABLE [dbo].[dtticknote] ADD  DEFAULT ('') FOR [tn_note]
GO
ALTER TABLE [dbo].[dtticknote] ADD  DEFAULT ((0)) FOR [tn_teid]
GO
ALTER TABLE [dbo].[dtticknote] ADD  DEFAULT ((0)) FOR [tn_coid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_ordnum]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_ordtype]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_quoted]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_ordered]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_orddate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_biid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_shid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_smid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_brid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_s1id]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_s2id]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_grid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_billpo]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_shippo]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_prtpack]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_shipped]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_trid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_teid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_credhld]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_invdate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_totdue]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_balance]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_paydate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_notes]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_confirm]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_waid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_header]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_descrip]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_prognum]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_user1]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_release]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_linkto]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_frid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_expires]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_flush]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_trakid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_trak2id]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_wanted]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_dueship]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_archid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_discoun]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_remarks]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_history]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_usid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_trid2]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_prepay]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_s3id]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_statax]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_loctax]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((1)) FOR [to_sgid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((5)) FOR [to_prior]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_s4id]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_s5id]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_deltime]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_promise]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_condate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_saved]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('c') FOR [to_status]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_savetime]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((1)) FOR [to_minquan]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_tranwaid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_tranrecv]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((1)) FOR [to_fcid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((1)) FOR [to_fcrate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_totwgt]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_pjid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_saletax]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_cashsale]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_overcred]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_tendered]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_paysched]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_distance]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_auid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_signature]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_recdate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_dgid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_psid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_crosswaid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_ccauth]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_authorize]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_authc3id]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((1)) FOR [to_fcrate2]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_cpid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_duedock]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_intransit]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_facilitypricing]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_pickuptime]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_antcash]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_credexp]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_cclast4]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_doid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_trandoid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_tottare]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_deldate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_shipfromid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_colldate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_said]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_stagcnt]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_frominvjobnum]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_prtinv]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_invpost]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_coid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('Days') FOR [to_recurtype]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_recurinterval]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_cardtoken]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_prtpick]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_seasonal]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_easypostrateid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ('') FOR [to_ccinvnum]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_masterordnum]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_rgid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_ccauthdate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_ttid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT (NULL) FOR [to_sodate]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_ruid]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_groupnum]
GO
ALTER TABLE [dbo].[dttord] ADD  DEFAULT ((0)) FOR [to_lastusid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_purnum]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_ordtype]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_date]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_veid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_vendinv]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_teid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_totdue]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_balance]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_paydate]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_invrecv]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_topay]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_trid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_recevd]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_prtpo]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_seid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_usid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_notes]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_waid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_potype]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_p1id]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_p2id]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_frid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_ref1]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_ref2]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_apchid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_remarks]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_history]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_trid2]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_deltime]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_wanted]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_promise]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_duedock]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_expires]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_condate]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_discoun]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_taid1]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_taid2]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((1)) FOR [tp_fcid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((1)) FOR [tp_fcrate]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_autoinv]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_totwgt]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_prepay]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_paysched]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_trakid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_trak2id]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_dropship]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_tranship]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_tranwaid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_posuspchid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_coid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_release]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((1)) FOR [tp_minquan]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('Manual') FOR [tp_source]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_invvend]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_approvedate]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_approvetime]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_approveusid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((1)) FOR [tp_fcrate2]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_doid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_inventered]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_1099]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_linkto]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_tyid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_totfrtcost]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_facilitypricing]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT (NULL) FOR [tp_possdate]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_reqtime]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_pgid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ('') FOR [tp_pricingorddate]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_psid]
GO
ALTER TABLE [dbo].[dttpur] ADD  DEFAULT ((0)) FOR [tp_brid]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ((0)) FOR [t5_usid]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ('') FOR [t5_time]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT (NULL) FOR [t5_date]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ('') FOR [t5_action]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ('') FOR [t5_table]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ((0)) FOR [t5_recid]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ((0)) FOR [t5_t2id]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ('') FOR [t5_comment]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ((0)) FOR [t5_t2id_return]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ('') FOR [t5_seqname]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ((0)) FOR [t5_usid2]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT (NULL) FOR [t5_planned]
GO
ALTER TABLE [dbo].[dttrak5] ADD  DEFAULT ('') FOR [t5_notes]
GO
ALTER TABLE [dbo].[dttrigdel] ADD  DEFAULT ((0)) FOR [td_tgid]
GO
ALTER TABLE [dbo].[dttrigdel] ADD  DEFAULT ((0)) FOR [td_recid]
GO
ALTER TABLE [dbo].[dttrigdel] ADD  DEFAULT ('') FOR [td_table]
GO
ALTER TABLE [dbo].[dttrigdel] ADD  DEFAULT (NULL) FOR [td_delivery]
GO
ALTER TABLE [dbo].[dttrigqueue] ADD  DEFAULT ((0)) FOR [tq_tgid]
GO
ALTER TABLE [dbo].[dttrigqueue] ADD  DEFAULT ((0)) FOR [tq_recid]
GO
ALTER TABLE [dbo].[dtusersecquest] ADD  DEFAULT ((0)) FOR [uq_sqid]
GO
ALTER TABLE [dbo].[dtusersecquest] ADD  DEFAULT ((0)) FOR [uq_usid]
GO
ALTER TABLE [dbo].[dtusersecquest] ADD  DEFAULT ('') FOR [uq_secanswer]
GO
ALTER TABLE [dbo].[dtworkshift] ADD  DEFAULT (NULL) FOR [ws_date]
GO
ALTER TABLE [dbo].[dtworkshift] ADD  DEFAULT ((0)) FOR [ws_sfid]
GO
ALTER TABLE [dbo].[dtworkshift] ADD  DEFAULT ((0)) FOR [ws_woid]
GO
ALTER TABLE [dbo].[dtworkshift] ADD  DEFAULT ((0)) FOR [ws_j2id]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_name]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_title]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((0)) FOR [br_b3id]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((1)) FOR [br_refresh]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('System') FOR [br_userref]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_actfld]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_layout]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_editfld]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_edittbl]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((0)) FOR [br_parentref]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('System') FOR [br_userpref]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((0)) FOR [br_gridid]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('System') FOR [br_gridfor]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_drillpage]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_drillval]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((0)) FOR [br_isiphone]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((0)) FOR [br_c2id]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT (' ') FOR [br_iphonecelltype]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_b3name]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('All') FOR [br_device]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((0)) FOR [br_pincols]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((0)) FOR [br_quid]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((0)) FOR [br_secrequired]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_copiedfrom]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_script]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ((0)) FOR [br_fiid]
GO
ALTER TABLE [dbo].[dxbrow] ADD  DEFAULT ('') FOR [br_internal]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((0)) FOR [b2_brid]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ('') FOR [b2_field]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((0)) FOR [b2_width]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ('') FOR [b2_title]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ('') FOR [b2_mask]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ('') FOR [b2_format]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((0)) FOR [b2_sum]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((0)) FOR [b2_sorter]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((0)) FOR [b2_sortdsc]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((0)) FOR [b2_user]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ('') FOR [b2_userexpr]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ('Follow default') FOR [b2_wordwrap]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ('') FOR [b2_drillpage]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ('') FOR [b2_drillval]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((1)) FOR [b2_preview]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((0)) FOR [b2_time]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT (' ') FOR [b2_iphonetype]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((0)) FOR [b2_c2id]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT (' ') FOR [b2_iphoneformat]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ('') FOR [b2_iphonefontstyle]
GO
ALTER TABLE [dbo].[dxbrow2] ADD  DEFAULT ((1)) FOR [b2_mobilecaption]
GO
ALTER TABLE [dbo].[dxbrow3] ADD  DEFAULT ('') FOR [b3_name]
GO
ALTER TABLE [dbo].[dxbrow3] ADD  DEFAULT ('') FOR [b3_code]
GO
ALTER TABLE [dbo].[dxbrow3] ADD  DEFAULT ('') FOR [b3_usercod]
GO
ALTER TABLE [dbo].[dxbrow3] ADD  DEFAULT ((0)) FOR [b3_user]
GO
ALTER TABLE [dbo].[dxbrowreport] ADD  DEFAULT ((0)) FOR [bt_reid]
GO
ALTER TABLE [dbo].[dxbrowreport] ADD  DEFAULT ('') FOR [bt_name]
GO
ALTER TABLE [dbo].[dxbrowreport] ADD  DEFAULT ((0)) FOR [bt_default]
GO
ALTER TABLE [dbo].[dxbrowreport] ADD  DEFAULT ((0)) FOR [bt_brid]
GO
ALTER TABLE [dbo].[dxbrowreport] ADD  DEFAULT ('') FOR [bt_type]
GO
ALTER TABLE [dbo].[dxbrowreport] ADD  DEFAULT ('') FOR [bt_text]
GO
ALTER TABLE [dbo].[dxbrowsec] ADD  DEFAULT ((0)) FOR [bs_access]
GO
ALTER TABLE [dbo].[dxbrowsec] ADD  DEFAULT ('') FOR [bs_brname]
GO
ALTER TABLE [dbo].[dxbrowsec] ADD  DEFAULT ((0)) FOR [bs_usid]
GO
ALTER TABLE [dbo].[dxbrowsec] ADD  DEFAULT ((0)) FOR [bs_ugid]
GO
ALTER TABLE [dbo].[dxbutton] ADD  DEFAULT ((0)) FOR [bu_name]
GO
ALTER TABLE [dbo].[dxbutton] ADD  DEFAULT ('') FOR [bu_code]
GO
ALTER TABLE [dbo].[dxbutton2] ADD  DEFAULT ((0)) FOR [b2_groupid]
GO
ALTER TABLE [dbo].[dxbutton2] ADD  DEFAULT ((0)) FOR [b2_buid]
GO
ALTER TABLE [dbo].[dxbutton2] ADD  DEFAULT ((0)) FOR [b2_position]
GO
ALTER TABLE [dbo].[dxbutton3] ADD  DEFAULT ((0)) FOR [b3_brid]
GO
ALTER TABLE [dbo].[dxbutton3] ADD  DEFAULT ((0)) FOR [b3_grouppos]
GO
ALTER TABLE [dbo].[dxbutton3] ADD  DEFAULT ((0)) FOR [b3_b2groupid]
GO
ALTER TABLE [dbo].[dxcmserrors] ADD  DEFAULT ((0)) FOR [ce_csid]
GO
ALTER TABLE [dbo].[dxcmserrors] ADD  DEFAULT (NULL) FOR [ce_date]
GO
ALTER TABLE [dbo].[dxcmserrors] ADD  DEFAULT ('') FOR [ce_except]
GO
ALTER TABLE [dbo].[dxcmserrors] ADD  DEFAULT ('') FOR [ce_source]
GO
ALTER TABLE [dbo].[dxcmserrors] ADD  DEFAULT ('') FOR [ce_stack]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_name]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_desc]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ((1)) FOR [cf_active]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_email]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_emailsubj]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_emailptxt]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_type]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_ftpuser]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_ftppass]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_ftpfile]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_ftplocation]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ((0)) FOR [cf_ftpappend]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_emailfrom]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ('') FOR [cf_emailfrompass]
GO
ALTER TABLE [dbo].[dxcmsforms] ADD  DEFAULT ((0)) FOR [cf_csid]
GO
ALTER TABLE [dbo].[dxcmslog] ADD  DEFAULT ((0)) FOR [cl_csid]
GO
ALTER TABLE [dbo].[dxcmslog] ADD  DEFAULT ('') FOR [cl_ip]
GO
ALTER TABLE [dbo].[dxcmslog] ADD  DEFAULT ((0)) FOR [cl_uaid]
GO
ALTER TABLE [dbo].[dxcmslog] ADD  DEFAULT ('') FOR [cl_device]
GO
ALTER TABLE [dbo].[dxcmslog] ADD  DEFAULT ('') FOR [cl_browser]
GO
ALTER TABLE [dbo].[dxcmslog] ADD  DEFAULT (NULL) FOR [cl_date]
GO
ALTER TABLE [dbo].[dxcmsoption] ADD  DEFAULT ((0)) FOR [co_csid]
GO
ALTER TABLE [dbo].[dxcmsoption] ADD  DEFAULT (' ') FOR [co_key]
GO
ALTER TABLE [dbo].[dxcmsoption] ADD  DEFAULT (' ') FOR [co_val]
GO
ALTER TABLE [dbo].[dxcmsoption] ADD  DEFAULT (' ') FOR [co_desc]
GO
ALTER TABLE [dbo].[dxcmsoption] ADD  DEFAULT ((1)) FOR [co_active]
GO
ALTER TABLE [dbo].[dxcmsoption] ADD  DEFAULT ((0)) FOR [co_restrict]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ((1)) FOR [cp_active]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ('') FOR [cp_markuptop]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ('') FOR [cp_title]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ((0)) FOR [cp_caid]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ('') FOR [cp_keywords]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ('') FOR [cp_desc]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ((0)) FOR [cp_default]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT (NULL) FOR [cp_date]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ('') FOR [cp_oldurl]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ((0)) FOR [cp_hidden]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT (NULL) FOR [cp_modified]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ('') FOR [cp_markupbottom]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ((0)) FOR [cp_partial]
GO
ALTER TABLE [dbo].[dxcmspages] ADD  DEFAULT ((0)) FOR [cp_csid]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ((1)) FOR [cp_active]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ((0)) FOR [cp_caid]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ((0)) FOR [cp_c2id]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ((0)) FOR [cp_prid]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ((0)) FOR [cp_shopping]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ((0)) FOR [cp_csid]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ((0)) FOR [cp_onhandquant]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ((0)) FOR [cp_epid]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ((0)) FOR [cp_seq]
GO
ALTER TABLE [dbo].[dxcmsprod] ADD  DEFAULT ('Use On Hand') FOR [cp_available]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((1)) FOR [cs_active]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_name]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_website]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_server]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_database]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_username]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_password]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_sync]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('Daily') FOR [cs_syncperiod]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('Sunday') FOR [cs_syncday]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_synctime]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT (NULL) FOR [cs_lastsyncdate]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_lastsynctime]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_sitemap]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_sitemappath]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_ipaddress]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_port]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_gcontentapi]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_allowregister]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_cartwologin]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_gmerchantid]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_gcredentials]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('None') FOR [cs_defaultdate]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('Not Approved') FOR [cs_userapproval]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_promolist]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((1)) FOR [cs_secquestions]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_productimages]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('Internet Sale') FOR [cs_ordertype]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_dcid]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((5)) FOR [cs_sessionexp]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_regbiid]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_regshid]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_minord]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_s1id]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_s2id]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_s3id]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_s4id]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_s5id]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_trid]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_smid]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((1)) FOR [cs_allowsaturday]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((1)) FOR [cs_allowsunday]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_syncdocs]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_temppassemail]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((60)) FOR [cs_mrpmins]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_easypost]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_logapicalls]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_numberpass]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_symbolpass]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_mrpprefilter]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('') FOR [cs_cartreminderemail]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((1)) FOR [cs_usemrp]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((0)) FOR [cs_createcontact]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((10)) FOR [cs_reminderemailmin]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ('eCommerce Site') FOR [cs_salesearchdflt]
GO
ALTER TABLE [dbo].[dxcmssite] ADD  DEFAULT ((500)) FOR [cs_maxcartvalue]
GO
ALTER TABLE [dbo].[dxcmswidgets] ADD  DEFAULT ((1)) FOR [cw_active]
GO
ALTER TABLE [dbo].[dxcmswidgets] ADD  DEFAULT ('') FOR [cw_markup]
GO
ALTER TABLE [dbo].[dxcmswidgets] ADD  DEFAULT ('') FOR [cw_title]
GO
ALTER TABLE [dbo].[dxcmswidgets] ADD  DEFAULT ('') FOR [cw_desc]
GO
ALTER TABLE [dbo].[dxcmswidgets] ADD  DEFAULT ('') FOR [cw_css]
GO
ALTER TABLE [dbo].[dxcmswidgets] ADD  DEFAULT ('') FOR [cw_js]
GO
ALTER TABLE [dbo].[dxcmswidgets] ADD  DEFAULT ((0)) FOR [cw_csid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_name]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_street]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_city]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_state]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_zip]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_remit]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_remit2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_remit3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_remit4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_remit5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_phone]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_fax]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((1)) FOR [df_credlim]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_credmax]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_teid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_purterm]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_fmargin]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User1') FOR [df_pruser1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User2') FOR [df_pruser2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User3') FOR [df_pruser3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User4') FOR [df_pruser4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_invcost]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_deposit]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_payment]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_ar]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_ap]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_purdis]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_saledis]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User1') FOR [df_souser1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User2') FOR [df_souser2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_invadj]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_wipinv]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_wippur]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_wiplab]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_wipmach]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT (NULL) FOR [df_closed]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT (NULL) FOR [df_supclos]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_stocked]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_control]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_payroll]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_adjmax]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_adjacct]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_neginv]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_matexp]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_pricdec]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_quandec]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_pastday]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_paytype]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_payfor]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT (NULL) FOR [df_acctend]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_saledec]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_puradj]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_cashsal]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_headjob]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_frtprod]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((1)) FOR [df_wipjob]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_syncjob]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_purtype]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_serprod]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_backjob]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_burden]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_pricord]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_crewop]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_crewcen]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_serterm]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_porem]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_sorem]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_taxid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_crewpro]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search1') FOR [df_co1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search2') FOR [df_co2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search3') FOR [df_co3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search4') FOR [df_co4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search5') FOR [df_co5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_finmat]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_finlab]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_finbur]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_maxso1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_maxso2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_maxso3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_maxpo1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_maxpo2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_maxpo3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_defbill]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_shipin]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_prepay]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User3') FOR [df_souser3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_xfer]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Text1') FOR [df_pouser1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Text2') FOR [df_pouser2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search1') FOR [df_pouser3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search2') FOR [df_pouser4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_defgain]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Specified') FOR [df_batyld]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((1)) FOR [df_soback]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_poback]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_matbur]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User4') FOR [df_souser4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User5') FOR [df_souser5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((5)) FOR [df_ordlen]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('s') FOR [df_sotype]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('p') FOR [df_potype]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Indented Explosion') FOR [df_bomtype]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((1)) FOR [df_port]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_freqa]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_freqb]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_freqc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_freqd]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_freqweek]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((1)) FOR [df_phasejob]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_invgain]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_daysales]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_payprod]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('to_shipped') FOR [df_taxdate]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('jobfor') FOR [df_socal1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('dispnum') FOR [df_socal2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('units') FOR [df_socal3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('none') FOR [df_socal4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('none') FOR [df_socal5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('jobfor') FOR [df_jobcal1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('dispnum') FOR [df_jobcal2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('units') FOR [df_jobcal3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('none') FOR [df_jobcal4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('none') FOR [df_jobcal5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search1') FOR [df_pruser5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search2') FOR [df_pruser6]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Text1') FOR [df_co6]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Text2') FOR [df_co7]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Text3') FOR [df_co8]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Text4') FOR [df_co9]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Text5') FOR [df_co10]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_schedunit]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_scheduni2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((1)) FOR [df_purlev]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_tranvar]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_loadcalc1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_loadcalc2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_loadcalc3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_burcalc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_matburcalc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_kitpart]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_excelfooter]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_currgain]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_autoinv]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_schedcaid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_schedcai2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Printer') FOR [df_invdest]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Printer') FOR [df_statedest]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_reggain]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User summary 1') FOR [df_sorep1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User summary 2') FOR [df_sorep2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User summary 3') FOR [df_sorep3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User summary 4') FOR [df_sorep4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User summary 5') FOR [df_sorep5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User detail 1') FOR [df_sorep6]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User detail 2') FOR [df_sorep7]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User detail 3') FOR [df_sorep8]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User detail 4') FOR [df_sorep9]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User detail 5') FOR [df_sorep10]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_taxdisc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_exclcash]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_payterm]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_jobsort1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_jobsort2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_jobsort3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_sosort1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_sosort2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_sosort3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search3') FOR [df_pruser7]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search4') FOR [df_pruser8]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Search5') FOR [df_pruser9]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_sowantcalc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_sopromcalc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_soduecalc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_soconfcalc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_sorelcalc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_soexpcalc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_drawport]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_drawcmd]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Wanted') FOR [df_sodate1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Promised') FOR [df_sodate2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Due to ship') FOR [df_sodate3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Confirm') FOR [df_sodate4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Release') FOR [df_sodate5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Summary 1') FOR [df_porep1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Summary 2') FOR [df_porep2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Summary 3') FOR [df_porep3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Summary 4') FOR [df_porep4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Summary 5') FOR [df_porep5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Detail 1') FOR [df_porep6]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Detail 2') FOR [df_porep7]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Detail 3') FOR [df_porep8]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Detail 4') FOR [df_porep9]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User Detail 5') FOR [df_porep10]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_prepaypo]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_logoname]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('m') FOR [df_xfertype]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Arial') FOR [df_fontname]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((9)) FOR [df_fontsize]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_wordwrap]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_sermin]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Standard') FOR [df_finrep1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User1') FOR [df_finrep2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User2') FOR [df_finrep3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User3') FOR [df_finrep4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('User4') FOR [df_finrep5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Period') FOR [df_finrep6]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_scanport]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Wanted') FOR [df_podate1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Promised') FOR [df_podate2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Due to dock') FOR [df_podate3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Confirm') FOR [df_podate4]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Order expires') FOR [df_podate5]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Quantity') FOR [df_joballo]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Attribute 1') FOR [df_attrib1]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Attribute 2') FOR [df_attrib2]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Attribute 3') FOR [df_attrib3]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_joblot]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Quantity') FOR [df_prodallo]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_pospaid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_joballovar]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('none') FOR [df_jobchk]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_docdir]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_frtdisc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_calsizeso]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_calsizejob]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_elimchid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_poprtform]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_msdsid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_cofaid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_joblabid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_itemlabid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_polabid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_solabid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_lotlabid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_credship]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Default') FOR [df_qcloc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((1)) FOR [df_credopenso]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_negadj]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_reljob]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((16774376)) FOR [df_gridrowcolor]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_rcountry]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('Job') FOR [df_issuetype]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('to_orddate') FOR [df_sopricdate]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_ccid]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_facprompt]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ((0)) FOR [df_bomdec]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_ssocert]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_jobdate1calc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_jobdate2calc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_jobdate3calc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_jobdate4calc]
GO
ALTER TABLE [dbo].[dxdflt] ADD  DEFAULT ('') FOR [df_jobdate5calc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_poconfcalc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_poduecalc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_poexpcalc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_popromcalc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_powantcalc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_soprtform]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_jobprtform]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_jobinclstan]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_xfermarkchid]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Manual') FOR [df_sergen]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_serexpr]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_jobqc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_jobfg]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Email signature, edit from System -> Options -> General') FOR [df_signature]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_skipsat]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_skipsun]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Period 2') FOR [df_finrep7]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Period 3') FOR [df_finrep8]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Period 4') FOR [df_finrep9]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Period 5') FOR [df_finrep10]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_websvrloc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_websvrport]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_gridlines]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_webfolder]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_payacctchid]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_crossrev]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_physlots]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_serdays]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Due') FOR [df_jobdate1]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Production') FOR [df_jobdate2]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Started') FOR [df_jobdate3]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Job date 4') FOR [df_jobdate4]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Job date 5') FOR [df_jobdate5]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Use job cost allocation') FOR [df_costbyprod]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_posuspchid]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_maxdocsize]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_intprod]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Position 1') FOR [df_finrep11]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Position 2') FOR [df_finrep12]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Position 3') FOR [df_finrep13]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Position 4') FOR [df_finrep14]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Position 5') FOR [df_finrep15]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_maxsodocsize]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_salefeat]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_porecvlimit]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_passminlen]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_passmaxage]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_passminage]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_passhistory]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_passcomplex]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((4)) FOR [df_fcdec]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Line') FOR [df_picksortso]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Line') FOR [df_picksortjob]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Line') FOR [df_picksortprestage]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Line') FOR [df_picksortstage]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_routcal1]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_routcal2]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_routcal3]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_routcal4]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_routcal5]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_routsort1]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_routsort2]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_routsort3]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_retainloc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_issueoverlimit]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_issuelimitenforce]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_porecvlimitenforce]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_lotexpr]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((50)) FOR [df_calwidth]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Contact report 1') FOR [df_conrep1]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Contact report 2') FOR [df_conrep2]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Contact report 3') FOR [df_conrep3]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_dispport]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('LEFT(pr_codenum, 20) + "$" + ALLT(TRANSFORM(or_price, go.pricmask))') FOR [df_disptext]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('c3_name + " " + STR(payamt, 12, 2) + " " + ALLTRIM(ca_validnum)') FOR [df_postext]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_companyrss]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_jobrout]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('localhost') FOR [df_tgmailhost]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((25)) FOR [df_tgmailport]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_tgdefcred]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_tgcrname]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_tgcrpass]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_tgcrdomain]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_tgsendaddy]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_domain]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_porelcalc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((365)) FOR [df_lastlogin]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Logic Controls') FOR [df_poscmdset]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('pr_codenum + STR(bocount, 17, m.df_quandec)') FOR [df_regbomtext]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_poqc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_jobtrak]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Manual') FOR [df_jobschedby]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_pftest]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((120)) FOR [df_iphonetimeout]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_wipbur]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_paybur]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_rempass]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_posbiid]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_bomcalc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_helpuser]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_helppass]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_currcheck]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_showzerolines]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_finzerodflt]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_mrpdec]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_bofinish]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_bostart]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_jobfg2]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('None') FOR [df_sojob]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_sodockcalc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('User lot') FOR [df_wmschoosergroup]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_rellabor]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_picksortsouser]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_wipburmaint]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_wippurmaint]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_wipinvmaint]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_wiplabmaint]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('None') FOR [df_saleonhand]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_creddays]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_lotexpcalc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_reworklabor]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('whitelist') FOR [df_authentication]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_dsdpricevar]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_prevlotx]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Not in QC and Not At-Risk') FOR [df_wmschooserqcstatus]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Inventory') FOR [df_wmschooseritemtype]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_linkemailctid]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((30)) FOR [df_linkemailmins]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_uslinkemail]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_cplinkemail]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('shortdispnum') FOR [df_dockcal1]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('billcomp') FOR [df_dockcal2]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('shipcomp') FOR [df_dockcal3]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('planhrs') FOR [df_dockcal4]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('tranname') FOR [df_dockcal5]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_docksort1]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_docksort2]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_docksort3]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_zerocatchweight]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_printnone]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Full') FOR [df_shipquan]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('TRANS(to_ordnum,go.Ordmask) + "-" + TRANS(INCREMENT(ALLT(STR(to_ordnum,df_ordlen + 6,0)),3),"000")') FOR [df_packexp]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_valutecclientid]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_valutecterminalid]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Price') FOR [df_dsdpricetype]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('with') FOR [df_shortship]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_formqcexp]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Standard') FOR [df_shipview]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((30000)) FOR [df_wmsfieldlim]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_sumissuedlots]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_dsdarchrec]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_useentirelot]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Lot Required') FOR [df_wmssugglot]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_fedacc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_fedpass]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_fedauth]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_fedshipacc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_fedmeternum]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_remmlot]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_fedtest]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_fedalwaysgenlabel]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((5)) FOR [df_fedpollmins]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_cogsvariance]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('All') FOR [df_showchooser]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((5)) FOR [df_purlen]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('None') FOR [df_fedgenshiplabel]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_explodephantoms]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('s') FOR [df_wmsfilterto]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_dsdvartype]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_readweight]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_wmsautoselectloc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Start Job') FOR [df_workeract2]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_skipfield]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('descrip') FOR [df_monthjob1]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('partnum') FOR [df_monthjob2]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('lj_quant') FOR [df_monthjob3]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('pr_codenum') FOR [df_tempcapex]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_resmlot]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Standard') FOR [df_autofinlayout]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_somrppref]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_jobmrpprefilter]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_jobmrppref]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_somrpprefilter]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_commaccr]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_commexp]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Expiration date') FOR [df_wmschoosersort]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_salstag]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_sobocalcs]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('End date') FOR [df_acctbal]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_defissquan]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_purlotexp]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('None') FOR [df_invso]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_exstag]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_stagscan]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_bommrppref]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_bommrpprefilter]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_autofinoffline]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_stagweigh]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('None') FOR [df_autoaltwgtfield]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_nothingissuedprompt]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((100)) FOR [df_autofingridsize]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Both') FOR [df_somrpshowall]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Both') FOR [df_jobmrpshowall]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Part') FOR [df_wmssuggby]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_emvexpr]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Not Shipped') FOR [df_dsdsynstat]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_deissueprintlabel]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Lot Label') FOR [df_aflbl]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_addfedexfreight]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('p') FOR [df_defmrpordtype]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_masterlotwgt]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_syncorderdates]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_jobstage]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((150)) FOR [df_docresolution]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_remitid]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_depexpensechid]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Part') FOR [df_inputprodclear]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Relieve All') FOR [df_jobchktype]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Ship-To Company') FOR [df_soprtsub]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_allowjobcaldragpriority]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_allowsocaldragpriority]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('a') FOR [df_jotype]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_dsdinvoice]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Earliest available') FOR [df_optimschedby]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_printsolabel]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_printjoblabel]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('pallet') FOR [df_autofingroup]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_promptpoblanket]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_code128asgs1128]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Myself') FOR [df_crmavailablefor]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((300000)) FOR [df_emvtimeout]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_picklistfacility]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_reqqcgrpesig]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_verboseemv]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((0)) FOR [df_crossrevict]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_upsacc]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_upspass]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_upsauth]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Full') FOR [df_recquan]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_upsshipnum]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('Smallest') FOR [df_lotpriority]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ((1)) FOR [df_upstest]
GO
ALTER TABLE [dbo].[dxdflt2] ADD  DEFAULT ('') FOR [df_enforcebarcode]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Onhand') FOR [df_jobonhand]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_sumregbom]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_posdec]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('All') FOR [df_template]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_icxstag]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Item') FOR [df_availview]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Hide') FOR [df_availzeroitems]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_includemlonpl]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_prodcostexp]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((40)) FOR [df_pdfxmargin]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((16)) FOR [df_pdfymargin]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Automatic') FOR [df_lotchooserselect]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Default') FOR [df_definqty]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_movelotbalance]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_xfercostexp]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_passpromptdays]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_pohlinkprompt]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_tjkey]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_saletaxchid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_issueunderlimit]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_issueunderenforce]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Facility') FOR [df_prestageinv]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Sales Tax') FOR [df_tjname]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_tjsync]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_jobfinbl]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('All') FOR [df_atriskimp]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('System Lot') FOR [df_qcfreqlottype]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_stagprtml]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((5)) FOR [df_joblen]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_syncjobdates]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_jobbomtrak]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('none') FOR [df_useanysyslot]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_otchid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Line') FOR [df_remsettings]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_chid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Receipt Minutes') FOR [df_jitcalc]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('pr_codenum') FOR [df_wmspartsearchorder]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_tarecatch]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Manual') FOR [df_contsergen]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_contserexpr]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Location Name First') FOR [df_wmslocsearchorder]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_dirputaway]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_otexpression]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Sunday') FOR [df_otstartofweek]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_scanpartsforpckgs]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_autovalidaddress]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_dfltvalidtype]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_qcparentinfo]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_copypromoprid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((2)) FOR [df_wmsloctypedelay]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_autopalletize]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_staginggroupby]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_taxtype]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_taxuser]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_taxpass]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_whitelistauth]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_emailauth]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_secquestionauth]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((3)) FOR [df_secquestions]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((10)) FOR [df_emailcodemins]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Reserve') FOR [df_reservetype]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('All') FOR [df_postburden]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Labor + OT') FOR [df_otexpense]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_suppressinvprompt]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_easypostapikey]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_incstagingondocs]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_poacashchid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_splitpayrolltime]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_copylinktoso]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Legacy') FOR [df_expreng]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_uniqueupc]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_pricingprefilter]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('tp_date') FOR [df_popricdate]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Sequential') FOR [df_masterlotgen]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_masterlotexp]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_masterorderprid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_scalecustomadds]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_trackeruser]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_trackerpass]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_rssdays]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_giftcardprid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_singleapp]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_byproductyield]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_dfltshiptoprompt]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_outlookemail]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Current') FOR [df_qcpendmoverev]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_excelgridfooter]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_xfacmarkchid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_popayacctchid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Full') FOR [df_defstagequan]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_taxsandboxmode]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Sequential') FOR [df_giftcardgen]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Sales Order') FOR [df_posordtype]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_prestagemasterlots]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_ldapdomain]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_custinvexcess]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_autoissuecontents]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Jobs') FOR [df_linkedsoworkflowcolor]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_shippingscript]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_syncjobquant]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_giftcardexp]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_singlejoblogon]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_backflushcatchwgt]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Basic') FOR [df_outlookauthtype]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_outlookappid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_outlooktenantid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_outlooksecret]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Standard') FOR [df_issueview]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_dfltcrmbiid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_dfltcrmshid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_savepackageshipped3]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Full Path') FOR [df_printername]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_labcostexp]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Lowest Price') FOR [df_popriceordselect]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_useshiptoterms]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_pricinglinedates]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Source') FOR [df_finalstageclear]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('None') FOR [df_prefillnextwms]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_workshift]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_recalcpoprices]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_inclccauthcredit]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_promptsopricing]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_customerlotexp]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_attribdelim]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_taxexemptapis]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_vattaxid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('European Central Bank') FOR [df_currencyratebank]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_jobchktypefinish]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Ship-To') FOR [df_removecustinv]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Line Save') FOR [df_recalcpriceon]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Line Save') FOR [df_recalcusercalcson]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Line Save') FOR [df_recalcpromoson]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_taxcompcode]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_inputdirectstaging]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_freightinprid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_applytaxonicxfer]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_costcoprod]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_brokaccr]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_excelpassword]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_dsdtemplatesync]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Non Lab-Only') FOR [df_costrollup]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_showzerolinesreserve]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_printqcbygroup]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((14)) FOR [df_maxcheckdetails]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_credshiphold]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_returnlinkedsolots]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_sosortexpr]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_sogroupexpr]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('New Lines') FOR [df_jourdescriptype]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('.ai, .bmp, .doc, .docx, .eps, .gif, .jpeg, .jpg, .odt, .pdf, .png, .ppt, .pptx, .rtf, .txt, .xls, .xlsx, .xml') FOR [df_allowablefiletypes]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_enforceseqstaging]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Arial') FOR [df_memofontname]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((9)) FOR [df_memofontsize]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('System Lot') FOR [df_coagrouping]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_reservemultipleusers]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_receiveictmultipleusers]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_receivemultipleusers]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_cancelbackordpo]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_committaxtransactions]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_taxclientlogging]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_unavailopid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_filterrestrictedselling]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Purchase Order') FOR [df_dropshipordtype]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_poinvadjust]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_autoreceivefreightpo]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Basic') FOR [df_triggeroutlookauthtype]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_triggeroutlookappid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_triggeroutlooktenantid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_triggeroutlooksecret]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_posprintcopies]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_promptcopynewlinkedso]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_fedacclegacy]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_fedpasslegacy]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_fedauthlegacy]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_fedshipacclegacy]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_fedmeternumlegacy]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_recalcjobcalcs]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_ssoappid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_ssourl]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('None') FOR [df_singlesignon]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Username') FOR [df_ssoauthmethod]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_sopricescript]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_popricescript]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_numberpass]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_specialcharpass]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_uppercasepass]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('Earliest') FOR [df_promisecalc]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_recorddochistory]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_purtaxchid]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_searchall]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_searchcontains]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_allowabledatafilepaths]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('None') FOR [df_wmsrecordbutton]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('') FOR [df_wmsrecordkeycode]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ('None') FOR [df_wmsshowrecordbutton]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_requireqcatrisk]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_overcredoverride]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((1)) FOR [df_allowshifting]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_multiuserqc]
GO
ALTER TABLE [dbo].[dxdflt3] ADD  DEFAULT ((0)) FOR [df_reqqcaftermove]
GO
ALTER TABLE [dbo].[dxecommsync] ADD  DEFAULT ('') FOR [es_table]
GO
ALTER TABLE [dbo].[dxecommsync] ADD  DEFAULT (NULL) FOR [es_date]
GO
ALTER TABLE [dbo].[dxecommsync] ADD  DEFAULT ('') FOR [es_time]
GO
ALTER TABLE [dbo].[dxecommsync] ADD  DEFAULT ((0)) FOR [es_csid]
GO
ALTER TABLE [dbo].[dxedihist] ADD  DEFAULT ((0)) FOR [eh_edid]
GO
ALTER TABLE [dbo].[dxedihist] ADD  DEFAULT ('') FOR [eh_file]
GO
ALTER TABLE [dbo].[dxedihist] ADD  DEFAULT ('') FOR [eh_msg]
GO
ALTER TABLE [dbo].[dxedihist] ADD  DEFAULT (NULL) FOR [eh_date]
GO
ALTER TABLE [dbo].[dxedihist] ADD  DEFAULT ('') FOR [eh_time]
GO
ALTER TABLE [dbo].[dxedihist] ADD  DEFAULT ('') FOR [eh_outcome]
GO
ALTER TABLE [dbo].[dxedihist] ADD  DEFAULT ('') FOR [eh_orders]
GO
ALTER TABLE [dbo].[dxedihist] ADD  DEFAULT ((0)) FOR [eh_line]
GO
ALTER TABLE [dbo].[dxedihist] ADD  DEFAULT ((0)) FOR [eh_hash]
GO
ALTER TABLE [dbo].[dxextern] ADD  DEFAULT ('') FOR [ex_name]
GO
ALTER TABLE [dbo].[dxextern] ADD  DEFAULT ('') FOR [ex_program]
GO
ALTER TABLE [dbo].[dxextern] ADD  DEFAULT ((0)) FOR [ex_private]
GO
ALTER TABLE [dbo].[dxextern] ADD  DEFAULT ((0)) FOR [ex_plugin]
GO
ALTER TABLE [dbo].[dxextern] ADD  DEFAULT ((0)) FOR [ex_trigger]
GO
ALTER TABLE [dbo].[dxextern] ADD  DEFAULT ('Program') FOR [ex_type]
GO
ALTER TABLE [dbo].[dxextern] ADD  DEFAULT ('') FOR [ex_script]
GO
ALTER TABLE [dbo].[dxexternhist] ADD  DEFAULT (NULL) FOR [xh_date]
GO
ALTER TABLE [dbo].[dxexternhist] ADD  DEFAULT ((0)) FOR [xh_exid]
GO
ALTER TABLE [dbo].[dxexternhist] ADD  DEFAULT ((0)) FOR [xh_usid]
GO
ALTER TABLE [dbo].[dxexternhist] ADD  DEFAULT ('') FOR [xh_time]
GO
ALTER TABLE [dbo].[dxexternhist] ADD  DEFAULT ('') FOR [xh_message]
GO
ALTER TABLE [dbo].[dxexternhist] ADD  DEFAULT ((0)) FOR [xh_recid]
GO
ALTER TABLE [dbo].[dxexternhist] ADD  DEFAULT ('') FOR [xh_stack]
GO
ALTER TABLE [dbo].[dxexternhist] ADD  DEFAULT ('') FOR [xh_table]
GO
ALTER TABLE [dbo].[dxexternhist] ADD  DEFAULT ('INFO') FOR [xh_level]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((0)) FOR [fv_usid]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ('') FOR [fv_caption]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((0)) FOR [fv_seq]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((0)) FOR [fv_dashboard]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ('') FOR [fv_sysname]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((30)) FOR [fv_interval]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((0)) FOR [fv_preview]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((0)) FOR [fv_d2id]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((0)) FOR [fv_copied]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((150)) FOR [fv_height]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((0)) FOR [fv_minimized]
GO
ALTER TABLE [dbo].[dxfav] ADD  DEFAULT ((0)) FOR [fv_autolaunch]
GO
ALTER TABLE [dbo].[dxgridhist] ADD  DEFAULT ((0)) FOR [gh_brid]
GO
ALTER TABLE [dbo].[dxgridhist] ADD  DEFAULT ('') FOR [gh_action]
GO
ALTER TABLE [dbo].[dxgridhist] ADD  DEFAULT (NULL) FOR [gh_date]
GO
ALTER TABLE [dbo].[dxgridhist] ADD  DEFAULT ((0)) FOR [gh_usid]
GO
ALTER TABLE [dbo].[dxgridhist] ADD  DEFAULT ((0)) FOR [gh_reccount]
GO
ALTER TABLE [dbo].[dxgridhist] ADD  DEFAULT ('') FOR [gh_filter]
GO
ALTER TABLE [dbo].[dxgridhist] ADD  DEFAULT ((0)) FOR [gh_time]
GO
ALTER TABLE [dbo].[dximphist] ADD  DEFAULT (NULL) FOR [ih_date]
GO
ALTER TABLE [dbo].[dximphist] ADD  DEFAULT ('') FOR [ih_time]
GO
ALTER TABLE [dbo].[dximphist] ADD  DEFAULT ('') FOR [ih_descrip]
GO
ALTER TABLE [dbo].[dximphist] ADD  DEFAULT ('') FOR [ih_file]
GO
ALTER TABLE [dbo].[dximphist] ADD  DEFAULT ('') FOR [ih_table]
GO
ALTER TABLE [dbo].[dximphist] ADD  DEFAULT ((0)) FOR [ih_imid]
GO
ALTER TABLE [dbo].[dximphist] ADD  DEFAULT ((0)) FOR [ih_usid]
GO
ALTER TABLE [dbo].[dximphist] ADD  DEFAULT ((0)) FOR [ih_dur]
GO
ALTER TABLE [dbo].[dxin] ADD  DEFAULT ((0)) FOR [in_usid]
GO
ALTER TABLE [dbo].[dxin] ADD  DEFAULT ((0)) FOR [in_mainapp]
GO
ALTER TABLE [dbo].[dxin] ADD  DEFAULT ((0)) FOR [in_cashreg]
GO
ALTER TABLE [dbo].[dxin] ADD  DEFAULT ((0)) FOR [in_wms]
GO
ALTER TABLE [dbo].[dxin] ADD  DEFAULT ((0)) FOR [in_mobile]
GO
ALTER TABLE [dbo].[dxin] ADD  DEFAULT ((0)) FOR [in_dsd]
GO
ALTER TABLE [dbo].[dxin] ADD  DEFAULT ((0)) FOR [in_tracker]
GO
ALTER TABLE [dbo].[dxin] ADD  DEFAULT ('') FOR [in_ecommerce]
GO
ALTER TABLE [dbo].[dxin] ADD  DEFAULT ((0)) FOR [in_uaid]
GO
ALTER TABLE [dbo].[dxintegrationlogging] ADD  DEFAULT ('') FOR [il_application]
GO
ALTER TABLE [dbo].[dxintegrationlogging] ADD  DEFAULT (NULL) FOR [il_date]
GO
ALTER TABLE [dbo].[dxintegrationlogging] ADD  DEFAULT ((0)) FOR [il_time]
GO
ALTER TABLE [dbo].[dxintegrationlogging] ADD  DEFAULT ('') FOR [il_returned]
GO
ALTER TABLE [dbo].[dxlinkdochist] ADD  DEFAULT (NULL) FOR [dh_date]
GO
ALTER TABLE [dbo].[dxlinkdochist] ADD  DEFAULT ('') FOR [dh_msg]
GO
ALTER TABLE [dbo].[dxlinkdochist] ADD  DEFAULT ('') FOR [dh_time]
GO
ALTER TABLE [dbo].[dxlinkdochist] ADD  DEFAULT ('') FOR [dh_outcome]
GO
ALTER TABLE [dbo].[dxlinkdochist] ADD  DEFAULT ('') FOR [dh_file]
GO
ALTER TABLE [dbo].[dxlinkdochist] ADD  DEFAULT ((0)) FOR [dh_liid]
GO
ALTER TABLE [dbo].[dxlog] ADD  DEFAULT ((0)) FOR [lo_usid]
GO
ALTER TABLE [dbo].[dxlog] ADD  DEFAULT (NULL) FOR [lo_date]
GO
ALTER TABLE [dbo].[dxlog] ADD  DEFAULT ('') FOR [lo_time]
GO
ALTER TABLE [dbo].[dxlog] ADD  DEFAULT ('') FOR [lo_recid]
GO
ALTER TABLE [dbo].[dxlog] ADD  DEFAULT ('') FOR [lo_table]
GO
ALTER TABLE [dbo].[dxlog] ADD  DEFAULT ((0)) FOR [lo_ihid]
GO
ALTER TABLE [dbo].[dxmfu] ADD  DEFAULT ((0)) FOR [mf_usid]
GO
ALTER TABLE [dbo].[dxmfu] ADD  DEFAULT ((0)) FOR [mf_m2id]
GO
ALTER TABLE [dbo].[dxmfu] ADD  DEFAULT ((0)) FOR [mf_count]
GO
ALTER TABLE [dbo].[dxmfu] ADD  DEFAULT ((0)) FOR [mf_mtid]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT (NULL) FOR [mo_date]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ('') FOR [mo_time]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ((0)) FOR [mo_usid]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ('') FOR [mo_table]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ('') FOR [mo_field]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ((0)) FOR [mo_recid]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ('') FOR [mo_oldval]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ('') FOR [mo_newval]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ('') FOR [mo_oldmemo]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ('') FOR [mo_newmemo]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ((0)) FOR [mo_oldid]
GO
ALTER TABLE [dbo].[dxmod] ADD  DEFAULT ((0)) FOR [mo_newid]
GO
ALTER TABLE [dbo].[dxmru] ADD  DEFAULT ((0)) FOR [mr_usid]
GO
ALTER TABLE [dbo].[dxmru] ADD  DEFAULT (NULL) FOR [mr_lastuse]
GO
ALTER TABLE [dbo].[dxmru] ADD  DEFAULT ((0)) FOR [mr_m2id]
GO
ALTER TABLE [dbo].[dxmru] ADD  DEFAULT ((0)) FOR [mr_mtid]
GO
ALTER TABLE [dbo].[dxperf] ADD  DEFAULT ('') FOR [pe_time]
GO
ALTER TABLE [dbo].[dxperf] ADD  DEFAULT ((0)) FOR [pe_dur]
GO
ALTER TABLE [dbo].[dxperf] ADD  DEFAULT ((0)) FOR [pe_usid]
GO
ALTER TABLE [dbo].[dxperf] ADD  DEFAULT ((0)) FOR [pe_brid]
GO
ALTER TABLE [dbo].[dxperf] ADD  DEFAULT (NULL) FOR [pe_date]
GO
ALTER TABLE [dbo].[dxperf] ADD  DEFAULT ('') FOR [pe_display]
GO
ALTER TABLE [dbo].[dxperf] ADD  DEFAULT ((0)) FOR [pe_max]
GO
ALTER TABLE [dbo].[dxping] ADD  DEFAULT ((0)) FOR [pi_token]
GO
ALTER TABLE [dbo].[dxping] ADD  DEFAULT (NULL) FOR [pi_pingtime]
GO
ALTER TABLE [dbo].[dxping] ADD  DEFAULT ('in_mainapp') FOR [pi_appsource]
GO
ALTER TABLE [dbo].[dxping] ADD  DEFAULT ((0)) FOR [pi_usid]
GO
ALTER TABLE [dbo].[dxprefilter] ADD  DEFAULT ('') FOR [pr_descrip]
GO
ALTER TABLE [dbo].[dxprefilter] ADD  DEFAULT ('') FOR [pr_name]
GO
ALTER TABLE [dbo].[dxprefilter] ADD  DEFAULT ((0)) FOR [pr_usid]
GO
ALTER TABLE [dbo].[dxprefilter] ADD  DEFAULT ((0)) FOR [pr_default]
GO
ALTER TABLE [dbo].[dxprefilter] ADD  DEFAULT ((0)) FOR [pr_fiid]
GO
ALTER TABLE [dbo].[dxprefilter] ADD  DEFAULT ((0)) FOR [pr_active]
GO
ALTER TABLE [dbo].[dxprefilter2] ADD  DEFAULT ('') FOR [p2_field]
GO
ALTER TABLE [dbo].[dxprefilter2] ADD  DEFAULT ('') FOR [p2_value]
GO
ALTER TABLE [dbo].[dxprefilter2] ADD  DEFAULT ((0)) FOR [p2_prid]
GO
ALTER TABLE [dbo].[dxprefilter2] ADD  DEFAULT ('') FOR [p2_table]
GO
ALTER TABLE [dbo].[dxpromptover] ADD  DEFAULT ((0)) FOR [po_ptid]
GO
ALTER TABLE [dbo].[dxpromptover] ADD  DEFAULT ((0)) FOR [po_caid]
GO
ALTER TABLE [dbo].[dxpromptover] ADD  DEFAULT ('') FOR [po_prompt]
GO
ALTER TABLE [dbo].[dxpset] ADD  DEFAULT ('') FOR [ps_fldname]
GO
ALTER TABLE [dbo].[dxpset] ADD  DEFAULT ((0)) FOR [ps_number]
GO
ALTER TABLE [dbo].[dxschedhist] ADD  DEFAULT (NULL) FOR [sc_date]
GO
ALTER TABLE [dbo].[dxschedhist] ADD  DEFAULT ((0)) FOR [sc_isid]
GO
ALTER TABLE [dbo].[dxschedhist] ADD  DEFAULT ((0)) FOR [sc_usid]
GO
ALTER TABLE [dbo].[dxschedhist] ADD  DEFAULT ('') FOR [sc_time]
GO
ALTER TABLE [dbo].[dxschedhist] ADD  DEFAULT ('') FOR [sc_error]
GO
ALTER TABLE [dbo].[dxschedperf] ADD  DEFAULT (NULL) FOR [sp_date]
GO
ALTER TABLE [dbo].[dxschedperf] ADD  DEFAULT ((0)) FOR [sp_dur]
GO
ALTER TABLE [dbo].[dxschedperf] ADD  DEFAULT ((0)) FOR [sp_max]
GO
ALTER TABLE [dbo].[dxschedperf] ADD  DEFAULT ('') FOR [sp_time]
GO
ALTER TABLE [dbo].[dxschedperf] ADD  DEFAULT ((0)) FOR [sp_usid]
GO
ALTER TABLE [dbo].[dxschedperf] ADD  DEFAULT ((0)) FOR [sp_isid]
GO
ALTER TABLE [dbo].[dxscripterr] ADD  DEFAULT ((0)) FOR [se_usid]
GO
ALTER TABLE [dbo].[dxscripterr] ADD  DEFAULT (NULL) FOR [se_date]
GO
ALTER TABLE [dbo].[dxscripterr] ADD  DEFAULT ((0)) FOR [se_time]
GO
ALTER TABLE [dbo].[dxscripterr] ADD  DEFAULT ('') FOR [se_document]
GO
ALTER TABLE [dbo].[dxscripterr] ADD  DEFAULT ('') FOR [se_error]
GO
ALTER TABLE [dbo].[dxscripterr] ADD  DEFAULT ('') FOR [se_script]
GO
ALTER TABLE [dbo].[dxscriptlog] ADD  DEFAULT ('') FOR [sl_hash]
GO
ALTER TABLE [dbo].[dxscriptlog] ADD  DEFAULT ('') FOR [sl_document]
GO
ALTER TABLE [dbo].[dxscriptlog] ADD  DEFAULT ('') FOR [sl_script]
GO
ALTER TABLE [dbo].[dxscriptlog] ADD  DEFAULT (NULL) FOR [sl_firstrun]
GO
ALTER TABLE [dbo].[dxscriptlog] ADD  DEFAULT (NULL) FOR [sl_lastrun]
GO
ALTER TABLE [dbo].[dxscriptperf] ADD  DEFAULT ((0)) FOR [sp_usid]
GO
ALTER TABLE [dbo].[dxscriptperf] ADD  DEFAULT (NULL) FOR [sp_date]
GO
ALTER TABLE [dbo].[dxscriptperf] ADD  DEFAULT ((0)) FOR [sp_time]
GO
ALTER TABLE [dbo].[dxscriptperf] ADD  DEFAULT ((0)) FOR [sp_seconds]
GO
ALTER TABLE [dbo].[dxscriptperf] ADD  DEFAULT ('') FOR [sp_document]
GO
ALTER TABLE [dbo].[dxscriptperf] ADD  DEFAULT ('') FOR [sp_script]
GO
ALTER TABLE [dbo].[dxsecmod] ADD  DEFAULT ((0)) FOR [sm_usid]
GO
ALTER TABLE [dbo].[dxsecmod] ADD  DEFAULT ((0)) FOR [sm_ugid]
GO
ALTER TABLE [dbo].[dxsecmod] ADD  DEFAULT ('') FOR [sm_table]
GO
ALTER TABLE [dbo].[dxsecmod] ADD  DEFAULT ('') FOR [sm_oldval]
GO
ALTER TABLE [dbo].[dxsecmod] ADD  DEFAULT ('') FOR [sm_newval]
GO
ALTER TABLE [dbo].[dxsecmod] ADD  DEFAULT (NULL) FOR [sm_date]
GO
ALTER TABLE [dbo].[dxsecmod] ADD  DEFAULT ((0)) FOR [sm_time]
GO
ALTER TABLE [dbo].[dxsecmod] ADD  DEFAULT ((0)) FOR [sm_changedby]
GO
ALTER TABLE [dbo].[dxsecmod] ADD  DEFAULT ((0)) FOR [sm_recid]
GO
ALTER TABLE [dbo].[dxservice] ADD  DEFAULT ('') FOR [sr_name]
GO
ALTER TABLE [dbo].[dxservice] ADD  DEFAULT (NULL) FOR [sr_lastran]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_name]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_caption]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_format]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_mask]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_display]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_table]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_index]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_retval]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_filter]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_title]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_addform]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ((0)) FOR [sr_user]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ((0)) FOR [sr_number]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_modparm]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_code]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ((0)) FOR [sr_systbl]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ((0)) FOR [sr_all]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ((0)) FOR [sr_doctbl]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ((0)) FOR [sr_isiphone]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ((0)) FOR [sr_sqlite]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_userfilter]
GO
ALTER TABLE [dbo].[dxsrch] ADD  DEFAULT ('') FOR [sr_internal]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ('') FOR [s2_name]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ('') FOR [s2_caption]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ('') FOR [s2_format]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ('') FOR [s2_mask]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ((10)) FOR [s2_width]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ('') FOR [s2_type]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ((0)) FOR [s2_sorter]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ((0)) FOR [s2_srnum]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ((0)) FOR [s2_user]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ((0)) FOR [s2_srid]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ((0)) FOR [s2_sortdsc]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ('') FOR [s2_iphonetype]
GO
ALTER TABLE [dbo].[dxsrch2] ADD  DEFAULT ((0)) FOR [s2_isiphone]
GO
ALTER TABLE [dbo].[dxtrak] ADD  DEFAULT ('') FOR [tr_name]
GO
ALTER TABLE [dbo].[dxtrak] ADD  DEFAULT ((1)) FOR [tr_active]
GO
ALTER TABLE [dbo].[dxtrak] ADD  DEFAULT ((0)) FOR [tr_default]
GO
ALTER TABLE [dbo].[dxtrak] ADD  DEFAULT ('dttord') FOR [tr_table]
GO
ALTER TABLE [dbo].[dxtrak] ADD  DEFAULT ('After Last Completed') FOR [tr_nextseq]
GO
ALTER TABLE [dbo].[dxtrak] ADD  DEFAULT ((0)) FOR [tr_revreset]
GO
ALTER TABLE [dbo].[dxtrak] ADD  DEFAULT ((1)) FOR [tr_resetbackorder]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ('') FOR [t2_name]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_trid]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_seq]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((1)) FOR [t2_active]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqseq]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqship]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqprod]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_level]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqpo]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqjob]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((16777215)) FOR [t2_color]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_usid]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqso]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqrecv]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_esig]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_lock]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_returnto]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ('') FOR [t2_plancalc]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_minpoext]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ('') FOR [t2_notes]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqjobclose]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_copytoback]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ('') FOR [t2_expression]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqpack]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqlabonly]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_bomqclock]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_bomroutlock]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_bomjobwflock]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqnotes]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ('None') FOR [t2_copybackorder]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_recurringstart]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_recurringend]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ('') FOR [t2_approveby]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqqcgroup]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ('') FOR [t2_assigneduserexp]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_esigcounts]
GO
ALTER TABLE [dbo].[dxtrak2] ADD  DEFAULT ((0)) FOR [t2_reqpost]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((0)) FOR [t3_t2id]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT (NULL) FOR [t3_date]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ('') FOR [t3_time]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((0)) FOR [t3_usid]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((-1)) FOR [t3_toid]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ('') FOR [t3_table]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((0)) FOR [t3_recid]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT (NULL) FOR [t3_planned]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ('') FOR [t3_notes]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((0)) FOR [t3_usid2]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((0)) FOR [t3_t4id]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((0)) FOR [t3_usid3]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((0)) FOR [t3_esigusid]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT (NULL) FOR [t3_created]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((0)) FOR [t3_returnto]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ('') FOR [t3_comment]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ((0)) FOR [t3_minpoext]
GO
ALTER TABLE [dbo].[dxtrak3] ADD  DEFAULT ('') FOR [t3_expression]
GO
ALTER TABLE [dbo].[dxtrak4] ADD  DEFAULT ('') FOR [t4_table]
GO
ALTER TABLE [dbo].[dxtrak4] ADD  DEFAULT ((0)) FOR [t4_recid]
GO
ALTER TABLE [dbo].[dxtrak4] ADD  DEFAULT ('') FOR [t4_name]
GO
ALTER TABLE [dbo].[dxtrak4] ADD  DEFAULT ((0)) FOR [t4_usid]
GO
ALTER TABLE [dbo].[dxtrak4] ADD  DEFAULT ((0)) FOR [t4_seq]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_name]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_event]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_destination]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((1)) FOR [tg_active]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_msg]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_attach]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_sql]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_table]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_output]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_conditions]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((0)) FOR [tg_template]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_subject]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_ftpserver]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_ftpuser]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_ftppass]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((1)) FOR [tg_crlf]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((0)) FOR [tg_invssl]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((1)) FOR [tg_binary]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('UTF-8') FOR [tg_encoding]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_delexp]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((0)) FOR [tg_sftp]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_delcondition]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((0)) FOR [tg_exid]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((0)) FOR [tg_ftpport]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((0)) FOR [tg_brid]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((0)) FOR [tg_reid]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ((0)) FOR [tg_excel]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_notes]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_ccemail]
GO
ALTER TABLE [dbo].[dxtrig] ADD  DEFAULT ('') FOR [tg_bccemail]
GO
ALTER TABLE [dbo].[dxtrighist] ADD  DEFAULT (NULL) FOR [th_date]
GO
ALTER TABLE [dbo].[dxtrighist] ADD  DEFAULT ('') FOR [th_time]
GO
ALTER TABLE [dbo].[dxtrighist] ADD  DEFAULT ((0)) FOR [th_tgid]
GO
ALTER TABLE [dbo].[dxtrighist] ADD  DEFAULT ('') FOR [th_msg]
GO
ALTER TABLE [dbo].[dxtrighist] ADD  DEFAULT ((1)) FOR [th_processed]
GO
ALTER TABLE [dbo].[dxtrighist] ADD  DEFAULT ('') FOR [th_table]
GO
ALTER TABLE [dbo].[dxtrighist] ADD  DEFAULT ((0)) FOR [th_recid]
GO
ALTER TABLE [dbo].[dxwmslastact] ADD  DEFAULT ((0)) FOR [la_usid]
GO
ALTER TABLE [dbo].[dxwmslastact] ADD  DEFAULT (NULL) FOR [la_datetime]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT ((0)) FOR [wg_allonum]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT ((0)) FOR [wg_usid]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT (NULL) FOR [wg_date]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT ((0)) FOR [wg_time]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT ((0)) FOR [wg_fiid]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT ((0)) FOR [wg_lotnum]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT ('') FOR [wg_userlot]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT ((0)) FOR [wg_quant]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT ('') FOR [wg_transaction]
GO
ALTER TABLE [dbo].[dxwmslog] ADD  DEFAULT ('') FOR [wg_action]
GO
ALTER TABLE [dbo].[dm1099type]  WITH CHECK ADD  CONSTRAINT [CK_dm1099type] CHECK  (([ty_id]<>(0) AND [ty_name]<>'' AND [ty_fieldname]<>''))
GO
ALTER TABLE [dbo].[dm1099type] CHECK CONSTRAINT [CK_dm1099type]
GO
ALTER TABLE [dbo].[dmalloc]  WITH CHECK ADD  CONSTRAINT [CK_dmalloc] CHECK  (([al_id]<>(0) AND [al_childchid]<>(0) AND [al_parentchid]<>(0) AND [al_pct]<>(0)))
GO
ALTER TABLE [dbo].[dmalloc] CHECK CONSTRAINT [CK_dmalloc]
GO
ALTER TABLE [dbo].[dmalpn]  WITH CHECK ADD  CONSTRAINT [CK_dmalpn] CHECK  (([alp_number]<>(0)))
GO
ALTER TABLE [dbo].[dmalpn] CHECK CONSTRAINT [CK_dmalpn]
GO
ALTER TABLE [dbo].[dmauth]  WITH CHECK ADD  CONSTRAINT [CK_dmauth] CHECK  (([au_id]<>(0) AND [au_name]<>' '))
GO
ALTER TABLE [dbo].[dmauth] CHECK CONSTRAINT [CK_dmauth]
GO
ALTER TABLE [dbo].[dmautoclient]  WITH CHECK ADD  CONSTRAINT [CK_dmautoclient] CHECK  (([ac_id]<>(0) AND [ac_source]<>' '))
GO
ALTER TABLE [dbo].[dmautoclient] CHECK CONSTRAINT [CK_dmautoclient]
GO
ALTER TABLE [dbo].[dmautoexport]  WITH CHECK ADD  CONSTRAINT [CK_dmautoexport] CHECK  (([ae_interval]<>' ' AND [ae_id]<>(0) AND [ae_reportid]<>(0) AND [ae_reportfor]<>' '))
GO
ALTER TABLE [dbo].[dmautoexport] CHECK CONSTRAINT [CK_dmautoexport]
GO
ALTER TABLE [dbo].[dmbankacc]  WITH CHECK ADD  CONSTRAINT [CK_dmbankacc] CHECK  (([ba_id]<>(0) AND [ba_name]<>' ' AND [ba_bankid]<>' ' AND [ba_accname]<>' ' AND [ba_account]<>' '))
GO
ALTER TABLE [dbo].[dmbankacc] CHECK CONSTRAINT [CK_dmbankacc]
GO
ALTER TABLE [dbo].[dmbcodefmt]  WITH CHECK ADD  CONSTRAINT [CK_dmbcodefmt] CHECK  (([bf_id]<>(0)))
GO
ALTER TABLE [dbo].[dmbcodefmt] CHECK CONSTRAINT [CK_dmbcodefmt]
GO
ALTER TABLE [dbo].[dmbcodeseg]  WITH CHECK ADD  CONSTRAINT [CK_dmbcodeseg] CHECK  (([bs_id]<>(0) AND [bs_bfid]<>(0)))
GO
ALTER TABLE [dbo].[dmbcodeseg] CHECK CONSTRAINT [CK_dmbcodeseg]
GO
ALTER TABLE [dbo].[dmbiassign]  WITH CHECK ADD  CONSTRAINT [CK_dmbiassign] CHECK  (([ba_id]<>(0) AND [ba_bpid]<>(0) AND [ba_usid]<>(0)))
GO
ALTER TABLE [dbo].[dmbiassign] CHECK CONSTRAINT [CK_dmbiassign]
GO
ALTER TABLE [dbo].[dmbicategory]  WITH CHECK ADD  CONSTRAINT [CK_dmbicategory] CHECK  (([bc_name]<>' '))
GO
ALTER TABLE [dbo].[dmbicategory] CHECK CONSTRAINT [CK_dmbicategory]
GO
ALTER TABLE [dbo].[dmbicatsecurity]  WITH CHECK ADD  CONSTRAINT [CK_dmbicatsecurity] CHECK  (([bs_bcid]<>(0) AND [bs_ugid]<>(0)))
GO
ALTER TABLE [dbo].[dmbicatsecurity] CHECK CONSTRAINT [CK_dmbicatsecurity]
GO
ALTER TABLE [dbo].[dmbicolorprofiles]  WITH CHECK ADD  CONSTRAINT [CK_dmbicolorprofiles] CHECK  (([cp_name]<>' '))
GO
ALTER TABLE [dbo].[dmbicolorprofiles] CHECK CONSTRAINT [CK_dmbicolorprofiles]
GO
ALTER TABLE [dbo].[dmbicolors]  WITH CHECK ADD  CONSTRAINT [CK_dmbicolors] CHECK  (([bc_cpid]<>(0) AND [bc_seq]<>(0) AND [bc_color]<>(0)))
GO
ALTER TABLE [dbo].[dmbicolors] CHECK CONSTRAINT [CK_dmbicolors]
GO
ALTER TABLE [dbo].[dmbidataset]  WITH CHECK ADD  CONSTRAINT [CK_dmbidataset] CHECK  (([bd_id]<>(0) AND [bd_name]<>'' AND ([bd_d2id]<>(0) OR [bd_daid]<>(0))))
GO
ALTER TABLE [dbo].[dmbidataset] CHECK CONSTRAINT [CK_dmbidataset]
GO
ALTER TABLE [dbo].[dmbielement]  WITH CHECK ADD  CONSTRAINT [CK_dmbielement] CHECK  (([be_id]<>(0) AND [be_bdid]<>(0) AND [be_bpid]<>(0) AND [be_type]<>''))
GO
ALTER TABLE [dbo].[dmbielement] CHECK CONSTRAINT [CK_dmbielement]
GO
ALTER TABLE [dbo].[dmbigridcols]  WITH CHECK ADD  CONSTRAINT [CK_dmbigridcols] CHECK  (([bc_id]<>(0) AND [bc_beid]<>(0) AND [bc_b2id]<>(0)))
GO
ALTER TABLE [dbo].[dmbigridcols] CHECK CONSTRAINT [CK_dmbigridcols]
GO
ALTER TABLE [dbo].[dmbill]  WITH CHECK ADD  CONSTRAINT [CK_dmbill] CHECK  (([bi_id]<>(0) AND [bi_name]<>' ' AND [bi_grid]<>(0) AND [bi_teid]<>(0) AND [bi_brid]<>(0) AND [bi_s1id]<>(0) AND [bi_s2id]<>(0) AND [bi_s3id]<>(0) AND [bi_s4id]<>(0) AND [bi_s5id]<>(0) AND [bi_trid]<>(0) AND [bi_frid]<>(0) AND [bi_fcid]<>(0)))
GO
ALTER TABLE [dbo].[dmbill] CHECK CONSTRAINT [CK_dmbill]
GO
ALTER TABLE [dbo].[dmbillfacility]  WITH CHECK ADD  CONSTRAINT [CK_dmbillfacility] CHECK  (([bf_id]<>(0) AND [bf_biid]<>(0) AND [bf_waid]<>(0)))
GO
ALTER TABLE [dbo].[dmbillfacility] CHECK CONSTRAINT [CK_dmbillfacility]
GO
ALTER TABLE [dbo].[dmbillship]  WITH CHECK ADD  CONSTRAINT [CK_dmbillship] CHECK  (([bs_id]<>(0) AND [bs_biid]<>(0) AND [bs_shid]<>(0)))
GO
ALTER TABLE [dbo].[dmbillship] CHECK CONSTRAINT [CK_dmbillship]
GO
ALTER TABLE [dbo].[dmbipage]  WITH CHECK ADD  CONSTRAINT [CK_dmbipage] CHECK  (([bp_id]<>(0) AND [bp_name]<>''))
GO
ALTER TABLE [dbo].[dmbipage] CHECK CONSTRAINT [CK_dmbipage]
GO
ALTER TABLE [dbo].[dmbom]  WITH CHECK ADD  CONSTRAINT [CK_dmbom] CHECK  (([bo_id]<>(0) AND [bo_prid]<>(0) AND [bo_seq]<>(0) AND [bo_reid]<>(0) AND [bo_bomfor]<>(0) AND [bo_unid]<>(0)))
GO
ALTER TABLE [dbo].[dmbom] CHECK CONSTRAINT [CK_dmbom]
GO
ALTER TABLE [dbo].[dmbomgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmbomgrp] CHECK  (([bg_name]<>''))
GO
ALTER TABLE [dbo].[dmbomgrp] CHECK CONSTRAINT [CK_dmbomgrp]
GO
ALTER TABLE [dbo].[dmbrok]  WITH CHECK ADD  CONSTRAINT [CK_dmbrok] CHECK  (([br_id]<>(0) AND [br_name]<>' '))
GO
ALTER TABLE [dbo].[dmbrok] CHECK CONSTRAINT [CK_dmbrok]
GO
ALTER TABLE [dbo].[dmbud]  WITH CHECK ADD  CONSTRAINT [CK_dmbud] CHECK  (([bu_id]<>(0) AND [bu_peid]<>(0) AND [bu_chid]<>(0)))
GO
ALTER TABLE [dbo].[dmbud] CHECK CONSTRAINT [CK_dmbud]
GO
ALTER TABLE [dbo].[dmbuyer]  WITH CHECK ADD  CONSTRAINT [CK_dmbuyer] CHECK  (([bu_id]<>(0) AND [bu_name]<>' '))
GO
ALTER TABLE [dbo].[dmbuyer] CHECK CONSTRAINT [CK_dmbuyer]
GO
ALTER TABLE [dbo].[dmcalc]  WITH CHECK ADD  CONSTRAINT [CK_dmcalc] CHECK  (([ca_id]<>(0) AND [ca_name]<>' ' AND [ca_type]<>' ' AND [ca_picture]<>' ' AND [ca_field]<>' ' AND [ca_fldtype]<>' '))
GO
ALTER TABLE [dbo].[dmcalc] CHECK CONSTRAINT [CK_dmcalc]
GO
ALTER TABLE [dbo].[dmcampaign]  WITH CHECK ADD  CONSTRAINT [CK_dmcampaign] CHECK  (([ca_id]<>(0) AND [ca_name]<>' '))
GO
ALTER TABLE [dbo].[dmcampaign] CHECK CONSTRAINT [CK_dmcampaign]
GO
ALTER TABLE [dbo].[dmcampaignemail]  WITH CHECK ADD  CONSTRAINT [CK_dmcampaignemail] CHECK  (([ce_id]<>(0) AND [ce_name]<>' '))
GO
ALTER TABLE [dbo].[dmcampaignemail] CHECK CONSTRAINT [CK_dmcampaignemail]
GO
ALTER TABLE [dbo].[dmcash3]  WITH CHECK ADD  CONSTRAINT [CK_dmcash3] CHECK  (([c3_id]<>(0) AND [c3_name]<>' '))
GO
ALTER TABLE [dbo].[dmcash3] CHECK CONSTRAINT [CK_dmcash3]
GO
ALTER TABLE [dbo].[dmcats]  WITH CHECK ADD  CONSTRAINT [CK_dmcats] CHECK  (([ca_id]<>(0) AND [ca_name]<>' '))
GO
ALTER TABLE [dbo].[dmcats] CHECK CONSTRAINT [CK_dmcats]
GO
ALTER TABLE [dbo].[dmcats2]  WITH CHECK ADD  CONSTRAINT [CK_dmcats2] CHECK  (([c2_id]<>(0) AND [c2_name]<>' ' AND [c2_caid]<>(0)))
GO
ALTER TABLE [dbo].[dmcats2] CHECK CONSTRAINT [CK_dmcats2]
GO
ALTER TABLE [dbo].[dmcats3]  WITH CHECK ADD  CONSTRAINT [CK_dmcats3] CHECK  (([c3_id]<>(0) AND ([c3_caid]<>(0) OR [c3_exid]<>(0) OR [c3_rsid]<>(0) OR [c3_rtid]<>(0) OR [c3_p1id]<>(0) OR [c3_p2id]<>(0) OR [c3_p3id]<>(0) OR [c3_p4id]<>(0) OR [c3_p5id]<>(0)) AND ([c3_biid]<>(0) OR [c3_shid]<>(0) OR [c3_waid]<>(0) OR [c3_parentrsid]<>(0))))
GO
ALTER TABLE [dbo].[dmcats3] CHECK CONSTRAINT [CK_dmcats3]
GO
ALTER TABLE [dbo].[dmccard]  WITH CHECK ADD  CONSTRAINT [CK_dmccard] CHECK  (([cc_c3id]<>(0) AND [cc_number]<>'' AND [cc_nameoncard]<>'' AND [cc_exp]<>(0) OR [cc_biid]<>(0) AND [cc_cardvaultid]<>''))
GO
ALTER TABLE [dbo].[dmccard] CHECK CONSTRAINT [CK_dmccard]
GO
ALTER TABLE [dbo].[dmccproc]  WITH CHECK ADD  CONSTRAINT [CK_dmccproc] CHECK  (([cc_id]<>(0)))
GO
ALTER TABLE [dbo].[dmccproc] CHECK CONSTRAINT [CK_dmccproc]
GO
ALTER TABLE [dbo].[dmcent]  WITH CHECK ADD  CONSTRAINT [CK_dmcent] CHECK  (([ce_id]<>(0) AND [ce_name]<>' ' AND [ce_shid]<>(0)))
GO
ALTER TABLE [dbo].[dmcent] CHECK CONSTRAINT [CK_dmcent]
GO
ALTER TABLE [dbo].[dmcentmaint]  WITH CHECK ADD  CONSTRAINT [CK_dmcentmaint] CHECK  (([cm_id]<>(0) AND [cm_recid]<>(0) AND [cm_prid]<>(0) AND [cm_recurtype]<>' ' AND [cm_table]<>' '))
GO
ALTER TABLE [dbo].[dmcentmaint] CHECK CONSTRAINT [CK_dmcentmaint]
GO
ALTER TABLE [dbo].[dmcentstatus]  WITH CHECK ADD  CONSTRAINT [CK_dmcentstatus] CHECK  (([cs_id]<>(0) AND [cs_cmid]<>(0)))
GO
ALTER TABLE [dbo].[dmcentstatus] CHECK CONSTRAINT [CK_dmcentstatus]
GO
ALTER TABLE [dbo].[dmcenttype]  WITH CHECK ADD  CONSTRAINT [CK_dmcenttype] CHECK  (([ct_id]<>(0) AND [ct_name]<>' '))
GO
ALTER TABLE [dbo].[dmcenttype] CHECK CONSTRAINT [CK_dmcenttype]
GO
ALTER TABLE [dbo].[dmchangeover]  WITH CHECK ADD  CONSTRAINT [CK_dmchangeover] CHECK  (([co_id]<>(0) AND [co_prevseq1]<>(0) AND [co_nextseq1]<>(0) AND [co_opid]<>(0) AND [co_prid]<>(0)))
GO
ALTER TABLE [dbo].[dmchangeover] CHECK CONSTRAINT [CK_dmchangeover]
GO
ALTER TABLE [dbo].[dmchgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmchgrp] CHECK  (([cg_id]<>(0) AND [cg_name]<>' '))
GO
ALTER TABLE [dbo].[dmchgrp] CHECK CONSTRAINT [CK_dmchgrp]
GO
ALTER TABLE [dbo].[dmchgrp2]  WITH CHECK ADD  CONSTRAINT [CK_dmchgrp2] CHECK  (([c2_id]<>(0) AND [c2_cgid]<>(0)))
GO
ALTER TABLE [dbo].[dmchgrp2] CHECK CONSTRAINT [CK_dmchgrp2]
GO
ALTER TABLE [dbo].[dmchrt]  WITH CHECK ADD  CONSTRAINT [CK_dmchrt] CHECK  (([ch_id]<>(0) AND [ch_account]<>(0) AND [ch_cgid]<>(0) AND [ch_name]<>' ' AND [ch_type]<>' '))
GO
ALTER TABLE [dbo].[dmchrt] CHECK CONSTRAINT [CK_dmchrt]
GO
ALTER TABLE [dbo].[dmcmscatlink]  WITH CHECK ADD  CONSTRAINT [CK_dmcmscatlink] CHECK  (([cl_ccid]<>(0) AND [cl_csid]<>(0)))
GO
ALTER TABLE [dbo].[dmcmscatlink] CHECK CONSTRAINT [CK_dmcmscatlink]
GO
ALTER TABLE [dbo].[dmcmscats]  WITH CHECK ADD  CONSTRAINT [CK_dmcmscats] CHECK  (([cc_ecomcat]<>'' AND [cc_type]<>''))
GO
ALTER TABLE [dbo].[dmcmscats] CHECK CONSTRAINT [CK_dmcmscats]
GO
ALTER TABLE [dbo].[dmcmsmenus]  WITH CHECK ADD  CONSTRAINT [CK_dmcmsmenus] CHECK  (([cm_id]<>(0)))
GO
ALTER TABLE [dbo].[dmcmsmenus] CHECK CONSTRAINT [CK_dmcmsmenus]
GO
ALTER TABLE [dbo].[dmcmsparentcats]  WITH CHECK ADD  CONSTRAINT [CK_dmcmsparentcats] CHECK  (([pc_ccid]<>(0) AND [pc_parentccid]<>(0)))
GO
ALTER TABLE [dbo].[dmcmsparentcats] CHECK CONSTRAINT [CK_dmcmsparentcats]
GO
ALTER TABLE [dbo].[dmcmssecquest]  WITH CHECK ADD  CONSTRAINT [CK_dmcmssecquest] CHECK  (([cq_id]<>(0) AND [cq_question]<>''))
GO
ALTER TABLE [dbo].[dmcmssecquest] CHECK CONSTRAINT [CK_dmcmssecquest]
GO
ALTER TABLE [dbo].[dmcmsuseracc]  WITH CHECK ADD  CONSTRAINT [CK_dmcmsuseracc] CHECK  (([cu_id]<>(0) AND [cu_password]<>'' AND [cu_login]<>'' AND [cu_email]<>'' AND ([cu_biid]<>(0) OR [cu_statelessapionly]<>(0))))
GO
ALTER TABLE [dbo].[dmcmsuseracc] CHECK CONSTRAINT [CK_dmcmsuseracc]
GO
ALTER TABLE [dbo].[dmco1]  WITH CHECK ADD  CONSTRAINT [CK_dmco1] CHECK  (([c1_id]<>(0) AND [c1_name]<>' '))
GO
ALTER TABLE [dbo].[dmco1] CHECK CONSTRAINT [CK_dmco1]
GO
ALTER TABLE [dbo].[dmco2]  WITH CHECK ADD  CONSTRAINT [CK_dmco2] CHECK  (([c2_id]<>(0) AND [c2_name]<>' '))
GO
ALTER TABLE [dbo].[dmco2] CHECK CONSTRAINT [CK_dmco2]
GO
ALTER TABLE [dbo].[dmco3]  WITH CHECK ADD  CONSTRAINT [CK_dmco3] CHECK  (([c3_id]<>(0) AND [c3_name]<>' '))
GO
ALTER TABLE [dbo].[dmco3] CHECK CONSTRAINT [CK_dmco3]
GO
ALTER TABLE [dbo].[dmco4]  WITH CHECK ADD  CONSTRAINT [CK_dmco4] CHECK  (([c4_id]<>(0) AND [c4_name]<>' '))
GO
ALTER TABLE [dbo].[dmco4] CHECK CONSTRAINT [CK_dmco4]
GO
ALTER TABLE [dbo].[dmco5]  WITH CHECK ADD  CONSTRAINT [CK_dmco5] CHECK  (([c5_id]<>(0) AND [c5_name]<>' '))
GO
ALTER TABLE [dbo].[dmco5] CHECK CONSTRAINT [CK_dmco5]
GO
ALTER TABLE [dbo].[dmcogrp]  WITH CHECK ADD  CONSTRAINT [CK_dmcogrp] CHECK  (([cg_id]<>(0) AND [cg_name]<>' '))
GO
ALTER TABLE [dbo].[dmcogrp] CHECK CONSTRAINT [CK_dmcogrp]
GO
ALTER TABLE [dbo].[dmcogrp2]  WITH CHECK ADD  CONSTRAINT [CK_dmcogrp2] CHECK  (([c2_id]<>(0) AND [c2_cgid]<>(0) AND [c2_usid]<>(0)))
GO
ALTER TABLE [dbo].[dmcogrp2] CHECK CONSTRAINT [CK_dmcogrp2]
GO
ALTER TABLE [dbo].[dmcolsums]  WITH CHECK ADD  CONSTRAINT [CK_dmcolsums] CHECK  (([cs_id]<>(0) AND [cs_usid]<>(0) AND [cs_reporttype]<>'' AND [cs_gridclass]<>''))
GO
ALTER TABLE [dbo].[dmcolsums] CHECK CONSTRAINT [CK_dmcolsums]
GO
ALTER TABLE [dbo].[dmcomm2]  WITH CHECK ADD  CONSTRAINT [CK_dmcomm2] CHECK  (([c2_id]<>(0) AND [c2_for]<>' ' AND [c2_forname]<>' ' AND [c2_on]<>' ' AND [c2_onname]<>' ' AND [c2_type]<>' ' AND [c2_start] IS NOT NULL AND [c2_end] IS NOT NULL))
GO
ALTER TABLE [dbo].[dmcomm2] CHECK CONSTRAINT [CK_dmcomm2]
GO
ALTER TABLE [dbo].[dmcommgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmcommgrp] CHECK  (([cg_id]<>(0) AND [cg_name]<>''))
GO
ALTER TABLE [dbo].[dmcommgrp] CHECK CONSTRAINT [CK_dmcommgrp]
GO
ALTER TABLE [dbo].[dmconstant]  WITH CHECK ADD  CONSTRAINT [CK_dmconstant] CHECK  (([co_id]<>(0) AND [co_name]<>' '))
GO
ALTER TABLE [dbo].[dmconstant] CHECK CONSTRAINT [CK_dmconstant]
GO
ALTER TABLE [dbo].[dmcont]  WITH CHECK ADD  CONSTRAINT [CK_dmcont] CHECK  (([co_id]<>(0) AND [co_u1id]<>(0) AND [co_u2id]<>(0) AND [co_u3id]<>(0) AND [co_u4id]<>(0) AND [co_u5id]<>(0) AND [co_usid]<>(0)))
GO
ALTER TABLE [dbo].[dmcont] CHECK CONSTRAINT [CK_dmcont]
GO
ALTER TABLE [dbo].[dmcont2]  WITH CHECK ADD  CONSTRAINT [CK_dmcont2] CHECK  (([c2_id]<>(0) AND [c2_coid]<>(0) AND [c2_usid]<>(0) AND [c2_ctid]<>(0) AND [c2_date] IS NOT NULL AND [c2_cpid]<>(0)))
GO
ALTER TABLE [dbo].[dmcont2] CHECK CONSTRAINT [CK_dmcont2]
GO
ALTER TABLE [dbo].[dmcontainer]  WITH CHECK ADD  CONSTRAINT [CK_dmcontainer] CHECK  (([cr_id]<>(0) AND [cr_contnum]<>' ' AND [cr_unid]<>(0)))
GO
ALTER TABLE [dbo].[dmcontainer] CHECK CONSTRAINT [CK_dmcontainer]
GO
ALTER TABLE [dbo].[dmcontcampaign]  WITH CHECK ADD  CONSTRAINT [CK_dmcontcampaign] CHECK  (([cn_id]<>(0) AND [cn_caid]<>(0)))
GO
ALTER TABLE [dbo].[dmcontcampaign] CHECK CONSTRAINT [CK_dmcontcampaign]
GO
ALTER TABLE [dbo].[dmcontpeople]  WITH CHECK ADD  CONSTRAINT [CK_dmcontpeople] CHECK  (([cp_id]<>(0) AND [cp_coid]<>(0) AND [cp_lname]<>' '))
GO
ALTER TABLE [dbo].[dmcontpeople] CHECK CONSTRAINT [CK_dmcontpeople]
GO
ALTER TABLE [dbo].[dmcountry]  WITH CHECK ADD  CONSTRAINT [CK_dmcountry] CHECK  (([cy_id]>(0) AND [cy_code]>(0) AND [cy_name]<>' '))
GO
ALTER TABLE [dbo].[dmcountry] CHECK CONSTRAINT [CK_dmcountry]
GO
ALTER TABLE [dbo].[dmcrew]  WITH CHECK ADD  CONSTRAINT [CK_dmcrew] CHECK  (([cr_id]<>(0) AND [cr_name]<>' '))
GO
ALTER TABLE [dbo].[dmcrew] CHECK CONSTRAINT [CK_dmcrew]
GO
ALTER TABLE [dbo].[dmcrmprojcats]  WITH CHECK ADD  CONSTRAINT [CK_dmcrmprojcats] CHECK  (([cc_id]<>(0) AND [cc_name]<>' '))
GO
ALTER TABLE [dbo].[dmcrmprojcats] CHECK CONSTRAINT [CK_dmcrmprojcats]
GO
ALTER TABLE [dbo].[dmctype]  WITH CHECK ADD  CONSTRAINT [CK_dmctype] CHECK  (([ct_id]<>(0) AND [ct_name]<>' '))
GO
ALTER TABLE [dbo].[dmctype] CHECK CONSTRAINT [CK_dmctype]
GO
ALTER TABLE [dbo].[dmctypesec]  WITH CHECK ADD  CONSTRAINT [CK_dmctypesec] CHECK  (([cs_id]<>(0) AND [cs_ctid]<>(0) AND [cs_ugid]<>(0)))
GO
ALTER TABLE [dbo].[dmctypesec] CHECK CONSTRAINT [CK_dmctypesec]
GO
ALTER TABLE [dbo].[dmcust]  WITH CHECK ADD  CONSTRAINT [CK_dmcust] CHECK  (([cu_id]<>(0) AND [cu_biid]<>(0) AND [cu_prid]<>(0)))
GO
ALTER TABLE [dbo].[dmcust] CHECK CONSTRAINT [CK_dmcust]
GO
ALTER TABLE [dbo].[dmcustlabel]  WITH CHECK ADD  CONSTRAINT [CK_dmcustlabel] CHECK  (([cl_cuid]<>(0) AND [cl_rdid]<>(0)))
GO
ALTER TABLE [dbo].[dmcustlabel] CHECK CONSTRAINT [CK_dmcustlabel]
GO
ALTER TABLE [dbo].[dmcwbarcode]  WITH CHECK ADD  CONSTRAINT [CK_dmcwbarcode] CHECK  (([cb_id]<>(0) AND [cb_length]<>(0) AND [cb_pricestart]<>(0) AND [cb_priceend]<>(0) AND [cb_partstart]<>(0) AND [cb_partend]<>(0)))
GO
ALTER TABLE [dbo].[dmcwbarcode] CHECK CONSTRAINT [CK_dmcwbarcode]
GO
ALTER TABLE [dbo].[dmd1]  WITH CHECK ADD  CONSTRAINT [CK_dmd1] CHECK  (([d1_id]<>(0) AND [d1_table]<>' ' AND [d1_title]<>' ' AND [d1_type]<>' '))
GO
ALTER TABLE [dbo].[dmd1] CHECK CONSTRAINT [CK_dmd1]
GO
ALTER TABLE [dbo].[dmd3]  WITH CHECK ADD  CONSTRAINT [CK_dmd3] CHECK  (([d3_id]<>(0) AND [d3_d1id]<>(0)))
GO
ALTER TABLE [dbo].[dmd3] CHECK CONSTRAINT [CK_dmd3]
GO
ALTER TABLE [dbo].[dmdash]  WITH CHECK ADD  CONSTRAINT [CK_dmdash] CHECK  (([da_id]<>(0)))
GO
ALTER TABLE [dbo].[dmdash] CHECK CONSTRAINT [CK_dmdash]
GO
ALTER TABLE [dbo].[dmdash2]  WITH CHECK ADD  CONSTRAINT [CK_dmdash2] CHECK  (([d2_id]<>(0) AND [d2_brid]<>(0)))
GO
ALTER TABLE [dbo].[dmdash2] CHECK CONSTRAINT [CK_dmdash2]
GO
ALTER TABLE [dbo].[dmdash3]  WITH CHECK ADD  CONSTRAINT [CK_dmdash3] CHECK  (([d3_id]<>(0) AND [d3_daid]<>(0)))
GO
ALTER TABLE [dbo].[dmdash3] CHECK CONSTRAINT [CK_dmdash3]
GO
ALTER TABLE [dbo].[dmdashparams]  WITH CHECK ADD  CONSTRAINT [CK_dmdashparams] CHECK  (([dp_id]<>(0) AND [dp_d2id]<>(0) AND [dp_type]<>''))
GO
ALTER TABLE [dbo].[dmdashparams] CHECK CONSTRAINT [CK_dmdashparams]
GO
ALTER TABLE [dbo].[dmdeal]  WITH CHECK ADD  CONSTRAINT [CK_dmdeal] CHECK  (([de_id]<>(0) AND [de_for]<>' ' AND [de_forname]<>' ' AND [de_on]<>' ' AND [de_onname]<>' ' AND [de_type]<>' ' AND [de_basedon]<>' ' AND [de_start] IS NOT NULL AND [de_end] IS NOT NULL))
GO
ALTER TABLE [dbo].[dmdeal] CHECK CONSTRAINT [CK_dmdeal]
GO
ALTER TABLE [dbo].[dmdgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmdgrp] CHECK  (([dg_id]<>(0) AND [dg_name]<>' '))
GO
ALTER TABLE [dbo].[dmdgrp] CHECK CONSTRAINT [CK_dmdgrp]
GO
ALTER TABLE [dbo].[dmdgrp2]  WITH CHECK ADD  CONSTRAINT [CK_dmdgrp2] CHECK  (([d2_id]<>(0) AND [d2_dgid]<>(0) AND ([d2_report]<>' ' OR [d2_partform]<>' ' OR [d2_dcid]<>(0))))
GO
ALTER TABLE [dbo].[dmdgrp2] CHECK CONSTRAINT [CK_dmdgrp2]
GO
ALTER TABLE [dbo].[dmdngr]  WITH CHECK ADD  CONSTRAINT [CK_dmdngr] CHECK  (([dn_id]<>(0) AND [dn_name]<>'' AND [dn_regnum]<>''))
GO
ALTER TABLE [dbo].[dmdngr] CHECK CONSTRAINT [CK_dmdngr]
GO
ALTER TABLE [dbo].[dmdoccat]  WITH CHECK ADD  CONSTRAINT [CK_dmdoccat] CHECK  (([dc_id]<>(0) AND [dc_name]<>' '))
GO
ALTER TABLE [dbo].[dmdoccat] CHECK CONSTRAINT [CK_dmdoccat]
GO
ALTER TABLE [dbo].[dmdoccat2]  WITH CHECK ADD  CONSTRAINT [CK_dmdoccat2] CHECK  (([d2_id]<>(0) AND [d2_dcid]<>(0)))
GO
ALTER TABLE [dbo].[dmdoccat2] CHECK CONSTRAINT [CK_dmdoccat2]
GO
ALTER TABLE [dbo].[dmdock]  WITH CHECK ADD  CONSTRAINT [CK_dmdock] CHECK  (([do_id]<>(0) AND [do_name]<>'' AND ([do_waid]<>(0) OR [do_reid]<>(0)) AND [do_trantype]<>''))
GO
ALTER TABLE [dbo].[dmdock] CHECK CONSTRAINT [CK_dmdock]
GO
ALTER TABLE [dbo].[dmecommdoccat]  WITH CHECK ADD  CONSTRAINT [CK_dmecommdoccat] CHECK  (([ed_type]<>''))
GO
ALTER TABLE [dbo].[dmecommdoccat] CHECK CONSTRAINT [CK_dmecommdoccat]
GO
ALTER TABLE [dbo].[dmecommprod]  WITH CHECK ADD  CONSTRAINT [CK_dmecommprod] CHECK  (([ep_id]<>(0) AND [ep_name]<>' '))
GO
ALTER TABLE [dbo].[dmecommprod] CHECK CONSTRAINT [CK_dmecommprod]
GO
ALTER TABLE [dbo].[dmedi]  WITH CHECK ADD  CONSTRAINT [CK_dmedi] CHECK  (([ed_id]<>(0) AND [ed_name]<>' ' AND [ed_ordtype]<>' '))
GO
ALTER TABLE [dbo].[dmedi] CHECK CONSTRAINT [CK_dmedi]
GO
ALTER TABLE [dbo].[dmedi2]  WITH CHECK ADD  CONSTRAINT [CK_dmedi2] CHECK  (([e2_id]<>(0) AND [e2_fldname]<>' ' AND [e2_exprtype]<>' '))
GO
ALTER TABLE [dbo].[dmedi2] CHECK CONSTRAINT [CK_dmedi2]
GO
ALTER TABLE [dbo].[dmedi3]  WITH CHECK ADD  CONSTRAINT [CK_dmedi3] CHECK  (([e3_id]<>(0) AND [e3_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dmedi3] CHECK CONSTRAINT [CK_dmedi3]
GO
ALTER TABLE [dbo].[dmemail]  WITH CHECK ADD  CONSTRAINT [CK_dmemail] CHECK  (([em_id]<>(0) AND [em_name]<>' '))
GO
ALTER TABLE [dbo].[dmemail] CHECK CONSTRAINT [CK_dmemail]
GO
ALTER TABLE [dbo].[dmemail2]  WITH CHECK ADD  CONSTRAINT [CK_dmemail2] CHECK  (([e2_id]<>(0) AND [e2_emid]<>(0) AND [e2_piid]<>(0)))
GO
ALTER TABLE [dbo].[dmemail2] CHECK CONSTRAINT [CK_dmemail2]
GO
ALTER TABLE [dbo].[dmeng]  WITH CHECK ADD  CONSTRAINT [CK_dmeng] CHECK  (([en_id]<>(0) AND [en_name]<>' '))
GO
ALTER TABLE [dbo].[dmeng] CHECK CONSTRAINT [CK_dmeng]
GO
ALTER TABLE [dbo].[dmexai]  WITH CHECK ADD  CONSTRAINT [CK_dmexai] CHECK  (([ex_id]<>(0)))
GO
ALTER TABLE [dbo].[dmexai] CHECK CONSTRAINT [CK_dmexai]
GO
ALTER TABLE [dbo].[dmexcl]  WITH CHECK ADD  CONSTRAINT [CK_dmexcl] CHECK  (([ex_id]<>(0) AND [ex_name]<>' '))
GO
ALTER TABLE [dbo].[dmexcl] CHECK CONSTRAINT [CK_dmexcl]
GO
ALTER TABLE [dbo].[dmexcl2]  WITH CHECK ADD  CONSTRAINT [CK_dmexcl2] CHECK  (([e2_id]<>(0) AND [e2_prid]<>(0) AND [e2_exid]<>(0)))
GO
ALTER TABLE [dbo].[dmexcl2] CHECK CONSTRAINT [CK_dmexcl2]
GO
ALTER TABLE [dbo].[dmexpprof]  WITH CHECK ADD  CONSTRAINT [CK_dmexpprof] CHECK  (([ep_id]<>(0) AND [ep_name]<>' '))
GO
ALTER TABLE [dbo].[dmexpprof] CHECK CONSTRAINT [CK_dmexpprof]
GO
ALTER TABLE [dbo].[dmfactran]  WITH CHECK ADD  CONSTRAINT [CK_dmfactran] CHECK  (([ft_id]<>(0) AND [ft_waid1]<>(0) AND [ft_waid2]<>(0)))
GO
ALTER TABLE [dbo].[dmfactran] CHECK CONSTRAINT [CK_dmfactran]
GO
ALTER TABLE [dbo].[dmfcur]  WITH CHECK ADD  CONSTRAINT [CK_dmfcur] CHECK  (([fc_id]<>(0) AND [fc_name]<>' ' AND [fc_rate]<>(0) AND case len(ltrim(rtrim([fc_symbol]))) when (0) then (0) else (1) end<>(0) AND [fc_prtsay]<>' '))
GO
ALTER TABLE [dbo].[dmfcur] CHECK CONSTRAINT [CK_dmfcur]
GO
ALTER TABLE [dbo].[dmfcur2]  WITH CHECK ADD  CONSTRAINT [CK_dmfcur2] CHECK  (([f2_id]<>(0) AND [f2_fcid]<>(0) AND [f2_rate]<>(0)))
GO
ALTER TABLE [dbo].[dmfcur2] CHECK CONSTRAINT [CK_dmfcur2]
GO
ALTER TABLE [dbo].[dmfeat]  WITH CHECK ADD  CONSTRAINT [CK_dmfeat] CHECK  (([fe_id]<>(0) AND [fe_name]<>' '))
GO
ALTER TABLE [dbo].[dmfeat] CHECK CONSTRAINT [CK_dmfeat]
GO
ALTER TABLE [dbo].[dmfeat2]  WITH CHECK ADD  CONSTRAINT [CK_dmfeat2] CHECK  (([f2_id]<>(0) AND ([f2_child]<>(0) OR [f2_prid2]<>(0)) AND ([f2_parent]<>(0) OR [f2_prid]<>(0) OR [f2_caid]<>(0) OR [f2_c2id]<>(0))))
GO
ALTER TABLE [dbo].[dmfeat2] CHECK CONSTRAINT [CK_dmfeat2]
GO
ALTER TABLE [dbo].[dmfeat3]  WITH CHECK ADD  CONSTRAINT [CK_dmfeat3] CHECK  (([f3_id]<>(0) AND [f3_prid]<>(0) AND [f3_feid]<>(0)))
GO
ALTER TABLE [dbo].[dmfeat3] CHECK CONSTRAINT [CK_dmfeat3]
GO
ALTER TABLE [dbo].[dmfeat4]  WITH CHECK ADD  CONSTRAINT [CK_dmfeat4] CHECK  (([f4_id]<>(0) AND [f4_parent]<>(0) AND [f4_child]<>(0)))
GO
ALTER TABLE [dbo].[dmfeat4] CHECK CONSTRAINT [CK_dmfeat4]
GO
ALTER TABLE [dbo].[dmfeat5]  WITH CHECK ADD  CONSTRAINT [CK_dmfeat5] CHECK  (([f5_id]<>(0) AND [f5_feid]<>(0) AND [f5_feid2]<>(0) AND [f5_recid]<>(0) AND [f5_table]<>' '))
GO
ALTER TABLE [dbo].[dmfeat5] CHECK CONSTRAINT [CK_dmfeat5]
GO
ALTER TABLE [dbo].[dmfeat6]  WITH CHECK ADD  CONSTRAINT [CK_dmfeat6] CHECK  (([f6_id]<>(0) AND [f6_f2id]<>(0) AND [f6_avail]<>''))
GO
ALTER TABLE [dbo].[dmfeat6] CHECK CONSTRAINT [CK_dmfeat6]
GO
ALTER TABLE [dbo].[dmfilt]  WITH CHECK ADD  CONSTRAINT [CK_dmfilt] CHECK  (([fi_id]<>(0) AND [fi_name]<>' ' AND [fi_layout]<>' '))
GO
ALTER TABLE [dbo].[dmfilt] CHECK CONSTRAINT [CK_dmfilt]
GO
ALTER TABLE [dbo].[dmfilt2]  WITH CHECK ADD  CONSTRAINT [CK_dmfilt2] CHECK  (([f2_id]<>(0) AND [f2_field]<>' '))
GO
ALTER TABLE [dbo].[dmfilt2] CHECK CONSTRAINT [CK_dmfilt2]
GO
ALTER TABLE [dbo].[dmfiltsort]  WITH CHECK ADD  CONSTRAINT [CK_dmfiltsort] CHECK  (([fs_fiid]<>(0) AND [fs_field]<>'' AND [fs_order]<>''))
GO
ALTER TABLE [dbo].[dmfiltsort] CHECK CONSTRAINT [CK_dmfiltsort]
GO
ALTER TABLE [dbo].[dmfin]  WITH CHECK ADD  CONSTRAINT [CK_dmfin] CHECK  (([fi_id]<>(0) AND [fi_name]<>' ' AND [fi_type]<>' ' AND [fi_fgid]<>(0)))
GO
ALTER TABLE [dbo].[dmfin] CHECK CONSTRAINT [CK_dmfin]
GO
ALTER TABLE [dbo].[dmfin2]  WITH CHECK ADD  CONSTRAINT [CK_dmfin2] CHECK  (([f2_id]<>(0) AND [f2_title]<>' '))
GO
ALTER TABLE [dbo].[dmfin2] CHECK CONSTRAINT [CK_dmfin2]
GO
ALTER TABLE [dbo].[dmfingrp]  WITH CHECK ADD  CONSTRAINT [CK_dmfingrp] CHECK  (([fg_id]<>(0) AND [fg_name]<>' '))
GO
ALTER TABLE [dbo].[dmfingrp] CHECK CONSTRAINT [CK_dmfingrp]
GO
ALTER TABLE [dbo].[dmfingrp2]  WITH CHECK ADD  CONSTRAINT [CK_dmfingrp2] CHECK  (([f2_id]<>(0) AND [f2_fgid]<>(0)))
GO
ALTER TABLE [dbo].[dmfingrp2] CHECK CONSTRAINT [CK_dmfingrp2]
GO
ALTER TABLE [dbo].[dmforecast]  WITH CHECK ADD  CONSTRAINT [CK_dmforecast] CHECK  (([fo_id]<>(0) AND [fo_name]<>' ' AND [fo_usid]<>(0)))
GO
ALTER TABLE [dbo].[dmforecast] CHECK CONSTRAINT [CK_dmforecast]
GO
ALTER TABLE [dbo].[dmforecast2]  WITH CHECK ADD  CONSTRAINT [CK_dmforecast2] CHECK  (([f2_id]<>(0) AND [f2_foid]<>(0) AND [f2_prid]<>(0)))
GO
ALTER TABLE [dbo].[dmforecast2] CHECK CONSTRAINT [CK_dmforecast2]
GO
ALTER TABLE [dbo].[dmform]  WITH CHECK ADD  CONSTRAINT [CK_dmform] CHECK  (([fo_id]<>(0) AND [fo_name]<>' '))
GO
ALTER TABLE [dbo].[dmform] CHECK CONSTRAINT [CK_dmform]
GO
ALTER TABLE [dbo].[dmfrominv]  WITH CHECK ADD  CONSTRAINT [CK_dmfrominv] CHECK  (([fr_id]<>(0) AND [fr_prid]<>(0) AND [fr_type]<>' ' AND [fr_frominvprid]<>(0)))
GO
ALTER TABLE [dbo].[dmfrominv] CHECK CONSTRAINT [CK_dmfrominv]
GO
ALTER TABLE [dbo].[dmfrt]  WITH CHECK ADD  CONSTRAINT [CK_dmfrt] CHECK  (([fr_id]<>(0) AND [fr_name]<>' ' AND [fr_arap]<>' '))
GO
ALTER TABLE [dbo].[dmfrt] CHECK CONSTRAINT [CK_dmfrt]
GO
ALTER TABLE [dbo].[dmgiftcard]  WITH CHECK ADD  CONSTRAINT [CK_dmgiftcard] CHECK  (([gc_id]<>(0) AND [gc_number]<>(0) AND [gc_created] IS NOT NULL))
GO
ALTER TABLE [dbo].[dmgiftcard] CHECK CONSTRAINT [CK_dmgiftcard]
GO
ALTER TABLE [dbo].[dmgraph]  WITH CHECK ADD  CONSTRAINT [CK_dmgraph] CHECK  (([gr_type]>=(0) AND [gr_sumfield]<>'' AND [gr_sortby]<>''))
GO
ALTER TABLE [dbo].[dmgraph] CHECK CONSTRAINT [CK_dmgraph]
GO
ALTER TABLE [dbo].[dmgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmgrp] CHECK  (([gr_id]<>(0) AND [gr_name]<>' '))
GO
ALTER TABLE [dbo].[dmgrp] CHECK CONSTRAINT [CK_dmgrp]
GO
ALTER TABLE [dbo].[dmimpgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmimpgrp] CHECK  (([ig_name]<>''))
GO
ALTER TABLE [dbo].[dmimpgrp] CHECK CONSTRAINT [CK_dmimpgrp]
GO
ALTER TABLE [dbo].[dmimpgrp2]  WITH CHECK ADD  CONSTRAINT [CK_dmimpgrp2] CHECK  (([g2_imid]<>(0) AND [g2_igid]<>(0)))
GO
ALTER TABLE [dbo].[dmimpgrp2] CHECK CONSTRAINT [CK_dmimpgrp2]
GO
ALTER TABLE [dbo].[dmimport]  WITH CHECK ADD  CONSTRAINT [CK_dmimport] CHECK  (([im_id]<>(0) AND [im_name]<>' '))
GO
ALTER TABLE [dbo].[dmimport] CHECK CONSTRAINT [CK_dmimport]
GO
ALTER TABLE [dbo].[dmimport2]  WITH CHECK ADD  CONSTRAINT [CK_dmimport2] CHECK  (([i2_id]<>(0) AND [i2_imid]<>(0) AND [i2_dstfld]<>' '))
GO
ALTER TABLE [dbo].[dmimport2] CHECK CONSTRAINT [CK_dmimport2]
GO
ALTER TABLE [dbo].[dmimport3]  WITH CHECK ADD  CONSTRAINT [CK_dmimport3] CHECK  (([i3_id]<>(0) AND [i3_imid]<>(0)))
GO
ALTER TABLE [dbo].[dmimport3] CHECK CONSTRAINT [CK_dmimport3]
GO
ALTER TABLE [dbo].[dmimportsched]  WITH CHECK ADD  CONSTRAINT [CK_dmimportsched] CHECK  (([is_id]<>(0) AND [is_name]<>'' AND [is_day]<>(0) AND [is_schedtype]<>' ' AND [is_recid]<>(0) AND [is_seq]<>(0)))
GO
ALTER TABLE [dbo].[dmimportsched] CHECK CONSTRAINT [CK_dmimportsched]
GO
ALTER TABLE [dbo].[dmjcat]  WITH CHECK ADD  CONSTRAINT [CK_dmjcat] CHECK  (([jc_id]<>(0) AND [jc_name]<>' '))
GO
ALTER TABLE [dbo].[dmjcat] CHECK CONSTRAINT [CK_dmjcat]
GO
ALTER TABLE [dbo].[dmlab]  WITH CHECK ADD  CONSTRAINT [CK_dmlab] CHECK  (([la_id]<>(0) AND [la_name]<>' '))
GO
ALTER TABLE [dbo].[dmlab] CHECK CONSTRAINT [CK_dmlab]
GO
ALTER TABLE [dbo].[dmlabel]  WITH CHECK ADD  CONSTRAINT [CK_dmlabel] CHECK  (([la_id]<>(0) AND [la_rdid]<>(0) AND [la_type]<>' '))
GO
ALTER TABLE [dbo].[dmlabel] CHECK CONSTRAINT [CK_dmlabel]
GO
ALTER TABLE [dbo].[dmlatlng]  WITH CHECK ADD  CONSTRAINT [CK_dmlatlng] CHECK  (([ll_id]<>(0) AND [ll_address]<>''))
GO
ALTER TABLE [dbo].[dmlatlng] CHECK CONSTRAINT [CK_dmlatlng]
GO
ALTER TABLE [dbo].[dmletter]  WITH CHECK ADD  CONSTRAINT [CK_dmletter] CHECK  (([le_id]<>(0) AND [le_name]<>' ' AND [le_table]<>' '))
GO
ALTER TABLE [dbo].[dmletter] CHECK CONSTRAINT [CK_dmletter]
GO
ALTER TABLE [dbo].[dmloc]  WITH CHECK ADD  CONSTRAINT [CK_dmloc] CHECK  (([lo_id]<>(0) AND [lo_ltid]<>(0) AND [lo_name]<>' '))
GO
ALTER TABLE [dbo].[dmloc] CHECK CONSTRAINT [CK_dmloc]
GO
ALTER TABLE [dbo].[dmlocsort]  WITH CHECK ADD  CONSTRAINT [CK_dmlocsort] CHECK  (([ls_loid]<>(0) AND [ls_pyid]<>(0) AND [ls_seq]>(0)))
GO
ALTER TABLE [dbo].[dmlocsort] CHECK CONSTRAINT [CK_dmlocsort]
GO
ALTER TABLE [dbo].[dmloctype]  WITH CHECK ADD  CONSTRAINT [CK_dmloctype] CHECK  (([lt_id]<>(0) AND [lt_name]<>' ' AND [lt_waid]<>(0)))
GO
ALTER TABLE [dbo].[dmloctype] CHECK CONSTRAINT [CK_dmloctype]
GO
ALTER TABLE [dbo].[dmmarkets]  WITH CHECK ADD  CONSTRAINT [CK_dmmarkets] CHECK  (([ma_id]<>(0) AND [ma_name]<>' '))
GO
ALTER TABLE [dbo].[dmmarkets] CHECK CONSTRAINT [CK_dmmarkets]
GO
ALTER TABLE [dbo].[dmmarketsubs]  WITH CHECK ADD  CONSTRAINT [CK_dmmarketsubs] CHECK  (([ms_id]<>(0) AND [ms_maid]<>(0) AND [ms_name]<>' '))
GO
ALTER TABLE [dbo].[dmmarketsubs] CHECK CONSTRAINT [CK_dmmarketsubs]
GO
ALTER TABLE [dbo].[dmmrogrp]  WITH CHECK ADD  CONSTRAINT [CK_dmmrogrp] CHECK  (([mg_id]<>(0) AND [mg_name]<>' '))
GO
ALTER TABLE [dbo].[dmmrogrp] CHECK CONSTRAINT [CK_dmmrogrp]
GO
ALTER TABLE [dbo].[dmmrpgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmmrpgrp] CHECK  (([mg_id]<>(0) AND [mg_name]<>' '))
GO
ALTER TABLE [dbo].[dmmrpgrp] CHECK CONSTRAINT [CK_dmmrpgrp]
GO
ALTER TABLE [dbo].[dmnote]  WITH CHECK ADD  CONSTRAINT [CK_dmnote] CHECK  (([no_id]<>(0) AND [no_name]<>' '))
GO
ALTER TABLE [dbo].[dmnote] CHECK CONSTRAINT [CK_dmnote]
GO
ALTER TABLE [dbo].[dmop]  WITH CHECK ADD  CONSTRAINT [CK_dmop] CHECK  (([op_id]<>(0) AND [op_name]<>' ' AND [op_chid]<>(0)))
GO
ALTER TABLE [dbo].[dmop] CHECK CONSTRAINT [CK_dmop]
GO
ALTER TABLE [dbo].[dmover]  WITH CHECK ADD  CONSTRAINT [CK_dmover] CHECK  (([ov_id]<>(0) AND [ov_table]<>' ' AND [ov_recid]<>(0) AND [ov_pos]<>(0)))
GO
ALTER TABLE [dbo].[dmover] CHECK CONSTRAINT [CK_dmover]
GO
ALTER TABLE [dbo].[dmpayevent]  WITH CHECK ADD  CONSTRAINT [CK_dmpayevent] CHECK  (([pe_id]<>(0) AND [pe_name]<>' '))
GO
ALTER TABLE [dbo].[dmpayevent] CHECK CONSTRAINT [CK_dmpayevent]
GO
ALTER TABLE [dbo].[dmpcat]  WITH CHECK ADD  CONSTRAINT [CK_dmpcat] CHECK  (([pc_id]<>(0) AND [pc_name]<>' '))
GO
ALTER TABLE [dbo].[dmpcat] CHECK CONSTRAINT [CK_dmpcat]
GO
ALTER TABLE [dbo].[dmper]  WITH CHECK ADD  CONSTRAINT [CK_dmper] CHECK  (([pe_id]<>(0) AND [pe_name]<>' '))
GO
ALTER TABLE [dbo].[dmper] CHECK CONSTRAINT [CK_dmper]
GO
ALTER TABLE [dbo].[dmper2]  WITH CHECK ADD  CONSTRAINT [CK_dmper2] CHECK  (([p2_id]<>(0) AND [p2_name]<>' ' AND [p2_start] IS NOT NULL AND [p2_end] IS NOT NULL AND [p2_quarter]<>(0)))
GO
ALTER TABLE [dbo].[dmper2] CHECK CONSTRAINT [CK_dmper2]
GO
ALTER TABLE [dbo].[dmpergrp]  WITH CHECK ADD  CONSTRAINT [CK_dmpergrp] CHECK  (([pg_id]<>(0) AND [pg_name]<>' '))
GO
ALTER TABLE [dbo].[dmpergrp] CHECK CONSTRAINT [CK_dmpergrp]
GO
ALTER TABLE [dbo].[dmphas]  WITH CHECK ADD  CONSTRAINT [CK_dmphas] CHECK  (([ph_id]<>(0) AND [ph_name]<>' '))
GO
ALTER TABLE [dbo].[dmphas] CHECK CONSTRAINT [CK_dmphas]
GO
ALTER TABLE [dbo].[dmpo1]  WITH CHECK ADD  CONSTRAINT [CK_dmpo1] CHECK  (([p1_id]<>(0) AND [p1_name]<>' '))
GO
ALTER TABLE [dbo].[dmpo1] CHECK CONSTRAINT [CK_dmpo1]
GO
ALTER TABLE [dbo].[dmpo2]  WITH CHECK ADD  CONSTRAINT [CK_dmpo2] CHECK  (([p2_id]<>(0) AND [p2_name]<>' '))
GO
ALTER TABLE [dbo].[dmpo2] CHECK CONSTRAINT [CK_dmpo2]
GO
ALTER TABLE [dbo].[dmpos]  WITH CHECK ADD  CONSTRAINT [CK_dmpos] CHECK  (([po_id]<>(0) AND [po_mask]<>(0) AND [po_number]<>(0) AND [po_name]<>' '))
GO
ALTER TABLE [dbo].[dmpos] CHECK CONSTRAINT [CK_dmpos]
GO
ALTER TABLE [dbo].[dmposbutton]  WITH CHECK ADD  CONSTRAINT [CK_dmposbutton] CHECK  (([pb_id]<>(0) AND [pb_function]<>''))
GO
ALTER TABLE [dbo].[dmposbutton] CHECK CONSTRAINT [CK_dmposbutton]
GO
ALTER TABLE [dbo].[dmposname]  WITH CHECK ADD  CONSTRAINT [CK_dmposname] CHECK  (([pn_poid]<>(0) AND [pn_name]<>'' AND [pn_value]>=(0)))
GO
ALTER TABLE [dbo].[dmposname] CHECK CONSTRAINT [CK_dmposname]
GO
ALTER TABLE [dbo].[dmposset]  WITH CHECK ADD  CONSTRAINT [CK_dmposset] CHECK  (([ps_id]<>(0) AND [ps_mac]<>'' AND [ps_securedevice]<>'' AND [ps_listenerport]<>(0)))
GO
ALTER TABLE [dbo].[dmposset] CHECK CONSTRAINT [CK_dmposset]
GO
ALTER TABLE [dbo].[dmpr1]  WITH CHECK ADD  CONSTRAINT [CK_dmpr1] CHECK  (([p1_id]<>(0) AND [p1_name]<>' '))
GO
ALTER TABLE [dbo].[dmpr1] CHECK CONSTRAINT [CK_dmpr1]
GO
ALTER TABLE [dbo].[dmpr2]  WITH CHECK ADD  CONSTRAINT [CK_dmpr2] CHECK  (([p2_id]<>(0) AND [p2_name]<>' '))
GO
ALTER TABLE [dbo].[dmpr2] CHECK CONSTRAINT [CK_dmpr2]
GO
ALTER TABLE [dbo].[dmpr3]  WITH CHECK ADD  CONSTRAINT [CK_dmpr3] CHECK  (([p3_id]<>(0) AND [p3_name]<>' '))
GO
ALTER TABLE [dbo].[dmpr3] CHECK CONSTRAINT [CK_dmpr3]
GO
ALTER TABLE [dbo].[dmpr4]  WITH CHECK ADD  CONSTRAINT [CK_dmpr4] CHECK  (([p4_id]<>(0) AND [p4_name]<>' '))
GO
ALTER TABLE [dbo].[dmpr4] CHECK CONSTRAINT [CK_dmpr4]
GO
ALTER TABLE [dbo].[dmpr5]  WITH CHECK ADD  CONSTRAINT [CK_dmpr5] CHECK  (([p5_id]<>(0) AND [p5_name]<>' '))
GO
ALTER TABLE [dbo].[dmpr5] CHECK CONSTRAINT [CK_dmpr5]
GO
ALTER TABLE [dbo].[dmpref]  WITH CHECK ADD  CONSTRAINT [CK_dmpref] CHECK  (([pr_id]<>(0) AND [pr_name]<>' '))
GO
ALTER TABLE [dbo].[dmpref] CHECK CONSTRAINT [CK_dmpref]
GO
ALTER TABLE [dbo].[dmpref2]  WITH CHECK ADD  CONSTRAINT [CK_dmpref2] CHECK  (([p2_id]<>(0) AND [p2_field]<>' '))
GO
ALTER TABLE [dbo].[dmpref2] CHECK CONSTRAINT [CK_dmpref2]
GO
ALTER TABLE [dbo].[dmprod]  WITH CHECK ADD  CONSTRAINT [CK_dmprod] CHECK  (([pr_id]<>(0) AND [pr_codenum]<>' ' AND [pr_descrip]<>' ' AND [pr_retail]<>' ' AND [pr_buid]<>(0) AND [pr_caid]<>(0) AND [pr_unid]<>(0) AND [pr_countunid]<>(0) AND [pr_purunid]<>(0) AND [pr_prunid]<>(0) AND [pr_salunid]<>(0) AND [pr_user5]<>(0) AND [pr_user6]<>(0) AND [pr_user7]<>(0) AND [pr_user8]<>(0) AND [pr_user9]<>(0) AND [pr_neginv]<>' ' AND [pr_purtype]<>' ' AND [pr_abc]<>' ' AND [pr_level]<>(0) AND [pr_ordtype]<>' ' AND [pr_issueunderlimit]>(-1)))
GO
ALTER TABLE [dbo].[dmprod] CHECK CONSTRAINT [CK_dmprod]
GO
ALTER TABLE [dbo].[dmprod2]  WITH CHECK ADD  CONSTRAINT [CK_dmprod2] CHECK  (([p2_id]<>(0) AND [p2_veid]<>(0) AND [p2_prunid]<>(0) AND [p2_vndunid]<>(0) AND [p2_vndcode]<>' ' AND [p2_vnddesc]<>' ' AND [p2_retail]<>' '))
GO
ALTER TABLE [dbo].[dmprod2] CHECK CONSTRAINT [CK_dmprod2]
GO
ALTER TABLE [dbo].[dmprod3]  WITH CHECK ADD  CONSTRAINT [CK_dmprod3] CHECK  (([p3_id]<>(0) AND [p3_prid]<>(0) AND [p3_waid]<>(0)))
GO
ALTER TABLE [dbo].[dmprod3] CHECK CONSTRAINT [CK_dmprod3]
GO
ALTER TABLE [dbo].[dmprod4]  WITH CHECK ADD  CONSTRAINT [CK_dmprod4] CHECK  (([p4_id]<>(0) AND [p4_prid]<>(0) AND [p4_codenum]<>''))
GO
ALTER TABLE [dbo].[dmprod4] CHECK CONSTRAINT [CK_dmprod4]
GO
ALTER TABLE [dbo].[dmprod5]  WITH CHECK ADD  CONSTRAINT [CK_dmprod5] CHECK  (([p5_id]<>(0) AND [p5_prid]<>(0) AND [p5_veid]<>(0)))
GO
ALTER TABLE [dbo].[dmprod5] CHECK CONSTRAINT [CK_dmprod5]
GO
ALTER TABLE [dbo].[dmprog]  WITH CHECK ADD  CONSTRAINT [CK_dmprog] CHECK  (([pg_id]<>(0) AND [pg_prognum]<>(0) AND [pg_pcid]<>(0) AND [pg_date] IS NOT NULL AND [pg_biid]<>(0) AND [pg_shid]<>(0) AND [pg_teid]<>(0) AND [pg_waid]<>(0) AND [pg_fcid]<>(0) AND [pg_fcrate]<>(0)))
GO
ALTER TABLE [dbo].[dmprog] CHECK CONSTRAINT [CK_dmprog]
GO
ALTER TABLE [dbo].[dmprog2]  WITH CHECK ADD  CONSTRAINT [CK_dmprog2] CHECK  (([p2_id]<>(0) AND [p2_prid]<>(0) AND [p2_amount]<>(0) AND [p2_seq]<>(0) AND [p2_pjid]<>(0)))
GO
ALTER TABLE [dbo].[dmprog2] CHECK CONSTRAINT [CK_dmprog2]
GO
ALTER TABLE [dbo].[dmprojnotetype]  WITH CHECK ADD  CONSTRAINT [CK_dmprojnotetype] CHECK  (([pe_id]<>(0) AND [pe_name]<>''))
GO
ALTER TABLE [dbo].[dmprojnotetype] CHECK CONSTRAINT [CK_dmprojnotetype]
GO
ALTER TABLE [dbo].[dmpromo]  WITH CHECK ADD  CONSTRAINT [CK_dmpromo] CHECK  (([pm_id]<>(0) AND [pm_descrip]<>' ' AND [pm_for]<>' ' AND [pm_on]<>' ' AND [pm_type]<>' '))
GO
ALTER TABLE [dbo].[dmpromo] CHECK CONSTRAINT [CK_dmpromo]
GO
ALTER TABLE [dbo].[dmprt]  WITH CHECK ADD  CONSTRAINT [CK_dmprt] CHECK  (([pt_id]<>(0) AND [pt_name]<>' ' AND [pt_report]<>' '))
GO
ALTER TABLE [dbo].[dmprt] CHECK CONSTRAINT [CK_dmprt]
GO
ALTER TABLE [dbo].[dmprt2]  WITH CHECK ADD  CONSTRAINT [CK_dmprt2] CHECK  (([p2_id]<>(0) AND [p2_say]<>' '))
GO
ALTER TABLE [dbo].[dmprt2] CHECK CONSTRAINT [CK_dmprt2]
GO
ALTER TABLE [dbo].[dmprtdest]  WITH CHECK ADD  CONSTRAINT [CK_dmprtdest] CHECK  (([pd_name]<>' ' AND [pd_printer]<>' '))
GO
ALTER TABLE [dbo].[dmprtdest] CHECK CONSTRAINT [CK_dmprtdest]
GO
ALTER TABLE [dbo].[dmprtdestover]  WITH CHECK ADD  CONSTRAINT [CK_dmprtdestover] CHECK  (([po_pdid]<>(0) AND [po_table]<>' ' AND [po_recid]<>(0) AND [po_printer]<>' '))
GO
ALTER TABLE [dbo].[dmprtdestover] CHECK CONSTRAINT [CK_dmprtdestover]
GO
ALTER TABLE [dbo].[dmprtdsd]  WITH CHECK ADD  CONSTRAINT [CK_dmprtdsd] CHECK  (([pd_name]<>' ' AND [pd_reporttype]<>' '))
GO
ALTER TABLE [dbo].[dmprtdsd] CHECK CONSTRAINT [CK_dmprtdsd]
GO
ALTER TABLE [dbo].[dmprtsub]  WITH CHECK ADD  CONSTRAINT [CK_dmprtsub] CHECK  (([ps_id]<>(0) AND [ps_name]<>' '))
GO
ALTER TABLE [dbo].[dmprtsub] CHECK CONSTRAINT [CK_dmprtsub]
GO
ALTER TABLE [dbo].[dmprtsub2]  WITH CHECK ADD  CONSTRAINT [CK_dmprtsub2] CHECK  (([p2_id]<>(0) AND [p2_psid]<>(0) AND [p2_subtype]<>' '))
GO
ALTER TABLE [dbo].[dmprtsub2] CHECK CONSTRAINT [CK_dmprtsub2]
GO
ALTER TABLE [dbo].[dmpsize]  WITH CHECK ADD  CONSTRAINT [CK_dmpsize] CHECK  (([ps_id]<>(0) AND [ps_width]<>(0) AND [ps_height]<>(0) AND [ps_name]<>' '))
GO
ALTER TABLE [dbo].[dmpsize] CHECK CONSTRAINT [CK_dmpsize]
GO
ALTER TABLE [dbo].[dmputaway]  WITH CHECK ADD  CONSTRAINT [CK_dmputaway] CHECK  (([py_existinginv]<>'' AND [py_fortype]<>'' AND [py_lot]<>'' AND [py_qcstatus]<>'' AND [py_sort]<>'' AND [py_totype]<>''))
GO
ALTER TABLE [dbo].[dmputaway] CHECK CONSTRAINT [CK_dmputaway]
GO
ALTER TABLE [dbo].[dmqc]  WITH CHECK ADD  CONSTRAINT [CK_dmqc] CHECK  (([qc_id]<>(0) AND [qc_name]<>' ' AND [qc_status]<>' '))
GO
ALTER TABLE [dbo].[dmqc] CHECK CONSTRAINT [CK_dmqc]
GO
ALTER TABLE [dbo].[dmqc2]  WITH CHECK ADD  CONSTRAINT [CK_dmqc2] CHECK  (([q2_id]<>(0) AND [q2_seq]<>(0) AND [q2_q3id]<>(0)))
GO
ALTER TABLE [dbo].[dmqc2] CHECK CONSTRAINT [CK_dmqc2]
GO
ALTER TABLE [dbo].[dmqc3]  WITH CHECK ADD  CONSTRAINT [CK_dmqc3] CHECK  (([q3_id]<>(0) AND [q3_name]<>' '))
GO
ALTER TABLE [dbo].[dmqc3] CHECK CONSTRAINT [CK_dmqc3]
GO
ALTER TABLE [dbo].[dmqc6]  WITH CHECK ADD  CONSTRAINT [CK_dmqc6] CHECK  (([q6_id]<>(0) AND [q6_qcid]<>(0) AND [q6_freqtype]<>' ' AND [q6_table]<>' ' AND [q6_recid]<>(0)))
GO
ALTER TABLE [dbo].[dmqc6] CHECK CONSTRAINT [CK_dmqc6]
GO
ALTER TABLE [dbo].[dmqcgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmqcgrp] CHECK  (([qg_id]<>(0) AND [qg_name]<>' '))
GO
ALTER TABLE [dbo].[dmqcgrp] CHECK CONSTRAINT [CK_dmqcgrp]
GO
ALTER TABLE [dbo].[dmqcgrp2]  WITH CHECK ADD  CONSTRAINT [CK_dmqcgrp2] CHECK  (([q2_id]<>(0) AND [q2_qgid]<>(0)))
GO
ALTER TABLE [dbo].[dmqcgrp2] CHECK CONSTRAINT [CK_dmqcgrp2]
GO
ALTER TABLE [dbo].[dmquery]  WITH CHECK ADD  CONSTRAINT [CK_dmquery] CHECK  (([qu_id]<>(0) AND [qu_name]<>''))
GO
ALTER TABLE [dbo].[dmquery] CHECK CONSTRAINT [CK_dmquery]
GO
ALTER TABLE [dbo].[dmrdoc]  WITH CHECK ADD  CONSTRAINT [CK_dmrdoc] CHECK  (([rd_id]<>(0) AND [rd_name]<>' ' AND [rd_deftype]<>' '))
GO
ALTER TABLE [dbo].[dmrdoc] CHECK CONSTRAINT [CK_dmrdoc]
GO
ALTER TABLE [dbo].[dmrdoctag]  WITH CHECK ADD  CONSTRAINT [CK_dmrdoctag] CHECK  (([rt_id]<>(0) AND [rt_name]<>' ' AND [rt_basetag]<>' '))
GO
ALTER TABLE [dbo].[dmrdoctag] CHECK CONSTRAINT [CK_dmrdoctag]
GO
ALTER TABLE [dbo].[dmreas]  WITH CHECK ADD  CONSTRAINT [CK_dmreas] CHECK  (([re_id]<>(0) AND [re_name]<>' '))
GO
ALTER TABLE [dbo].[dmreas] CHECK CONSTRAINT [CK_dmreas]
GO
ALTER TABLE [dbo].[dmreg]  WITH CHECK ADD  CONSTRAINT [CK_dmreg] CHECK  (([re_id]<>(0) AND [re_name]<>' '))
GO
ALTER TABLE [dbo].[dmreg] CHECK CONSTRAINT [CK_dmreg]
GO
ALTER TABLE [dbo].[dmreggrp]  WITH CHECK ADD  CONSTRAINT [CK_dmreggrp] CHECK  (([rg_id]<>(0) AND [rg_name]<>' '))
GO
ALTER TABLE [dbo].[dmreggrp] CHECK CONSTRAINT [CK_dmreggrp]
GO
ALTER TABLE [dbo].[dmreggrp2]  WITH CHECK ADD  CONSTRAINT [CK_dmreggrp2] CHECK  (([r2_id]<>(0) AND [r2_rgid]<>(0) AND [r2_rdid]<>(0) AND [r2_report]<>' '))
GO
ALTER TABLE [dbo].[dmreggrp2] CHECK CONSTRAINT [CK_dmreggrp2]
GO
ALTER TABLE [dbo].[dmregister]  WITH CHECK ADD  CONSTRAINT [CK_dmregister] CHECK  (([rg_id]<>(0) AND [rg_name]<>'' AND [rg_waid]>(0)))
GO
ALTER TABLE [dbo].[dmregister] CHECK CONSTRAINT [CK_dmregister]
GO
ALTER TABLE [dbo].[dmregisterprinter]  WITH CHECK ADD  CONSTRAINT [CK_dmregisterprinter] CHECK  (([rp_id]<>(0)))
GO
ALTER TABLE [dbo].[dmregisterprinter] CHECK CONSTRAINT [CK_dmregisterprinter]
GO
ALTER TABLE [dbo].[dmregisterscale]  WITH CHECK ADD  CONSTRAINT [CK_dmregisterscale] CHECK  (([rs_id]<>(0)))
GO
ALTER TABLE [dbo].[dmregisterscale] CHECK CONSTRAINT [CK_dmregisterscale]
GO
ALTER TABLE [dbo].[dmreport]  WITH NOCHECK ADD  CONSTRAINT [CK_dmreport] CHECK  (([re_id]<>(0) AND [re_name]<>'' AND [re_type]<>'' AND [re_orient]<>''))
GO
ALTER TABLE [dbo].[dmreport] CHECK CONSTRAINT [CK_dmreport]
GO
ALTER TABLE [dbo].[dmreportband]  WITH NOCHECK ADD  CONSTRAINT [CK_dmreportband] CHECK  (([rb_id]<>(0) AND [rb_reid]<>(0) AND [rb_type]<>''))
GO
ALTER TABLE [dbo].[dmreportband] CHECK CONSTRAINT [CK_dmreportband]
GO
ALTER TABLE [dbo].[dmreportgrp]  WITH NOCHECK ADD  CONSTRAINT [CK_dmreportgrp] CHECK  (([rg_id]<>(0) AND [rg_level]<>(0) AND [rg_name]<>'' AND [rg_reid]<>(0)))
GO
ALTER TABLE [dbo].[dmreportgrp] CHECK CONSTRAINT [CK_dmreportgrp]
GO
ALTER TABLE [dbo].[dmreportobj]  WITH NOCHECK ADD  CONSTRAINT [CK_dmreportobj] CHECK  (([ro_id]<>(0) AND [ro_rbid]<>(0) AND [ro_class]<>''))
GO
ALTER TABLE [dbo].[dmreportobj] CHECK CONSTRAINT [CK_dmreportobj]
GO
ALTER TABLE [dbo].[dmreportorderby]  WITH NOCHECK ADD  CONSTRAINT [CK_dmreportorderby] CHECK  (([ry_id]<>(0) AND [ry_reid]<>(0) AND [ry_orderby]<>' ' AND [ry_seq]<>(0)))
GO
ALTER TABLE [dbo].[dmreportorderby] CHECK CONSTRAINT [CK_dmreportorderby]
GO
ALTER TABLE [dbo].[dmreportvar]  WITH NOCHECK ADD  CONSTRAINT [CK_dmreportvar] CHECK  (([rv_id]<>(0) AND [rv_reset]<>'' AND [rv_name]<>'' AND [rv_reid]<>(0)))
GO
ALTER TABLE [dbo].[dmreportvar] CHECK CONSTRAINT [CK_dmreportvar]
GO
ALTER TABLE [dbo].[dmretreas]  WITH CHECK ADD  CONSTRAINT [CK_dmretreas] CHECK  (([rt_id]<>(0) AND [rt_name]<>' ' AND [rt_moveto]<>' '))
GO
ALTER TABLE [dbo].[dmretreas] CHECK CONSTRAINT [CK_dmretreas]
GO
ALTER TABLE [dbo].[dmrev]  WITH CHECK ADD  CONSTRAINT [CK_dmrev] CHECK  (([re_id]<>(0) AND [re_name]<>' ' AND [re_prid]<>(0) AND [re_userid]<>(0) AND [re_date] IS NOT NULL AND [re_yield]<>(0) AND [re_foid]<>(0)))
GO
ALTER TABLE [dbo].[dmrev] CHECK CONSTRAINT [CK_dmrev]
GO
ALTER TABLE [dbo].[dmrev2]  WITH CHECK ADD  CONSTRAINT [CK_dmrev2] CHECK  (([r2_id]<>(0) AND [r2_reid]<>(0) AND [r2_prid]<>(0) AND [r2_unid]<>(0)))
GO
ALTER TABLE [dbo].[dmrev2] CHECK CONSTRAINT [CK_dmrev2]
GO
ALTER TABLE [dbo].[dmrevconstraint]  WITH CHECK ADD  CONSTRAINT [CK_dmrevconstraint] CHECK  (([rc_id]<>(0) AND [rc_reid]<>(0)))
GO
ALTER TABLE [dbo].[dmrevconstraint] CHECK CONSTRAINT [CK_dmrevconstraint]
GO
ALTER TABLE [dbo].[dmrnd]  WITH CHECK ADD  CONSTRAINT [CK_dmrnd] CHECK  (([rn_id]<>(0) AND [rn_downpt]<>(0) AND [rn_rndpt]<>(0)))
GO
ALTER TABLE [dbo].[dmrnd] CHECK CONSTRAINT [CK_dmrnd]
GO
ALTER TABLE [dbo].[dmrout]  WITH CHECK ADD  CONSTRAINT [CK_dmrout] CHECK  (([ro_id]<>(0) AND [ro_name]<>' '))
GO
ALTER TABLE [dbo].[dmrout] CHECK CONSTRAINT [CK_dmrout]
GO
ALTER TABLE [dbo].[dmrout2]  WITH CHECK ADD  CONSTRAINT [CK_dmrout2] CHECK  (([r2_id]<>(0) AND [r2_opid]<>(0) AND [r2_seq]<>(0)))
GO
ALTER TABLE [dbo].[dmrout2] CHECK CONSTRAINT [CK_dmrout2]
GO
ALTER TABLE [dbo].[dmrout2cent]  WITH CHECK ADD  CONSTRAINT [CK_dmrout2cent] CHECK  (([rc_id]<>(0) AND [rc_r2id]<>(0) AND [rc_ceid]<>(0) AND [rc_seq]<>(0)))
GO
ALTER TABLE [dbo].[dmrout2cent] CHECK CONSTRAINT [CK_dmrout2cent]
GO
ALTER TABLE [dbo].[dmrout3]  WITH CHECK ADD  CONSTRAINT [CK_dmrout3] CHECK  (([r3_id]<>(0) AND [r3_reid]<>(0) AND [r3_roid]<>(0)))
GO
ALTER TABLE [dbo].[dmrout3] CHECK CONSTRAINT [CK_dmrout3]
GO
ALTER TABLE [dbo].[dmrsellgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmrsellgrp] CHECK  (([rs_id]<>(0)))
GO
ALTER TABLE [dbo].[dmrsellgrp] CHECK CONSTRAINT [CK_dmrsellgrp]
GO
ALTER TABLE [dbo].[dmrsellprod]  WITH CHECK ADD  CONSTRAINT [CK_dmrsellprod] CHECK  (([rp_id]<>(0) AND [rp_rtid]<>(0) AND [rp_prid]<>(0)))
GO
ALTER TABLE [dbo].[dmrsellprod] CHECK CONSTRAINT [CK_dmrsellprod]
GO
ALTER TABLE [dbo].[dmrselltype]  WITH CHECK ADD  CONSTRAINT [CK_dmrselltype] CHECK  (([rt_id]<>(0) AND [rt_name]<>''))
GO
ALTER TABLE [dbo].[dmrselltype] CHECK CONSTRAINT [CK_dmrselltype]
GO
ALTER TABLE [dbo].[dmsalut]  WITH CHECK ADD  CONSTRAINT [CK_dmsalut] CHECK  (([sa_id]<>(0) AND [sa_name]<>' '))
GO
ALTER TABLE [dbo].[dmsalut] CHECK CONSTRAINT [CK_dmsalut]
GO
ALTER TABLE [dbo].[dmscalemodel]  WITH CHECK ADD  CONSTRAINT [CK_dmscalemodel] CHECK  (([sm_id]<>(0) AND [sm_name]<>' ' AND [sm_minwgt]>=(0) AND [sm_maxwgt]>=(0)))
GO
ALTER TABLE [dbo].[dmscalemodel] CHECK CONSTRAINT [CK_dmscalemodel]
GO
ALTER TABLE [dbo].[dmsched]  WITH CHECK ADD  CONSTRAINT [CK_dmsched] CHECK  (([sc_id]<>(0) AND [sc_type]<>' '))
GO
ALTER TABLE [dbo].[dmsched] CHECK CONSTRAINT [CK_dmsched]
GO
ALTER TABLE [dbo].[dmsched2]  WITH CHECK ADD  CONSTRAINT [CK_dmsched2] CHECK  (([s2_id]<>(0) AND [s2_scid]<>(0) AND [s2_dow]<>(0)))
GO
ALTER TABLE [dbo].[dmsched2] CHECK CONSTRAINT [CK_dmsched2]
GO
ALTER TABLE [dbo].[dmsched3]  WITH CHECK ADD  CONSTRAINT [CK_dmsched3] CHECK  (([s3_id]<>(0) AND [s3_type]<>' ' AND [s3_start] IS NOT NULL AND [s3_end] IS NOT NULL))
GO
ALTER TABLE [dbo].[dmsched3] CHECK CONSTRAINT [CK_dmsched3]
GO
ALTER TABLE [dbo].[dmschedrule]  WITH CHECK ADD  CONSTRAINT [CK_dmschedrule] CHECK  (([sr_id]<>(0) AND [sr_name]<>' '))
GO
ALTER TABLE [dbo].[dmschedrule] CHECK CONSTRAINT [CK_dmschedrule]
GO
ALTER TABLE [dbo].[dmschedrulesort]  WITH CHECK ADD  CONSTRAINT [CK_dmschedrulesort] CHECK  (([ss_id]<>(0) AND [ss_srid]<>(0) AND [ss_seq]<>(0) AND [ss_type]<>' '))
GO
ALTER TABLE [dbo].[dmschedrulesort] CHECK CONSTRAINT [CK_dmschedrulesort]
GO
ALTER TABLE [dbo].[dmsecquest]  WITH CHECK ADD  CONSTRAINT [CK_dmsecquest] CHECK  (([sq_id]<>(0) AND [sq_question]<>' '))
GO
ALTER TABLE [dbo].[dmsecquest] CHECK CONSTRAINT [CK_dmsecquest]
GO
ALTER TABLE [dbo].[dmsend]  WITH CHECK ADD  CONSTRAINT [CK_dmsend] CHECK  (([se_id]<>(0) AND [se_name]<>' '))
GO
ALTER TABLE [dbo].[dmsend] CHECK CONSTRAINT [CK_dmsend]
GO
ALTER TABLE [dbo].[dmseq1]  WITH CHECK ADD  CONSTRAINT [CK_dmseq1] CHECK  (([s1_id]<>(0) AND [s1_name]<>' ' AND [s1_seq]<>(0)))
GO
ALTER TABLE [dbo].[dmseq1] CHECK CONSTRAINT [CK_dmseq1]
GO
ALTER TABLE [dbo].[dmseq2]  WITH CHECK ADD  CONSTRAINT [CK_dmseq2] CHECK  (([s2_id]<>(0) AND [s2_name]<>' ' AND [s2_seq]<>(0)))
GO
ALTER TABLE [dbo].[dmseq2] CHECK CONSTRAINT [CK_dmseq2]
GO
ALTER TABLE [dbo].[dmsgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmsgrp] CHECK  (([sg_id]<>(0) AND [sg_name]<>' '))
GO
ALTER TABLE [dbo].[dmsgrp] CHECK CONSTRAINT [CK_dmsgrp]
GO
ALTER TABLE [dbo].[dmshift]  WITH CHECK ADD  CONSTRAINT [CK_dmshift] CHECK  (([sf_id]<>(0) AND [sf_name]<>' '))
GO
ALTER TABLE [dbo].[dmshift] CHECK CONSTRAINT [CK_dmshift]
GO
ALTER TABLE [dbo].[dmship]  WITH CHECK ADD  CONSTRAINT [CK_dmship] CHECK  (([sh_id]<>(0) AND [sh_name]<>' '))
GO
ALTER TABLE [dbo].[dmship] CHECK CONSTRAINT [CK_dmship]
GO
ALTER TABLE [dbo].[dmshipacc]  WITH CHECK ADD  CONSTRAINT [CK_dmshipacc] CHECK  (([sa_id]<>(0) AND ([sa_shid]<>(0) OR [sa_biid]<>(0)) AND [sa_trid]<>(0) AND [sa_name]<>' ' AND [sa_account]<>' '))
GO
ALTER TABLE [dbo].[dmshipacc] CHECK CONSTRAINT [CK_dmshipacc]
GO
ALTER TABLE [dbo].[dmshipfacility]  WITH CHECK ADD  CONSTRAINT [CK_dmshipfacility] CHECK  (([sf_id]<>(0) AND [sf_shid]<>(0) AND [sf_waid]<>(0)))
GO
ALTER TABLE [dbo].[dmshipfacility] CHECK CONSTRAINT [CK_dmshipfacility]
GO
ALTER TABLE [dbo].[dmshop]  WITH CHECK ADD  CONSTRAINT [CK_dmshop] CHECK  (([sh_id]<>(0) AND [sh_name]<>' ' AND [sh_waid]<>(0)))
GO
ALTER TABLE [dbo].[dmshop] CHECK CONSTRAINT [CK_dmshop]
GO
ALTER TABLE [dbo].[dmshoploc]  WITH CHECK ADD  CONSTRAINT [CK_dmshoploc] CHECK  (([sl_id]<>(0) AND [sl_loid]<>(0) AND [sl_seq]<>(0) AND [sl_shid]<>(0)))
GO
ALTER TABLE [dbo].[dmshoploc] CHECK CONSTRAINT [CK_dmshoploc]
GO
ALTER TABLE [dbo].[dmsman]  WITH CHECK ADD  CONSTRAINT [CK_dmsman] CHECK  (([sm_id]<>(0) AND [sm_lname]<>' ' AND [sm_sgid]<>(0)))
GO
ALTER TABLE [dbo].[dmsman] CHECK CONSTRAINT [CK_dmsman]
GO
ALTER TABLE [dbo].[dmsman2]  WITH CHECK ADD  CONSTRAINT [CK_dmsman2] CHECK  (([s2_id]<>(0) AND [s2_smid]<>(0) AND [s2_table]<>' ' AND [s2_recid]<>(0)))
GO
ALTER TABLE [dbo].[dmsman2] CHECK CONSTRAINT [CK_dmsman2]
GO
ALTER TABLE [dbo].[dmsman2cat]  WITH CHECK ADD  CONSTRAINT [CK_dmsman2cat] CHECK  (([sc_name]<>''))
GO
ALTER TABLE [dbo].[dmsman2cat] CHECK CONSTRAINT [CK_dmsman2cat]
GO
ALTER TABLE [dbo].[dmso1]  WITH CHECK ADD  CONSTRAINT [CK_dmso1] CHECK  (([s1_id]<>(0) AND [s1_name]<>' '))
GO
ALTER TABLE [dbo].[dmso1] CHECK CONSTRAINT [CK_dmso1]
GO
ALTER TABLE [dbo].[dmso2]  WITH CHECK ADD  CONSTRAINT [CK_dmso2] CHECK  (([s2_id]<>(0) AND [s2_name]<>' '))
GO
ALTER TABLE [dbo].[dmso2] CHECK CONSTRAINT [CK_dmso2]
GO
ALTER TABLE [dbo].[dmso3]  WITH CHECK ADD  CONSTRAINT [CK_dmso3] CHECK  (([s3_id]<>(0) AND [s3_name]<>' '))
GO
ALTER TABLE [dbo].[dmso3] CHECK CONSTRAINT [CK_dmso3]
GO
ALTER TABLE [dbo].[dmso4]  WITH CHECK ADD  CONSTRAINT [CK_dmso4] CHECK  (([s4_id]<>(0) AND [s4_name]<>' '))
GO
ALTER TABLE [dbo].[dmso4] CHECK CONSTRAINT [CK_dmso4]
GO
ALTER TABLE [dbo].[dmso5]  WITH CHECK ADD  CONSTRAINT [CK_dmso5] CHECK  (([s5_id]<>(0) AND [s5_name]<>' '))
GO
ALTER TABLE [dbo].[dmso5] CHECK CONSTRAINT [CK_dmso5]
GO
ALTER TABLE [dbo].[dmstability]  WITH CHECK ADD  CONSTRAINT [CK_dmstability] CHECK  (([st_id]<>(0) AND [st_qcid]<>(0) AND [st_reid]<>(0)))
GO
ALTER TABLE [dbo].[dmstability] CHECK CONSTRAINT [CK_dmstability]
GO
ALTER TABLE [dbo].[dmsubs]  WITH CHECK ADD  CONSTRAINT [CK_dmsubs] CHECK  (([su_id]<>(0) AND [su_parent]<>(0) AND [su_child]<>(0) AND [su_quant]<>(0)))
GO
ALTER TABLE [dbo].[dmsubs] CHECK CONSTRAINT [CK_dmsubs]
GO
ALTER TABLE [dbo].[dmsvccontract]  WITH CHECK ADD  CONSTRAINT [CK_dmsvccontract] CHECK  (([sc_id]<>(0)))
GO
ALTER TABLE [dbo].[dmsvccontract] CHECK CONSTRAINT [CK_dmsvccontract]
GO
ALTER TABLE [dbo].[dmsvcitem]  WITH CHECK ADD  CONSTRAINT [CK_dmsvcitem] CHECK  (([si_id]<>(0)))
GO
ALTER TABLE [dbo].[dmsvcitem] CHECK CONSTRAINT [CK_dmsvcitem]
GO
ALTER TABLE [dbo].[dmsvclabor]  WITH CHECK ADD  CONSTRAINT [CK_dmsvclabor] CHECK  (([sl_id]<>(0)))
GO
ALTER TABLE [dbo].[dmsvclabor] CHECK CONSTRAINT [CK_dmsvclabor]
GO
ALTER TABLE [dbo].[dmtaskcat]  WITH CHECK ADD  CONSTRAINT [CK_dmtaskcat] CHECK  (([tc_id]<>(0) AND [tc_name]<>' '))
GO
ALTER TABLE [dbo].[dmtaskcat] CHECK CONSTRAINT [CK_dmtaskcat]
GO
ALTER TABLE [dbo].[dmtaskcatstat]  WITH CHECK ADD  CONSTRAINT [CK_dmtaskcatstat] CHECK  (([ts_id]<>(0) AND [ts_name]<>' '))
GO
ALTER TABLE [dbo].[dmtaskcatstat] CHECK CONSTRAINT [CK_dmtaskcatstat]
GO
ALTER TABLE [dbo].[dmtax]  WITH CHECK ADD  CONSTRAINT [CK_dmtax] CHECK  (([ta_id]<>(0) AND [ta_name]<>' ' AND [ta_type]<>' '))
GO
ALTER TABLE [dbo].[dmtax] CHECK CONSTRAINT [CK_dmtax]
GO
ALTER TABLE [dbo].[dmtaxlink]  WITH CHECK ADD  CONSTRAINT [CK_dmtaxlink] CHECK  (([tl_id]<>(0)))
GO
ALTER TABLE [dbo].[dmtaxlink] CHECK CONSTRAINT [CK_dmtaxlink]
GO
ALTER TABLE [dbo].[dmterm]  WITH CHECK ADD  CONSTRAINT [CK_dmterm] CHECK  (([te_id]<>(0)))
GO
ALTER TABLE [dbo].[dmterm] CHECK CONSTRAINT [CK_dmterm]
GO
ALTER TABLE [dbo].[dmterm2]  WITH CHECK ADD  CONSTRAINT [CK_dmterm2] CHECK  (([t2_id]<>(0) AND [t2_teid]<>(0) AND [t2_recid]<>(0) AND [t2_table]<>' '))
GO
ALTER TABLE [dbo].[dmterm2] CHECK CONSTRAINT [CK_dmterm2]
GO
ALTER TABLE [dbo].[dmterritory]  WITH CHECK ADD  CONSTRAINT [CK_dmterritory] CHECK  (([tt_id]<>(0) AND [tt_name]<>' '))
GO
ALTER TABLE [dbo].[dmterritory] CHECK CONSTRAINT [CK_dmterritory]
GO
ALTER TABLE [dbo].[dmterritorygrp]  WITH CHECK ADD  CONSTRAINT [CK_dmterritorygrp] CHECK  (([tg_id]<>(0) AND [tg_name]<>' '))
GO
ALTER TABLE [dbo].[dmterritorygrp] CHECK CONSTRAINT [CK_dmterritorygrp]
GO
ALTER TABLE [dbo].[dmterritorygrplink]  WITH CHECK ADD  CONSTRAINT [CK_dmterritorygrplink] CHECK  (([tl_id]<>(0) AND [tl_tgid]<>(0) AND [tl_ttid]<>(0)))
GO
ALTER TABLE [dbo].[dmterritorygrplink] CHECK CONSTRAINT [CK_dmterritorygrplink]
GO
ALTER TABLE [dbo].[dmtest]  WITH CHECK ADD  CONSTRAINT [CK_dmtest] CHECK  (([te_id]<>(0) AND [te_name]<>''))
GO
ALTER TABLE [dbo].[dmtest] CHECK CONSTRAINT [CK_dmtest]
GO
ALTER TABLE [dbo].[dmtestcat]  WITH CHECK ADD  CONSTRAINT [CK_dmtestcat] CHECK  (([tc_id]<>(0) AND [tc_name]<>''))
GO
ALTER TABLE [dbo].[dmtestcat] CHECK CONSTRAINT [CK_dmtestcat]
GO
ALTER TABLE [dbo].[dmtestcatsub]  WITH CHECK ADD  CONSTRAINT [CK_dmtestcatsub] CHECK  (([ts_id]<>(0) AND [ts_name]<>'' AND [ts_tcid]<>(0)))
GO
ALTER TABLE [dbo].[dmtestcatsub] CHECK CONSTRAINT [CK_dmtestcatsub]
GO
ALTER TABLE [dbo].[dmtgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmtgrp] CHECK  (([tg_id]<>(0) AND [tg_name]<>' '))
GO
ALTER TABLE [dbo].[dmtgrp] CHECK CONSTRAINT [CK_dmtgrp]
GO
ALTER TABLE [dbo].[dmtgrp2]  WITH CHECK ADD  CONSTRAINT [CK_dmtgrp2] CHECK  (([t2_id]<>(0) AND [t2_tgid]<>(0) AND [t2_shid]<>(0)))
GO
ALTER TABLE [dbo].[dmtgrp2] CHECK CONSTRAINT [CK_dmtgrp2]
GO
ALTER TABLE [dbo].[dmti1]  WITH CHECK ADD  CONSTRAINT [CK_dmti1] CHECK  (([t1_id]<>(0) AND [t1_name]<>' '))
GO
ALTER TABLE [dbo].[dmti1] CHECK CONSTRAINT [CK_dmti1]
GO
ALTER TABLE [dbo].[dmti2]  WITH CHECK ADD  CONSTRAINT [CK_dmti2] CHECK  (([t2_id]<>(0) AND [t2_name]<>' '))
GO
ALTER TABLE [dbo].[dmti2] CHECK CONSTRAINT [CK_dmti2]
GO
ALTER TABLE [dbo].[dmti3]  WITH CHECK ADD  CONSTRAINT [CK_dmti3] CHECK  (([t3_id]<>(0) AND [t3_name]<>' '))
GO
ALTER TABLE [dbo].[dmti3] CHECK CONSTRAINT [CK_dmti3]
GO
ALTER TABLE [dbo].[dmti4]  WITH CHECK ADD  CONSTRAINT [CK_dmti4] CHECK  (([t4_id]<>(0) AND [t4_name]<>' '))
GO
ALTER TABLE [dbo].[dmti4] CHECK CONSTRAINT [CK_dmti4]
GO
ALTER TABLE [dbo].[dmti5]  WITH CHECK ADD  CONSTRAINT [CK_dmti5] CHECK  (([t5_id]<>(0) AND [t5_name]<>' '))
GO
ALTER TABLE [dbo].[dmti5] CHECK CONSTRAINT [CK_dmti5]
GO
ALTER TABLE [dbo].[dmticknotetype]  WITH CHECK ADD  CONSTRAINT [CK_dmticknotetype] CHECK  (([te_id]<>(0) AND [te_name]<>' '))
GO
ALTER TABLE [dbo].[dmticknotetype] CHECK CONSTRAINT [CK_dmticknotetype]
GO
ALTER TABLE [dbo].[dmtruk]  WITH CHECK ADD  CONSTRAINT [CK_dmtruk] CHECK  (([tr_id]<>(0) AND [tr_name]<>' '))
GO
ALTER TABLE [dbo].[dmtruk] CHECK CONSTRAINT [CK_dmtruk]
GO
ALTER TABLE [dbo].[dmtrukauth]  WITH CHECK ADD  CONSTRAINT [CK_dmtrukauth] CHECK  (([ta_id]<>(0) AND [ta_shid]<>(0) AND [ta_trid]<>(0)))
GO
ALTER TABLE [dbo].[dmtrukauth] CHECK CONSTRAINT [CK_dmtrukauth]
GO
ALTER TABLE [dbo].[dmtrukfacility]  WITH CHECK ADD  CONSTRAINT [CK_dmtrukfacility] CHECK  (([tf_trid]<>(0) AND [tf_waid]<>(0) AND [tf_ordtype]<>' '))
GO
ALTER TABLE [dbo].[dmtrukfacility] CHECK CONSTRAINT [CK_dmtrukfacility]
GO
ALTER TABLE [dbo].[dmtrukpickdays]  WITH CHECK ADD  CONSTRAINT [CK_dmtrukpickdays] CHECK  (([td_id]<>(0) AND [td_trid]<>(0) AND [td_day]<>' '))
GO
ALTER TABLE [dbo].[dmtrukpickdays] CHECK CONSTRAINT [CK_dmtrukpickdays]
GO
ALTER TABLE [dbo].[dmunit]  WITH CHECK ADD  CONSTRAINT [CK_dmunit] CHECK  (([un_id]<>(0) AND [un_name]<>' ' AND [un_type]<>' ' AND [un_factor]<>(0)))
GO
ALTER TABLE [dbo].[dmunit] CHECK CONSTRAINT [CK_dmunit]
GO
ALTER TABLE [dbo].[dmunitmins]  WITH CHECK ADD  CONSTRAINT [CK_dmunitmins] CHECK  (([um_id]<>(0) AND [um_recid]<>(0) AND [um_table]<>'' AND [um_unid]<>(0)))
GO
ALTER TABLE [dbo].[dmunitmins] CHECK CONSTRAINT [CK_dmunitmins]
GO
ALTER TABLE [dbo].[dmurst]  WITH CHECK ADD  CONSTRAINT [CK_dmurst] CHECK  (([ur_id]<>(0) AND [ur_usid]<>(0)))
GO
ALTER TABLE [dbo].[dmurst] CHECK CONSTRAINT [CK_dmurst]
GO
ALTER TABLE [dbo].[dmuserlayout]  WITH CHECK ADD  CONSTRAINT [CK_dmuserlayout] CHECK  (([ul_id]<>(0) AND [ul_fortype]<>'' AND [ul_class]<>''))
GO
ALTER TABLE [dbo].[dmuserlayout] CHECK CONSTRAINT [CK_dmuserlayout]
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol]  WITH CHECK ADD  CONSTRAINT [CK_dmuserlayoutcontrol] CHECK  (([uc_id]<>(0) AND [uc_ulid]<>(0)))
GO
ALTER TABLE [dbo].[dmuserlayoutcontrol] CHECK CONSTRAINT [CK_dmuserlayoutcontrol]
GO
ALTER TABLE [dbo].[dmuserlayoutdeletion]  WITH CHECK ADD  CONSTRAINT [CK_dmuserlayoutdeletion] CHECK  (([ud_id]<>(0) AND [ud_ulid]<>(0) AND [ud_function]<>''))
GO
ALTER TABLE [dbo].[dmuserlayoutdeletion] CHECK CONSTRAINT [CK_dmuserlayoutdeletion]
GO
ALTER TABLE [dbo].[dmuserlayoutproperty]  WITH CHECK ADD  CONSTRAINT [CK_dmuserlayoutproperty] CHECK  (([up_id]<>(0) AND [up_ulid]<>(0) AND [up_property]<>''))
GO
ALTER TABLE [dbo].[dmuserlayoutproperty] CHECK CONSTRAINT [CK_dmuserlayoutproperty]
GO
ALTER TABLE [dbo].[dmuserprtdest]  WITH CHECK ADD  CONSTRAINT [CK_dmuserprtdest] CHECK  (([ud_printer]<>' ' AND [ud_usid]<>(0) AND [ud_pdid]<>(0)))
GO
ALTER TABLE [dbo].[dmuserprtdest] CHECK CONSTRAINT [CK_dmuserprtdest]
GO
ALTER TABLE [dbo].[dmvalid]  WITH CHECK ADD  CONSTRAINT [CK_dmvalid] CHECK  (([va_id]<>(0) AND [va_validnum]<>' '))
GO
ALTER TABLE [dbo].[dmvalid] CHECK CONSTRAINT [CK_dmvalid]
GO
ALTER TABLE [dbo].[dmvat]  WITH CHECK ADD  CONSTRAINT [CK_dmvat] CHECK  (([va_id]<>(0) AND [va_name]<>' ' AND [va_type]<>' ' AND [va_on]<>' '))
GO
ALTER TABLE [dbo].[dmvat] CHECK CONSTRAINT [CK_dmvat]
GO
ALTER TABLE [dbo].[dmvatrate]  WITH CHECK ADD  CONSTRAINT [CK_dmvatrate] CHECK  (([vr_id]<>(0) AND [vr_rate]<>(0) AND [vr_startdate] IS NOT NULL AND [vr_vaid]<>(0)))
GO
ALTER TABLE [dbo].[dmvatrate] CHECK CONSTRAINT [CK_dmvatrate]
GO
ALTER TABLE [dbo].[dmvehicle]  WITH CHECK ADD  CONSTRAINT [CK_dmvehicle] CHECK  (([vc_id]<>(0) AND [vc_vehicle]<>'' AND [vc_waid]<>(0)))
GO
ALTER TABLE [dbo].[dmvehicle] CHECK CONSTRAINT [CK_dmvehicle]
GO
ALTER TABLE [dbo].[dmvend]  WITH CHECK ADD  CONSTRAINT [CK_dmvend] CHECK  (([ve_id]<>(0) AND [ve_name]<>' ' AND [ve_teid]<>(0) AND [ve_trid]<>(0) AND [ve_p1id]<>(0) AND [ve_p2id]<>(0) AND [ve_frid]<>(0) AND [ve_potype]<>' ' AND [ve_fcid]<>(0)))
GO
ALTER TABLE [dbo].[dmvend] CHECK CONSTRAINT [CK_dmvend]
GO
ALTER TABLE [dbo].[dmvendfacility]  WITH CHECK ADD  CONSTRAINT [CK_dmvendfacility] CHECK  (([vf_id]<>(0) AND [vf_veid]<>(0) AND [vf_waid]<>(0)))
GO
ALTER TABLE [dbo].[dmvendfacility] CHECK CONSTRAINT [CK_dmvendfacility]
GO
ALTER TABLE [dbo].[dmvgrp]  WITH CHECK ADD  CONSTRAINT [CK_dmvgrp] CHECK  (([vg_id]<>(0) AND [vg_name]<>' '))
GO
ALTER TABLE [dbo].[dmvgrp] CHECK CONSTRAINT [CK_dmvgrp]
GO
ALTER TABLE [dbo].[dmware]  WITH CHECK ADD  CONSTRAINT [CK_dmware] CHECK  (([wa_id]<>(0) AND [wa_name]<>' '))
GO
ALTER TABLE [dbo].[dmware] CHECK CONSTRAINT [CK_dmware]
GO
ALTER TABLE [dbo].[dmware2]  WITH CHECK ADD  CONSTRAINT [CK_dmware2] CHECK  (([w2_id]<>(0) AND [w2_waid]<>(0)))
GO
ALTER TABLE [dbo].[dmware2] CHECK CONSTRAINT [CK_dmware2]
GO
ALTER TABLE [dbo].[dmware3]  WITH CHECK ADD  CONSTRAINT [CK_dmware3] CHECK  (([w3_id]<>(0) AND [w3_waid]<>(0) AND [w3_reid]<>(0)))
GO
ALTER TABLE [dbo].[dmware3] CHECK CONSTRAINT [CK_dmware3]
GO
ALTER TABLE [dbo].[dmwmslayout]  WITH CHECK ADD  CONSTRAINT [CK_dmwmslayout] CHECK  (([wm_id]<>(0) AND [wm_form]<>''))
GO
ALTER TABLE [dbo].[dmwmslayout] CHECK CONSTRAINT [CK_dmwmslayout]
GO
ALTER TABLE [dbo].[dmwork]  WITH CHECK ADD  CONSTRAINT [CK_dmwork] CHECK  (([wo_id]<>(0) AND [wo_lname]<>' ' AND [wo_laid]<>(0)))
GO
ALTER TABLE [dbo].[dmwork] CHECK CONSTRAINT [CK_dmwork]
GO
ALTER TABLE [dbo].[dmworkcert]  WITH CHECK ADD  CONSTRAINT [CK_dmworkcert] CHECK  (([wc_id]<>(0) AND [wc_opid]<>(0) AND [wc_woid]<>(0)))
GO
ALTER TABLE [dbo].[dmworkcert] CHECK CONSTRAINT [CK_dmworkcert]
GO
ALTER TABLE [dbo].[dmzip]  WITH CHECK ADD  CONSTRAINT [CK_dmzip] CHECK  (([zi_id]<>(0) AND [zi_zipcode]<>' '))
GO
ALTER TABLE [dbo].[dmzip] CHECK CONSTRAINT [CK_dmzip]
GO
ALTER TABLE [dbo].[dmzone]  WITH CHECK ADD  CONSTRAINT [CK_dmzone] CHECK  (([zo_id]<>(0) AND [zo_name]<>' '))
GO
ALTER TABLE [dbo].[dmzone] CHECK CONSTRAINT [CK_dmzone]
GO
ALTER TABLE [dbo].[dmzoneloc]  WITH CHECK ADD  CONSTRAINT [CK_dmzoneloc] CHECK  (([zl_id]<>(0) AND [zl_zoid]<>(0) AND [zl_loid]<>(0)))
GO
ALTER TABLE [dbo].[dmzoneloc] CHECK CONSTRAINT [CK_dmzoneloc]
GO
ALTER TABLE [dbo].[dtap]  WITH CHECK ADD  CONSTRAINT [CK_dtap] CHECK  (([ap_id]<>(0) AND [ap_chid]<>(0) AND [ap_purnum]<>(0)))
GO
ALTER TABLE [dbo].[dtap] CHECK CONSTRAINT [CK_dtap]
GO
ALTER TABLE [dbo].[dtautofinish]  WITH CHECK ADD  CONSTRAINT [CK_dtautofinish] CHECK  (([af_id]<>(0) AND [af_source]<>' ' AND [af_status]<(5) AND [af_arname]<>' '))
GO
ALTER TABLE [dbo].[dtautofinish] CHECK CONSTRAINT [CK_dtautofinish]
GO
ALTER TABLE [dbo].[dtautopallet]  WITH CHECK ADD  CONSTRAINT [CK_dtautopallet] CHECK  (([ap_id]<>(0) AND [ap_name]<>' ' AND [ap_arname]<>' ' AND [ap_source]<>' '))
GO
ALTER TABLE [dbo].[dtautopallet] CHECK CONSTRAINT [CK_dtautopallet]
GO
ALTER TABLE [dbo].[dtautorun]  WITH CHECK ADD  CONSTRAINT [CK_dtautorun] CHECK  (([ar_id]<>(0) AND [ar_source]<>' '))
GO
ALTER TABLE [dbo].[dtautorun] CHECK CONSTRAINT [CK_dtautorun]
GO
ALTER TABLE [dbo].[dtbom2]  WITH CHECK ADD  CONSTRAINT [CK_dtbom2] CHECK  (([b2_id]<>(0) AND [b2_prid]<>(0) AND [b2_unid]<>(0)))
GO
ALTER TABLE [dbo].[dtbom2] CHECK CONSTRAINT [CK_dtbom2]
GO
ALTER TABLE [dbo].[dtcalcs]  WITH CHECK ADD  CONSTRAINT [CK_dtcalcs] CHECK  (([cs_id]<>(0) AND [cs_caid]<>(0) AND [cs_recid]<>(0)))
GO
ALTER TABLE [dbo].[dtcalcs] CHECK CONSTRAINT [CK_dtcalcs]
GO
ALTER TABLE [dbo].[dtcash]  WITH CHECK ADD  CONSTRAINT [CK_dtcash] CHECK  (([ca_id]<>(0) AND [ca_arap]<>' ' AND [ca_c3id]<>(0) AND [ca_check]<>' ' AND [ca_chid]<>(0) AND ([ca_compnum]<>(0) OR [ca_vgid]<>(0)) AND [ca_date] IS NOT NULL AND [ca_postref]<>' ' AND [ca_fcid]<>(0)))
GO
ALTER TABLE [dbo].[dtcash] CHECK CONSTRAINT [CK_dtcash]
GO
ALTER TABLE [dbo].[dtcash2]  WITH CHECK ADD  CONSTRAINT [CK_dtcash2] CHECK  (([c2_id]<>(0) AND [c2_chid]<>(0) AND [c2_ordnum]<>(0) AND [c2_postref]<>' ' AND [c2_type]<>' '))
GO
ALTER TABLE [dbo].[dtcash2] CHECK CONSTRAINT [CK_dtcash2]
GO
ALTER TABLE [dbo].[dtcheck]  WITH CHECK ADD  CONSTRAINT [CK_dtcheck] CHECK  (([ck_id]<>(0) AND [ck_chid]<>(0)))
GO
ALTER TABLE [dbo].[dtcheck] CHECK CONSTRAINT [CK_dtcheck]
GO
ALTER TABLE [dbo].[dtcinv]  WITH CHECK ADD  CONSTRAINT [CK_dtcinv] CHECK  (([ci_id]<>(0) AND [ci_shid]<>(0) AND [ci_prid]<>(0) AND [ci_ordnum]<>(0)))
GO
ALTER TABLE [dbo].[dtcinv] CHECK CONSTRAINT [CK_dtcinv]
GO
ALTER TABLE [dbo].[dtcontrecents]  WITH CHECK ADD  CONSTRAINT [CK_dtcontrecents] CHECK  (([re_id]<>(0) AND [re_coid]<>(0) AND [re_usid]<>(0)))
GO
ALTER TABLE [dbo].[dtcontrecents] CHECK CONSTRAINT [CK_dtcontrecents]
GO
ALTER TABLE [dbo].[dtcount]  WITH CHECK ADD  CONSTRAINT [CK_dtcount] CHECK  (([co_id]<>(0) AND [co_phid]<>(0) AND [co_name]<>' '))
GO
ALTER TABLE [dbo].[dtcount] CHECK CONSTRAINT [CK_dtcount]
GO
ALTER TABLE [dbo].[dtcount2]  WITH CHECK ADD  CONSTRAINT [CK_dtcount2] CHECK  (([c2_id]<>(0) AND [c2_coid]<>(0) AND [c2_prid]<>(0) AND [c2_quant]<>(0)))
GO
ALTER TABLE [dbo].[dtcount2] CHECK CONSTRAINT [CK_dtcount2]
GO
ALTER TABLE [dbo].[dtcrmproj]  WITH CHECK ADD  CONSTRAINT [CK_dtcrmproj] CHECK  (([cp_id]<>(0) AND [cp_ccid]<>(0) AND [cp_name]<>' ' AND [cp_status]<>' '))
GO
ALTER TABLE [dbo].[dtcrmproj] CHECK CONSTRAINT [CK_dtcrmproj]
GO
ALTER TABLE [dbo].[dtcrmprojmilestone]  WITH CHECK ADD  CONSTRAINT [CK_dtcrmprojmilestone] CHECK  (([mn_name]<>' '))
GO
ALTER TABLE [dbo].[dtcrmprojmilestone] CHECK CONSTRAINT [CK_dtcrmprojmilestone]
GO
ALTER TABLE [dbo].[dtcrmprojnote]  WITH CHECK ADD  CONSTRAINT [CK_dtcrmprojnote] CHECK  (([pn_id]<>(0) AND [pn_usid]<>(0) AND [pn_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dtcrmprojnote] CHECK CONSTRAINT [CK_dtcrmprojnote]
GO
ALTER TABLE [dbo].[dtcrmprojtask]  WITH CHECK ADD  CONSTRAINT [CK_dtcrmprojtask] CHECK  (([pt_id]<>(0) AND [pt_name]<>' '))
GO
ALTER TABLE [dbo].[dtcrmprojtask] CHECK CONSTRAINT [CK_dtcrmprojtask]
GO
ALTER TABLE [dbo].[dtcrmprojtick]  WITH CHECK ADD  CONSTRAINT [CK_dtcrmprojtick] CHECK  (([ct_id]<>(0) AND [ct_cpid]<>(0) AND [ct_tiid]<>(0)))
GO
ALTER TABLE [dbo].[dtcrmprojtick] CHECK CONSTRAINT [CK_dtcrmprojtick]
GO
ALTER TABLE [dbo].[dtd2]  WITH CHECK ADD  CONSTRAINT [CK_dtd2] CHECK  (([d2_id]<>(0) AND [d2_recid]<>(0)))
GO
ALTER TABLE [dbo].[dtd2] CHECK CONSTRAINT [CK_dtd2]
GO
ALTER TABLE [dbo].[dtemailcode]  WITH CHECK ADD  CONSTRAINT [CK_dtemailcode] CHECK  (([ec_id]<>(0) AND [ec_usid]<>(0) AND [ec_code]<>' ' AND [ec_start] IS NOT NULL AND [ec_end] IS NOT NULL))
GO
ALTER TABLE [dbo].[dtemailcode] CHECK CONSTRAINT [CK_dtemailcode]
GO
ALTER TABLE [dbo].[dteng]  WITH CHECK ADD  CONSTRAINT [CK_dteng] CHECK  (([in_id]<>(0) AND [in_toid]<>(0) AND [in_orid]<>(0)))
GO
ALTER TABLE [dbo].[dteng] CHECK CONSTRAINT [CK_dteng]
GO
ALTER TABLE [dbo].[dtfifo]  WITH CHECK ADD  CONSTRAINT [CK_dtfifo] CHECK  (([fi_id]<>(0) AND [fi_action]<>' ' AND [fi_chid]<>(0) AND [fi_date] IS NOT NULL AND [fi_group]<>(0) AND [fi_lotdate] IS NOT NULL AND [fi_lotnum]<>(0) AND [fi_postref]<>' ' AND [fi_prid]<>(0) AND [fi_quant]<>(0) AND [fi_userlot]<>' ' AND [fi_waid]<>(0) AND [fi_loid]<>(0)))
GO
ALTER TABLE [dbo].[dtfifo] CHECK CONSTRAINT [CK_dtfifo]
GO
ALTER TABLE [dbo].[dtfifo2]  WITH CHECK ADD  CONSTRAINT [CK_dtfifo2] CHECK  (([f2_id]<>(0) AND [f2_action]<>' ' AND [f2_date] IS NOT NULL AND [f2_fiid]<>(0) AND [f2_group]<>(0) AND [f2_postref]<>' ' AND [f2_prid]<>(0)))
GO
ALTER TABLE [dbo].[dtfifo2] CHECK CONSTRAINT [CK_dtfifo2]
GO
ALTER TABLE [dbo].[dtfifocust]  WITH CHECK ADD  CONSTRAINT [CK_dtfifocust] CHECK  (([fc_id]<>(0) AND [fc_table]<>' ' AND [fc_recid]<>(0) AND [fc_userlot]<>' '))
GO
ALTER TABLE [dbo].[dtfifocust] CHECK CONSTRAINT [CK_dtfifocust]
GO
ALTER TABLE [dbo].[dtfifoesig]  WITH CHECK ADD  CONSTRAINT [CK_dtfifoesig] CHECK  (([fe_id]<>(0) AND [fe_fiid]<>(0) AND [fe_date] IS NOT NULL AND [fe_allonum]<>(0)))
GO
ALTER TABLE [dbo].[dtfifoesig] CHECK CONSTRAINT [CK_dtfifoesig]
GO
ALTER TABLE [dbo].[dtfreightship]  WITH CHECK ADD  CONSTRAINT [CK_dtfreightship] CHECK  (([fs_id]<>(0) AND [fs_ordnum]<>(0)))
GO
ALTER TABLE [dbo].[dtfreightship] CHECK CONSTRAINT [CK_dtfreightship]
GO
ALTER TABLE [dbo].[dtfreightshipline]  WITH CHECK ADD  CONSTRAINT [CK_dtfreightshipline] CHECK  (([fl_fsid]<>(0) AND [fl_id]<>(0)))
GO
ALTER TABLE [dbo].[dtfreightshipline] CHECK CONSTRAINT [CK_dtfreightshipline]
GO
ALTER TABLE [dbo].[dtgl]  WITH CHECK ADD  CONSTRAINT [CK_dtgl] CHECK  (([gl_id]<>(0) AND [gl_action]<>' ' AND [gl_chid]<>(0) AND [gl_date] IS NOT NULL AND [gl_group]<>(0) AND [gl_postref]<>' ' AND [gl_usid]<>(0) AND [gl_fcid]<>(0) AND [gl_fcrate]<>(0)))
GO
ALTER TABLE [dbo].[dtgl] CHECK CONSTRAINT [CK_dtgl]
GO
ALTER TABLE [dbo].[dtjob]  WITH CHECK ADD  CONSTRAINT [CK_dtjob] CHECK  (([jo_id]<>(0) AND [jo_date] IS NOT NULL AND [jo_jcid]<>(0) AND [jo_jobnum]<>(0) AND [jo_type]<>' ' AND [jo_waid]<>(0)))
GO
ALTER TABLE [dbo].[dtjob] CHECK CONSTRAINT [CK_dtjob]
GO
ALTER TABLE [dbo].[dtjob2]  WITH CHECK ADD  CONSTRAINT [CK_dtjob2] CHECK  (([j2_id]<>(0)))
GO
ALTER TABLE [dbo].[dtjob2] CHECK CONSTRAINT [CK_dtjob2]
GO
ALTER TABLE [dbo].[dtjob3]  WITH CHECK ADD  CONSTRAINT [CK_dtjob3] CHECK  (([j3_id]<>(0) AND [j3_woid]<>(0) AND [j3_modd1] IS NOT NULL AND [j3_ceid]<>(0) AND [j3_opid]<>(0) AND [j3_ratefac]<>(0) AND [j3_source]<>' '))
GO
ALTER TABLE [dbo].[dtjob3] CHECK CONSTRAINT [CK_dtjob3]
GO
ALTER TABLE [dbo].[dtjob4]  WITH CHECK ADD  CONSTRAINT [CK_dtjob4] CHECK  (([j4_id]<>(0) AND [j4_date] IS NOT NULL AND [j4_jobnum]<>(0) AND [j4_ljid]<>(0) AND [j4_prid]<>(0) AND [j4_quant]<>(0)))
GO
ALTER TABLE [dbo].[dtjob4] CHECK CONSTRAINT [CK_dtjob4]
GO
ALTER TABLE [dbo].[dtjobsched]  WITH CHECK ADD  CONSTRAINT [CK_dtjobsched] CHECK  (([js_id]<>(0) AND [js_j2id]<>(0)))
GO
ALTER TABLE [dbo].[dtjobsched] CHECK CONSTRAINT [CK_dtjobsched]
GO
ALTER TABLE [dbo].[dtjour]  WITH CHECK ADD  CONSTRAINT [CK_dtjour] CHECK  (([jr_id]<>(0) AND [jr_action]<>' ' AND [jr_chid]<>(0) AND [jr_date] IS NOT NULL AND [jr_group]<>(0) AND [jr_postref]<>' ' AND [jr_usid]<>(0) AND [jr_fcid]<>(0) AND [jr_fcrate]<>(0)))
GO
ALTER TABLE [dbo].[dtjour] CHECK CONSTRAINT [CK_dtjour]
GO
ALTER TABLE [dbo].[dtljob]  WITH CHECK ADD  CONSTRAINT [CK_dtljob] CHECK  (([lj_id]<>(0) AND [lj_prid]<>(0) OR [lj_descrip]<>' '))
GO
ALTER TABLE [dbo].[dtljob] CHECK CONSTRAINT [CK_dtljob]
GO
ALTER TABLE [dbo].[dtlock]  WITH CHECK ADD  CONSTRAINT [CK_dtlock] CHECK  (([lk_table]<>'' AND [lk_usid]<>(0) AND [lk_recid]<>(0)))
GO
ALTER TABLE [dbo].[dtlock] CHECK CONSTRAINT [CK_dtlock]
GO
ALTER TABLE [dbo].[dtmasterlot]  WITH CHECK ADD  CONSTRAINT [CK_dtmasterlot] CHECK  (([ml_lot]<>' '))
GO
ALTER TABLE [dbo].[dtmasterlot] CHECK CONSTRAINT [CK_dtmasterlot]
GO
ALTER TABLE [dbo].[dtmovesched]  WITH CHECK ADD  CONSTRAINT [CK_dtmovesched] CHECK  (([ms_id]<>(0) AND [ms_quant]>(0) AND [ms_waid]<>(0) AND [ms_prid]<>(0)))
GO
ALTER TABLE [dbo].[dtmovesched] CHECK CONSTRAINT [CK_dtmovesched]
GO
ALTER TABLE [dbo].[dtord]  WITH CHECK ADD  CONSTRAINT [CK_dtord] CHECK  (([or_id]<>(0) AND [or_chid]<>(0) AND [or_linenum]<>(0) AND [or_ordnum]<>(0) AND [or_toid]<>(0) AND [or_prfact]<>(0) AND [or_prictyp]<>' ' AND ([or_taid]<>(0) OR [or_vaid]<>(0) OR ([or_stocked]=(0) OR [or_prid]<>(0)) OR ([or_taid]<>(0) OR [or_vaid]<>(0) OR [or_stocked]<>(0) AND [or_cogsid]<>(0) AND [or_prid]<>(0) AND [or_prunid]<>(0) AND [or_salunid]<>(0))) AND [or_salfact]<>(0)))
GO
ALTER TABLE [dbo].[dtord] CHECK CONSTRAINT [CK_dtord]
GO
ALTER TABLE [dbo].[dtord2]  WITH CHECK ADD  CONSTRAINT [CK_dtord2] CHECK  (([o2_id]<>(0) AND [o2_orid]<>(0)))
GO
ALTER TABLE [dbo].[dtord2] CHECK CONSTRAINT [CK_dtord2]
GO
ALTER TABLE [dbo].[dtpackage]  WITH CHECK ADD  CONSTRAINT [CK_dtpackage] CHECK  (([pa_id]<>(0)))
GO
ALTER TABLE [dbo].[dtpackage] CHECK CONSTRAINT [CK_dtpackage]
GO
ALTER TABLE [dbo].[dtpackageline]  WITH CHECK ADD  CONSTRAINT [CK_dtpackageline] CHECK  (([pl_id]<>(0) AND [pl_paid]<>(0) AND [pl_orid]<>(0)))
GO
ALTER TABLE [dbo].[dtpackageline] CHECK CONSTRAINT [CK_dtpackageline]
GO
ALTER TABLE [dbo].[dtpaysched]  WITH CHECK ADD  CONSTRAINT [CK_dtpaysched] CHECK  (([ps_id]<>(0) AND [ps_table]<>' ' AND [ps_recid]<>(0) AND [ps_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dtpaysched] CHECK CONSTRAINT [CK_dtpaysched]
GO
ALTER TABLE [dbo].[dtphys]  WITH CHECK ADD  CONSTRAINT [CK_dtphys] CHECK  (([ph_id]<>(0) AND [ph_name]<>' ' AND [ph_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dtphys] CHECK CONSTRAINT [CK_dtphys]
GO
ALTER TABLE [dbo].[dtphys2]  WITH CHECK ADD  CONSTRAINT [CK_dtphys2] CHECK  (([p2_id]<>(0) AND [p2_phid]<>(0) AND [p2_prid]<>(0)))
GO
ALTER TABLE [dbo].[dtphys2] CHECK CONSTRAINT [CK_dtphys2]
GO
ALTER TABLE [dbo].[dtprerecqc]  WITH CHECK ADD  CONSTRAINT [CK_dtprerecqc] CHECK  (([pq_id]<>(0) AND [pq_prid]<>(0) AND [pq_veid]<>(0) AND [pq_userlot]<>' '))
GO
ALTER TABLE [dbo].[dtprerecqc] CHECK CONSTRAINT [CK_dtprerecqc]
GO
ALTER TABLE [dbo].[dtprodreviews]  WITH CHECK ADD  CONSTRAINT [CK_dtprodreviews] CHECK  (([rv_id]<>(0) AND [rv_review]<>' ' AND [rv_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dtprodreviews] CHECK CONSTRAINT [CK_dtprodreviews]
GO
ALTER TABLE [dbo].[dtproj]  WITH CHECK ADD  CONSTRAINT [CK_dtproj] CHECK  (([pj_id]<>(0) AND [pj_projnum]<>(0) AND [pj_name]<>' ' AND [pj_created] IS NOT NULL))
GO
ALTER TABLE [dbo].[dtproj] CHECK CONSTRAINT [CK_dtproj]
GO
ALTER TABLE [dbo].[dtpur]  WITH CHECK ADD  CONSTRAINT [CK_dtpur] CHECK  (([pu_id]<>(0) AND ([pu_ourcode]<>' ' OR [pu_vnddesc]<>' ') AND [pu_chid]<>(0) AND [pu_quant]<>(0) AND [pu_linenum]<>(0) AND [pu_ordman]<>(0) AND [pu_purnum]<>(0) AND [pu_prfact]<>(0)))
GO
ALTER TABLE [dbo].[dtpur] CHECK CONSTRAINT [CK_dtpur]
GO
ALTER TABLE [dbo].[dtpur2]  WITH CHECK ADD  CONSTRAINT [CK_dtpur2] CHECK  (([p2_fiid]<>(0) AND [p2_puid]<>(0) AND [p2_id]<>(0)))
GO
ALTER TABLE [dbo].[dtpur2] CHECK CONSTRAINT [CK_dtpur2]
GO
ALTER TABLE [dbo].[dtqc4]  WITH CHECK ADD  CONSTRAINT [CK_dtqc4] CHECK  (([q4_id]<>(0) AND [q4_q2id]<>(0) AND [q4_table]<>' ' AND [q4_group]<>(0)))
GO
ALTER TABLE [dbo].[dtqc4] CHECK CONSTRAINT [CK_dtqc4]
GO
ALTER TABLE [dbo].[dtqc5]  WITH CHECK ADD  CONSTRAINT [CK_dtqc5] CHECK  (([q5_id]<>(0) AND [q5_table]<>' ' AND [q5_usid]<>(0) AND [q5_date] IS NOT NULL AND [q5_time]<>' ' AND [q5_action]<>' '))
GO
ALTER TABLE [dbo].[dtqc5] CHECK CONSTRAINT [CK_dtqc5]
GO
ALTER TABLE [dbo].[dtqcfreq]  WITH CHECK ADD  CONSTRAINT [CK_dtqcfreq] CHECK  (([qf_id]<>(0) AND [qf_date] IS NOT NULL AND [qf_linetable]<>'' AND [qf_lineid]<>(0) AND [qf_waid]<>(0)))
GO
ALTER TABLE [dbo].[dtqcfreq] CHECK CONSTRAINT [CK_dtqcfreq]
GO
ALTER TABLE [dbo].[dtqcfreqassgn]  WITH CHECK ADD  CONSTRAINT [CK_dtqcfreqassgn] CHECK  (([qa_id]<>(0) AND [qa_qfid]<>(0)))
GO
ALTER TABLE [dbo].[dtqcfreqassgn] CHECK CONSTRAINT [CK_dtqcfreqassgn]
GO
ALTER TABLE [dbo].[dtqclots]  WITH CHECK ADD  CONSTRAINT [CK_dtqclots] CHECK  (([ql_id]<>(0) AND ([ql_fiid]<>(0) OR [ql_ljid]<>(0) OR [ql_pqid]<>(0)) AND [ql_q4group]<>(0)))
GO
ALTER TABLE [dbo].[dtqclots] CHECK CONSTRAINT [CK_dtqclots]
GO
ALTER TABLE [dbo].[dtqcprerecpo]  WITH CHECK ADD  CONSTRAINT [CK_dtqcprerecpo] CHECK  (([qp_id]<>(0) AND [qp_pqid]<>(0) AND [qp_tpid]<>(0)))
GO
ALTER TABLE [dbo].[dtqcprerecpo] CHECK CONSTRAINT [CK_dtqcprerecpo]
GO
ALTER TABLE [dbo].[dtroute]  WITH CHECK ADD  CONSTRAINT [CK_dtroute] CHECK  (([ru_startdate] IS NOT NULL AND [ru_deviceid]<>'' AND [ru_usid]<>(0) AND [ru_loid]<>(0) AND [ru_trid]<>(0)))
GO
ALTER TABLE [dbo].[dtroute] CHECK CONSTRAINT [CK_dtroute]
GO
ALTER TABLE [dbo].[dtrss]  WITH CHECK ADD  CONSTRAINT [CK_dtrss] CHECK  (([rs_id]<>(0) AND [rs_coid]<>(0) AND [rs_descrip]<>' ' AND [rs_link]<>' ' AND [rs_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dtrss] CHECK CONSTRAINT [CK_dtrss]
GO
ALTER TABLE [dbo].[dtstaging]  WITH CHECK ADD  CONSTRAINT [CK_dtstaging] CHECK  (([st_id]<>(0) AND [st_figroup]<>(0) AND ([st_jobnum]<>(0) OR [st_ordnum]<>(0))))
GO
ALTER TABLE [dbo].[dtstaging] CHECK CONSTRAINT [CK_dtstaging]
GO
ALTER TABLE [dbo].[dttestresult]  WITH CHECK ADD  CONSTRAINT [CK_dttestresult] CHECK  (([tr_build]<>(0) AND [tr_id]<>(0) AND [tr_teid]<>(0)))
GO
ALTER TABLE [dbo].[dttestresult] CHECK CONSTRAINT [CK_dttestresult]
GO
ALTER TABLE [dbo].[dttick]  WITH CHECK ADD  CONSTRAINT [CK_dttick] CHECK  (([ti_id]<>(0) AND [ti_ticknum]<>(0) AND [ti_usid]<>(0) AND [ti_cdate] IS NOT NULL))
GO
ALTER TABLE [dbo].[dttick] CHECK CONSTRAINT [CK_dttick]
GO
ALTER TABLE [dbo].[dttickcont]  WITH CHECK ADD  CONSTRAINT [CK_dttickcont] CHECK  (([tt_id]<>(0) AND [tt_tiid]<>(0) AND [tt_coid]<>(0) AND [tt_cpid]<>(0)))
GO
ALTER TABLE [dbo].[dttickcont] CHECK CONSTRAINT [CK_dttickcont]
GO
ALTER TABLE [dbo].[dtticknote]  WITH CHECK ADD  CONSTRAINT [CK_dtticknote] CHECK  (([tn_id]<>(0) AND [tn_tiid]<>(0) AND [tn_usid]<>(0) AND [tn_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dtticknote] CHECK CONSTRAINT [CK_dtticknote]
GO
ALTER TABLE [dbo].[dttord]  WITH CHECK ADD  CONSTRAINT [CK_dttord] CHECK  (([to_id]<>(0) AND [to_ordnum]<>(0) AND [to_orddate] IS NOT NULL AND [to_teid]<>(0) AND [to_waid]<>(0) AND [to_ordtype]<>' ' AND [to_grid]<>(0) AND [to_brid]<>(0) AND [to_s1id]<>(0) AND [to_s2id]<>(0) AND [to_s3id]<>(0) AND [to_s4id]<>(0) AND [to_s5id]<>(0) AND [to_frid]<>(0) AND [to_trid]<>(0) AND [to_status]<>' ' AND [to_fcid]<>(0) AND [to_fcrate]<>(0) AND [to_biid]<>(0) AND [to_shid]<>(0)))
GO
ALTER TABLE [dbo].[dttord] CHECK CONSTRAINT [CK_dttord]
GO
ALTER TABLE [dbo].[dttpur]  WITH CHECK ADD  CONSTRAINT [CK_dttpur] CHECK  (([tp_id]<>(0) AND [tp_purnum]<>(0) AND [tp_veid]<>(0) AND [tp_seid]<>(0) AND [tp_trid]<>(0) AND [tp_teid]<>(0) AND [tp_p1id]<>(0) AND [tp_p2id]<>(0) AND [tp_waid]<>(0) AND [tp_date] IS NOT NULL AND [tp_fcid]<>(0) AND [tp_fcrate]<>(0)))
GO
ALTER TABLE [dbo].[dttpur] CHECK CONSTRAINT [CK_dttpur]
GO
ALTER TABLE [dbo].[dttrak5]  WITH CHECK ADD  CONSTRAINT [CK_dttrak5] CHECK  (([t5_id]<>(0) AND [t5_recid]<>(0) AND [t5_usid]<>(0) AND [t5_table]<>'' AND [t5_time]<>'' AND [t5_action]<>'' AND [t5_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dttrak5] CHECK CONSTRAINT [CK_dttrak5]
GO
ALTER TABLE [dbo].[dttrigdel]  WITH CHECK ADD  CONSTRAINT [CK_dttrigdel] CHECK  (([td_id]<>(0) AND [td_tgid]<>(0) AND [td_recid]<>(0)))
GO
ALTER TABLE [dbo].[dttrigdel] CHECK CONSTRAINT [CK_dttrigdel]
GO
ALTER TABLE [dbo].[dttrigqueue]  WITH CHECK ADD  CONSTRAINT [CK_dttrigqueue] CHECK  (([tq_recid]<>(0) AND [tq_tgid]<>(0)))
GO
ALTER TABLE [dbo].[dttrigqueue] CHECK CONSTRAINT [CK_dttrigqueue]
GO
ALTER TABLE [dbo].[dtusersecquest]  WITH CHECK ADD  CONSTRAINT [CK_dtusersecquest] CHECK  (([uq_id]<>(0) AND [uq_sqid]<>(0) AND [uq_usid]<>(0)))
GO
ALTER TABLE [dbo].[dtusersecquest] CHECK CONSTRAINT [CK_dtusersecquest]
GO
ALTER TABLE [dbo].[dtworkshift]  WITH CHECK ADD  CONSTRAINT [CK_dtworkshift] CHECK  (([ws_id]<>(0) AND [ws_date] IS NOT NULL AND [ws_sfid]<>(0) AND [ws_woid]<>(0) AND [ws_j2id]<>(0)))
GO
ALTER TABLE [dbo].[dtworkshift] CHECK CONSTRAINT [CK_dtworkshift]
GO
ALTER TABLE [dbo].[dxbrow]  WITH NOCHECK ADD  CONSTRAINT [CK_dxbrow] CHECK  (([br_id]<>(0) AND [br_name]<>' ' AND [br_title]<>' '))
GO
ALTER TABLE [dbo].[dxbrow] CHECK CONSTRAINT [CK_dxbrow]
GO
ALTER TABLE [dbo].[dxbrow2]  WITH NOCHECK ADD  CONSTRAINT [CK_dxbrow2] CHECK  (([b2_id]<>(0) AND [b2_title]<>' ' AND [b2_field]<>' ' AND [b2_width]<>(0)))
GO
ALTER TABLE [dbo].[dxbrow2] CHECK CONSTRAINT [CK_dxbrow2]
GO
ALTER TABLE [dbo].[dxbrow3]  WITH CHECK ADD  CONSTRAINT [CK_dxbrow3] CHECK  (([b3_id]<>(0) AND [b3_name]<>' '))
GO
ALTER TABLE [dbo].[dxbrow3] CHECK CONSTRAINT [CK_dxbrow3]
GO
ALTER TABLE [dbo].[dxbrowreport]  WITH CHECK ADD  CONSTRAINT [CK_dxbrowreport] CHECK  (([bt_id]<>(0) AND [bt_name]<>'' AND [bt_brid]<>(0)))
GO
ALTER TABLE [dbo].[dxbrowreport] CHECK CONSTRAINT [CK_dxbrowreport]
GO
ALTER TABLE [dbo].[dxbrowsec]  WITH CHECK ADD  CONSTRAINT [CK_dxbrowsec] CHECK  (([bs_usid]<>(0) OR [bs_ugid]<>(0)))
GO
ALTER TABLE [dbo].[dxbrowsec] CHECK CONSTRAINT [CK_dxbrowsec]
GO
ALTER TABLE [dbo].[dxbutton]  WITH NOCHECK ADD  CONSTRAINT [CK_dxbutton] CHECK  (([bu_id]<>(0) AND [bu_name]<>''))
GO
ALTER TABLE [dbo].[dxbutton] CHECK CONSTRAINT [CK_dxbutton]
GO
ALTER TABLE [dbo].[dxbutton2]  WITH NOCHECK ADD  CONSTRAINT [CK_dxbutton2] CHECK  (([b2_id]<>(0) AND [b2_buid]<>(0) AND [b2_groupid]<>(0) AND [b2_position]<>(0)))
GO
ALTER TABLE [dbo].[dxbutton2] CHECK CONSTRAINT [CK_dxbutton2]
GO
ALTER TABLE [dbo].[dxbutton3]  WITH NOCHECK ADD  CONSTRAINT [CK_dxbutton3] CHECK  (([b3_brid]<>(0) AND [b3_id]<>(0)))
GO
ALTER TABLE [dbo].[dxbutton3] CHECK CONSTRAINT [CK_dxbutton3]
GO
ALTER TABLE [dbo].[dxcmsoption]  WITH CHECK ADD  CONSTRAINT [CK_dxcmsoption] CHECK  (([co_id]<>(0) AND [co_csid]<>(0) AND [co_key]<>'' AND [co_val]<>'' AND [co_desc]<>''))
GO
ALTER TABLE [dbo].[dxcmsoption] CHECK CONSTRAINT [CK_dxcmsoption]
GO
ALTER TABLE [dbo].[dxcmssite]  WITH CHECK ADD  CONSTRAINT [CK_dxcmssite] CHECK  (([cs_id]<>(0) AND [cs_name]<>'' AND [cs_website]<>''))
GO
ALTER TABLE [dbo].[dxcmssite] CHECK CONSTRAINT [CK_dxcmssite]
GO
ALTER TABLE [dbo].[dxdflt]  WITH CHECK ADD  CONSTRAINT [CK_dxdflt] CHECK  (([df_id]<>(0)))
GO
ALTER TABLE [dbo].[dxdflt] CHECK CONSTRAINT [CK_dxdflt]
GO
ALTER TABLE [dbo].[dxdflt2]  WITH CHECK ADD  CONSTRAINT [CK_dxdflt2] CHECK  (([df_id]<>(0)))
GO
ALTER TABLE [dbo].[dxdflt2] CHECK CONSTRAINT [CK_dxdflt2]
GO
ALTER TABLE [dbo].[dxdflt3]  WITH CHECK ADD  CONSTRAINT [CK_dxdflt3] CHECK  (([df_id]<>(0)))
GO
ALTER TABLE [dbo].[dxdflt3] CHECK CONSTRAINT [CK_dxdflt3]
GO
ALTER TABLE [dbo].[dxecommsync]  WITH CHECK ADD  CONSTRAINT [CK_dxecommsync] CHECK  (([es_id]<>(0) AND [es_table]<>'' AND [es_csid]<>(0)))
GO
ALTER TABLE [dbo].[dxecommsync] CHECK CONSTRAINT [CK_dxecommsync]
GO
ALTER TABLE [dbo].[dxedihist]  WITH CHECK ADD  CONSTRAINT [CK_dxedihist] CHECK  (([eh_id]<>(0) AND [eh_edid]<>(0)))
GO
ALTER TABLE [dbo].[dxedihist] CHECK CONSTRAINT [CK_dxedihist]
GO
ALTER TABLE [dbo].[dxextern]  WITH CHECK ADD  CONSTRAINT [CK_dxextern] CHECK  (([ex_id]<>(0) AND [ex_name]<>' '))
GO
ALTER TABLE [dbo].[dxextern] CHECK CONSTRAINT [CK_dxextern]
GO
ALTER TABLE [dbo].[dxexternhist]  WITH CHECK ADD  CONSTRAINT [CK_dxexternhist] CHECK  (([xh_id]<>(0) AND [xh_date] IS NOT NULL AND [xh_exid]<>(0) AND [xh_usid]<>(0) AND [xh_time]<>' '))
GO
ALTER TABLE [dbo].[dxexternhist] CHECK CONSTRAINT [CK_dxexternhist]
GO
ALTER TABLE [dbo].[dxfav]  WITH CHECK ADD  CONSTRAINT [CK_dxfav] CHECK  (([fv_id]<>(0) AND [fv_usid]<>(0) AND [fv_caption]<>' '))
GO
ALTER TABLE [dbo].[dxfav] CHECK CONSTRAINT [CK_dxfav]
GO
ALTER TABLE [dbo].[dxgridhist]  WITH CHECK ADD  CONSTRAINT [CK_dxgridhist] CHECK  (([gh_id]<>(0) AND [gh_action]<>' ' AND [gh_brid]<>(0) AND [gh_date] IS NOT NULL AND [gh_usid]<>(0)))
GO
ALTER TABLE [dbo].[dxgridhist] CHECK CONSTRAINT [CK_dxgridhist]
GO
ALTER TABLE [dbo].[dximphist]  WITH CHECK ADD  CONSTRAINT [CK_dximphist] CHECK  (([ih_id]<>(0) AND [ih_date] IS NOT NULL AND [ih_table]<>' ' AND [ih_time]<>' ' AND [ih_usid]<>(0)))
GO
ALTER TABLE [dbo].[dximphist] CHECK CONSTRAINT [CK_dximphist]
GO
ALTER TABLE [dbo].[dxin]  WITH CHECK ADD  CONSTRAINT [CK_dxin] CHECK  (([in_id]<>(0) AND ([in_usid]<>(0) OR [in_uaid]<>(0))))
GO
ALTER TABLE [dbo].[dxin] CHECK CONSTRAINT [CK_dxin]
GO
ALTER TABLE [dbo].[dxintegrationlogging]  WITH CHECK ADD  CONSTRAINT [CK_dxintegrationlogging] CHECK  (([il_id]<>(0)))
GO
ALTER TABLE [dbo].[dxintegrationlogging] CHECK CONSTRAINT [CK_dxintegrationlogging]
GO
ALTER TABLE [dbo].[dxlog]  WITH CHECK ADD  CONSTRAINT [CK_dxlog] CHECK  (([lo_id]<>(0) AND [lo_date] IS NOT NULL AND [lo_recid]<>' ' AND [lo_table]<>' ' AND [lo_time]<>' ' AND [lo_usid]<>(0)))
GO
ALTER TABLE [dbo].[dxlog] CHECK CONSTRAINT [CK_dxlog]
GO
ALTER TABLE [dbo].[dxmfu]  WITH CHECK ADD  CONSTRAINT [CK_dxmfu] CHECK  (([mf_id]<>(0) AND [mf_day] IS NOT NULL AND ([mf_m2id]<>(0) OR [mf_mtid]<>(0)) AND [mf_usid]<>(0)))
GO
ALTER TABLE [dbo].[dxmfu] CHECK CONSTRAINT [CK_dxmfu]
GO
ALTER TABLE [dbo].[dxmod]  WITH CHECK ADD  CONSTRAINT [CK_dxmod] CHECK  (([mo_id]<>(0)))
GO
ALTER TABLE [dbo].[dxmod] CHECK CONSTRAINT [CK_dxmod]
GO
ALTER TABLE [dbo].[dxmru]  WITH NOCHECK ADD  CONSTRAINT [CK_dxmru] CHECK  (([mr_id]<>(0) AND [mr_usid]<>(0) AND ([mr_m2guid] IS NOT NULL OR [mr_mtguid] IS NOT NULL) AND [mr_lastuse] IS NOT NULL))
GO
ALTER TABLE [dbo].[dxmru] CHECK CONSTRAINT [CK_dxmru]
GO
ALTER TABLE [dbo].[dxperf]  WITH CHECK ADD  CONSTRAINT [CK_dxperf] CHECK  (([pe_id]<>(0) AND [pe_usid]<>(0) AND [pe_brid]<>(0) AND [pe_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dxperf] CHECK CONSTRAINT [CK_dxperf]
GO
ALTER TABLE [dbo].[dxping]  WITH CHECK ADD  CONSTRAINT [CK_dxping] CHECK  (([pi_id]<>(0) AND [pi_token]<>(0) AND [pi_pingtime] IS NOT NULL AND [pi_appsource]<>'' AND [pi_usid]<>(0)))
GO
ALTER TABLE [dbo].[dxping] CHECK CONSTRAINT [CK_dxping]
GO
ALTER TABLE [dbo].[dxprefilter]  WITH CHECK ADD  CONSTRAINT [CK_dxprefilter] CHECK  (([pr_id]<>(0) AND [pr_name]<>' '))
GO
ALTER TABLE [dbo].[dxprefilter] CHECK CONSTRAINT [CK_dxprefilter]
GO
ALTER TABLE [dbo].[dxprefilter2]  WITH CHECK ADD  CONSTRAINT [CK_dxprefilter2] CHECK  (([p2_id]<>(0) AND [p2_field]<>' '))
GO
ALTER TABLE [dbo].[dxprefilter2] CHECK CONSTRAINT [CK_dxprefilter2]
GO
ALTER TABLE [dbo].[dxpromptover]  WITH CHECK ADD  CONSTRAINT [CK_dxpromptover] CHECK  (([po_id]<>(0) AND [po_ptid]<>(0) AND [po_caid]<>(0)))
GO
ALTER TABLE [dbo].[dxpromptover] CHECK CONSTRAINT [CK_dxpromptover]
GO
ALTER TABLE [dbo].[dxpset]  WITH CHECK ADD  CONSTRAINT [CK_dxpset] CHECK  (([ps_id]<>(0) AND [ps_fldname]<>' '))
GO
ALTER TABLE [dbo].[dxpset] CHECK CONSTRAINT [CK_dxpset]
GO
ALTER TABLE [dbo].[dxschedhist]  WITH CHECK ADD  CONSTRAINT [CK_dxschedhist] CHECK  (([sc_id]<>(0) AND [sc_date] IS NOT NULL AND [sc_isid]<>(0) AND [sc_usid]<>(0) AND [sc_time]<>' '))
GO
ALTER TABLE [dbo].[dxschedhist] CHECK CONSTRAINT [CK_dxschedhist]
GO
ALTER TABLE [dbo].[dxschedperf]  WITH CHECK ADD  CONSTRAINT [CK_dxschedperf] CHECK  (([sp_id]<>(0) AND [sp_dur]<>(0) AND [sp_max]<>(0) AND [sp_usid]<>(0) AND [sp_isid]<>(0) AND [sp_time]<>' ' AND [sp_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dxschedperf] CHECK CONSTRAINT [CK_dxschedperf]
GO
ALTER TABLE [dbo].[dxscripterr]  WITH CHECK ADD  CONSTRAINT [CK_dxscripterr] CHECK  (([se_id]<>(0) AND [se_date] IS NOT NULL AND [se_usid]<>(0) AND [se_document]<>''))
GO
ALTER TABLE [dbo].[dxscripterr] CHECK CONSTRAINT [CK_dxscripterr]
GO
ALTER TABLE [dbo].[dxscriptlog]  WITH CHECK ADD  CONSTRAINT [CK_dxscriptlog] CHECK  (([sl_id]<>(0) AND [sl_document]<>'' AND [sl_hash]<>'' AND [sl_lastrun] IS NOT NULL AND [sl_firstrun] IS NOT NULL))
GO
ALTER TABLE [dbo].[dxscriptlog] CHECK CONSTRAINT [CK_dxscriptlog]
GO
ALTER TABLE [dbo].[dxscriptperf]  WITH CHECK ADD  CONSTRAINT [CK_dxscriptperf] CHECK  (([sp_id]<>(0) AND [sp_document]<>'' AND [sp_seconds]>(0) AND [sp_usid]<>(0) AND [sp_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dxscriptperf] CHECK CONSTRAINT [CK_dxscriptperf]
GO
ALTER TABLE [dbo].[dxsecmod]  WITH CHECK ADD  CONSTRAINT [CK_dxsecmod] CHECK  (([sm_table]<>'' AND [sm_date] IS NOT NULL AND [sm_time]<>(0) AND [sm_changedby]<>(0)))
GO
ALTER TABLE [dbo].[dxsecmod] CHECK CONSTRAINT [CK_dxsecmod]
GO
ALTER TABLE [dbo].[dxsrch]  WITH NOCHECK ADD  CONSTRAINT [CK_dxsrch] CHECK  (([sr_id]<>(0) AND [sr_caption]<>' ' AND [sr_display]<>' ' AND [sr_index]<>' ' AND [sr_name]<>' ' AND [sr_retval]<>' ' AND [sr_table]<>' ' AND [sr_title]<>' ' AND [sr_number]<>(0)))
GO
ALTER TABLE [dbo].[dxsrch] CHECK CONSTRAINT [CK_dxsrch]
GO
ALTER TABLE [dbo].[dxsrch2]  WITH NOCHECK ADD  CONSTRAINT [CK_dxsrch2] CHECK  (([s2_id]<>(0) AND [s2_caption]<>' ' AND [s2_name]<>' ' AND [s2_type]<>' ' AND [s2_width]<>(0)))
GO
ALTER TABLE [dbo].[dxsrch2] CHECK CONSTRAINT [CK_dxsrch2]
GO
ALTER TABLE [dbo].[dxtrak]  WITH CHECK ADD  CONSTRAINT [CK_dxtrak] CHECK  (([tr_id]<>(0) AND [tr_name]<>' ' AND [tr_table]<>' '))
GO
ALTER TABLE [dbo].[dxtrak] CHECK CONSTRAINT [CK_dxtrak]
GO
ALTER TABLE [dbo].[dxtrak2]  WITH CHECK ADD  CONSTRAINT [CK_dxtrak2] CHECK  (([t2_id]<>(0) AND [t2_name]<>' '))
GO
ALTER TABLE [dbo].[dxtrak2] CHECK CONSTRAINT [CK_dxtrak2]
GO
ALTER TABLE [dbo].[dxtrak3]  WITH CHECK ADD  CONSTRAINT [CK_dxtrak3] CHECK  (([t3_id]<>(0) AND ([t3_t2id]<>(0) OR [t3_t4id]<>(0))))
GO
ALTER TABLE [dbo].[dxtrak3] CHECK CONSTRAINT [CK_dxtrak3]
GO
ALTER TABLE [dbo].[dxtrak4]  WITH CHECK ADD  CONSTRAINT [CK_dxtrak4] CHECK  (([t4_id]<>(0) AND [t4_name]<>' ' AND [t4_table]<>' ' AND [t4_recid]<>(0)))
GO
ALTER TABLE [dbo].[dxtrak4] CHECK CONSTRAINT [CK_dxtrak4]
GO
ALTER TABLE [dbo].[dxtrig]  WITH CHECK ADD  CONSTRAINT [CK_dxtrig] CHECK  (([tg_id]<>(0) AND [tg_name]<>' '))
GO
ALTER TABLE [dbo].[dxtrig] CHECK CONSTRAINT [CK_dxtrig]
GO
ALTER TABLE [dbo].[dxtrighist]  WITH CHECK ADD  CONSTRAINT [CK_dxtrighist] CHECK  (([th_id]<>(0) AND [th_tgid]<>(0) AND [th_date] IS NOT NULL))
GO
ALTER TABLE [dbo].[dxtrighist] CHECK CONSTRAINT [CK_dxtrighist]
GO
ALTER TABLE [dbo].[dxwmslastact]  WITH CHECK ADD  CONSTRAINT [CK_dxwmslastact] CHECK  (([la_usid]<>(0) AND [la_datetime] IS NOT NULL))
GO
ALTER TABLE [dbo].[dxwmslastact] CHECK CONSTRAINT [CK_dxwmslastact]
GO
ALTER TABLE [dbo].[dxwmslog]  WITH CHECK ADD  CONSTRAINT [CK_dxwmslog] CHECK  (([wg_id]<>(0)))
GO
ALTER TABLE [dbo].[dxwmslog] CHECK CONSTRAINT [CK_dxwmslog]
GO
