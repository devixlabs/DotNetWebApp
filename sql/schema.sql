USE [GAI]
GO
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
USE [GAIMisc]
GO
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
 */
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
-- CREATE TABLE [dbo].[acuity_forms](
-- 	[id] [bigint] NOT NULL,
-- 	[appointment_id] [bigint] NOT NULL,
-- 	[name] [nvarchar](255) NOT NULL,
-- 	[created_at] [datetime2] NOT NULL DEFAULT GETDATE(),
-- 	[updated_at] [datetime2] NOT NULL DEFAULT GETDATE(),
--  CONSTRAINT [PK_acuity_forms] PRIMARY KEY CLUSTERED ([id] ASC, [appointment_id] ASC),
--  CONSTRAINT [FK_acuity_forms_appointments] FOREIGN KEY ([appointment_id])
-- 	REFERENCES [dbo].[acuity_appointments] ([id]) ON DELETE CASCADE
-- ) ON [PRIMARY]
-- GO
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
-- CREATE TABLE [dbo].[acuity_form_values](
-- 	[id] [bigint] NOT NULL,
-- 	[form_id] [bigint] NOT NULL,
-- 	[appointment_id] [bigint] NOT NULL,
-- 	[fieldID] [bigint] NOT NULL,
-- 	[value] [ntext] NULL,
-- 	[name] [nvarchar](500) NOT NULL,
-- 	[created_at] [datetime2] NOT NULL DEFAULT GETDATE(),
-- 	[updated_at] [datetime2] NOT NULL DEFAULT GETDATE(),
--  CONSTRAINT [PK_acuity_form_values] PRIMARY KEY CLUSTERED ([id] ASC),
--  CONSTRAINT [FK_acuity_form_values_forms] FOREIGN KEY ([form_id], [appointment_id])
-- 	REFERENCES [dbo].[acuity_forms] ([id], [appointment_id]) ON DELETE CASCADE,
--  CONSTRAINT [FK_acuity_form_values_appointments] FOREIGN KEY ([appointment_id])
-- 	REFERENCES [dbo].[acuity_appointments] ([id]) ON DELETE NO ACTION
-- ) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
-- GO
