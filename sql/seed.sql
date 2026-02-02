-- ============================================================================
-- SEED DATA FOR DotNetWebApp
-- Uses actual column names from sql/schema.sql
-- Comprehensive seed data for demo purposes
-- ============================================================================

-- ============================================================================
-- GAI DATABASE
-- ============================================================================
USE [GAI];
GO

-- ============================================================================
-- 1. UNITS OF MEASURE (dmunit)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmunit] WHERE un_name = 'Each')
    INSERT INTO [dbo].[dmunit] (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES ('Each', 1, 1, 'P', 1, 1.0, 0.0, 0.0, 0, 1.0, '', 'EA');

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmunit] WHERE un_name = 'Case')
    INSERT INTO [dbo].[dmunit] (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES ('Case', 1, 0, 'P', 0, 12.0, 0.0, 0.0, 0, 1.0, '', 'CS');

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmunit] WHERE un_name = 'Box')
    INSERT INTO [dbo].[dmunit] (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES ('Box', 1, 0, 'P', 0, 24.0, 0.0, 0.0, 0, 1.0, '', 'BX');

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmunit] WHERE un_name = 'Pallet')
    INSERT INTO [dbo].[dmunit] (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES ('Pallet', 1, 0, 'P', 0, 48.0, 5.0, 5.0, 0, 1.0, '', 'PL');

-- ============================================================================
-- 2. VENDORS (dmvend)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmvend] WHERE ve_name = 'Acme Supplies Inc')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmvend] ON;
    INSERT INTO [dbo].[dmvend]
    (ve_id, ve_name, ve_street, ve_street2, ve_city, ve_state, ve_zip, ve_contact, ve_phone, ve_fax, ve_active,
     ve_teid, ve_trid, ve_taxid, ve_socsec, ve_1099, ve_edi, ve_notes, ve_rname, ve_rstreet, ve_rstreet2,
     ve_rcity, ve_rstate, ve_rzip, ve_takedis, ve_highcrd, ve_potype, ve_p1id, ve_p2id, ve_county, ve_vendid,
     ve_email, ve_dfltinv, ve_frid, ve_dftchid, ve_webname, ve_webpass, ve_vgid, ve_backord, ve_rcontact,
     ve_remail, ve_rfax, ve_rphone, ve_phext, ve_rphext, ve_waid, ve_taid1, ve_taid2, ve_fcid, ve_autoinv,
     ve_popup, ve_country, ve_frtdisc, ve_ccode, ve_apchid, ve_mobileid, ve_coid, ve_popuprecv, ve_rcountry,
     ve_trakid, ve_trak2id, ve_potrakid, ve_pricingbasedon, ve_copyqc, ve_vendordate, ve_posuspchid, ve_street3,
     ve_rstreet3, ve_routpo, ve_retainqc, ve_retattrib1, ve_retattrib2, ve_retattrib3, ve_retdates, ve_minunid,
     ve_minunit, ve_minext, ve_availall, ve_cyid, ve_rcyid, ve_caid, ve_invuniquenum, ve_tyid, ve_linkposearch,
     ve_pjid, ve_c3id, ve_requiremfgvendor, ve_approvalexpires, ve_1099type, ve_psid, ve_vendorhold, ve_invoicehold,
     ve_paymenthold, ve_vatid, ve_brid, ve_baid)
    VALUES
    (1, 'Acme Supplies Inc', '123 Main Street', 'Suite 100', 'Springfield', 'IL', '62701', 'John Smith', '555-123-4567', '555-123-4568', 1,
     0, 0, '', '', 0, 0, '', 'Acme Supplies Inc', '123 Main Street', 'Suite 100',
     'Springfield', 'IL', '62701', 0, 0.00, '', 0, 0, '', 'ACME001',
     'john@acme.com', '', 0, 0, '', '', 0, 0, '',
     '', '', '', '', '', 0, 0, 0, 0, 0,
     '', 'USA', 0, '', 0, 0, 0, '', 'USA',
     0, 0, 0, '', 0, 0, 0, '',
     '', 0, 0, 0, 0, 0, 0, 0,
     0.0, 0.0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, NULL, '', 0, 0, 0,
     0, '', 0, 0);
    SET IDENTITY_INSERT [dbo].[dmvend] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmvend] WHERE ve_name = 'Global Parts Co')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmvend] ON;
    INSERT INTO [dbo].[dmvend]
    (ve_id, ve_name, ve_street, ve_street2, ve_city, ve_state, ve_zip, ve_contact, ve_phone, ve_fax, ve_active,
     ve_teid, ve_trid, ve_taxid, ve_socsec, ve_1099, ve_edi, ve_notes, ve_rname, ve_rstreet, ve_rstreet2,
     ve_rcity, ve_rstate, ve_rzip, ve_takedis, ve_highcrd, ve_potype, ve_p1id, ve_p2id, ve_county, ve_vendid,
     ve_email, ve_dfltinv, ve_frid, ve_dftchid, ve_webname, ve_webpass, ve_vgid, ve_backord, ve_rcontact,
     ve_remail, ve_rfax, ve_rphone, ve_phext, ve_rphext, ve_waid, ve_taid1, ve_taid2, ve_fcid, ve_autoinv,
     ve_popup, ve_country, ve_frtdisc, ve_ccode, ve_apchid, ve_mobileid, ve_coid, ve_popuprecv, ve_rcountry,
     ve_trakid, ve_trak2id, ve_potrakid, ve_pricingbasedon, ve_copyqc, ve_vendordate, ve_posuspchid, ve_street3,
     ve_rstreet3, ve_routpo, ve_retainqc, ve_retattrib1, ve_retattrib2, ve_retattrib3, ve_retdates, ve_minunid,
     ve_minunit, ve_minext, ve_availall, ve_cyid, ve_rcyid, ve_caid, ve_invuniquenum, ve_tyid, ve_linkposearch,
     ve_pjid, ve_c3id, ve_requiremfgvendor, ve_approvalexpires, ve_1099type, ve_psid, ve_vendorhold, ve_invoicehold,
     ve_paymenthold, ve_vatid, ve_brid, ve_baid)
    VALUES
    (2, 'Global Parts Co', '456 Industrial Blvd', '', 'Chicago', 'IL', '60601', 'Jane Doe', '555-234-5678', '555-234-5679', 1,
     0, 0, '', '', 0, 0, '', 'Global Parts Co', '456 Industrial Blvd', '',
     'Chicago', 'IL', '60601', 0, 0.00, '', 0, 0, '', 'GLOB001',
     'jane@globalparts.com', '', 0, 0, '', '', 0, 0, '',
     '', '', '', '', '', 0, 0, 0, 0, 0,
     '', 'USA', 0, '', 0, 0, 0, '', 'USA',
     0, 0, 0, '', 0, 0, 0, '',
     '', 0, 0, 0, 0, 0, 0, 0,
     0.0, 0.0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, NULL, '', 0, 0, 0,
     0, '', 0, 0);
    SET IDENTITY_INSERT [dbo].[dmvend] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmvend] WHERE ve_name = 'Premier Materials LLC')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmvend] ON;
    INSERT INTO [dbo].[dmvend]
    (ve_id, ve_name, ve_street, ve_street2, ve_city, ve_state, ve_zip, ve_contact, ve_phone, ve_fax, ve_active,
     ve_teid, ve_trid, ve_taxid, ve_socsec, ve_1099, ve_edi, ve_notes, ve_rname, ve_rstreet, ve_rstreet2,
     ve_rcity, ve_rstate, ve_rzip, ve_takedis, ve_highcrd, ve_potype, ve_p1id, ve_p2id, ve_county, ve_vendid,
     ve_email, ve_dfltinv, ve_frid, ve_dftchid, ve_webname, ve_webpass, ve_vgid, ve_backord, ve_rcontact,
     ve_remail, ve_rfax, ve_rphone, ve_phext, ve_rphext, ve_waid, ve_taid1, ve_taid2, ve_fcid, ve_autoinv,
     ve_popup, ve_country, ve_frtdisc, ve_ccode, ve_apchid, ve_mobileid, ve_coid, ve_popuprecv, ve_rcountry,
     ve_trakid, ve_trak2id, ve_potrakid, ve_pricingbasedon, ve_copyqc, ve_vendordate, ve_posuspchid, ve_street3,
     ve_rstreet3, ve_routpo, ve_retainqc, ve_retattrib1, ve_retattrib2, ve_retattrib3, ve_retdates, ve_minunid,
     ve_minunit, ve_minext, ve_availall, ve_cyid, ve_rcyid, ve_caid, ve_invuniquenum, ve_tyid, ve_linkposearch,
     ve_pjid, ve_c3id, ve_requiremfgvendor, ve_approvalexpires, ve_1099type, ve_psid, ve_vendorhold, ve_invoicehold,
     ve_paymenthold, ve_vatid, ve_brid, ve_baid)
    VALUES
    (3, 'Premier Materials LLC', '789 Commerce Way', 'Building A', 'Detroit', 'MI', '48201', 'Bob Wilson', '555-345-6789', '555-345-6790', 1,
     0, 0, '', '', 0, 0, '', 'Premier Materials LLC', '789 Commerce Way', 'Building A',
     'Detroit', 'MI', '48201', 0, 0.00, '', 0, 0, '', 'PREM001',
     'bob@premier.com', '', 0, 0, '', '', 0, 0, '',
     '', '', '', '', '', 0, 0, 0, 0, 0,
     '', 'USA', 0, '', 0, 0, 0, '', 'USA',
     0, 0, 0, '', 0, 0, 0, '',
     '', 0, 0, 0, 0, 0, 0, 0,
     0.0, 0.0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0, NULL, '', 0, 0, 0,
     0, '', 0, 0);
    SET IDENTITY_INSERT [dbo].[dmvend] OFF;
END;

-- ============================================================================
-- 3. PRODUCTS (dmprod) - ALL 264 columns (excluding pr_id IDENTITY)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmprod] WHERE pr_codenum = 'WIDGET-A')
INSERT INTO [dbo].[dmprod] (
    pr_codenum, pr_descrip, pr_level, pr_buid, pr_caid, pr_lispric, pr_stanlab, pr_stanmat, pr_stantot, pr_active,
    pr_taxable, pr_unitwgt, pr_ware1, pr_control, pr_drwcode, pr_reorder, pr_salable, pr_purable, pr_stocked, pr_abc,
    pr_user1, pr_user2, pr_user3, pr_user4, pr_notes, pr_make, pr_ordtype, pr_frtclas, pr_retail, pr_burden,
    pr_prunid, pr_prfact, pr_scrap, pr_purpric, pr_c2id, pr_discoun, pr_unquant, pr_singord, pr_chid, pr_invchid,
    pr_matexp, pr_invadj, pr_cogpro, pr_rdid, pr_unitvol, pr_unitcub, pr_reorder2, pr_puradj, pr_hazard, pr_matbur,
    pr_buracct, pr_salunid, pr_salfact, pr_finmat, pr_finlab, pr_finbur, pr_specpar, pr_density, pr_counted, pr_cntflag,
    pr_fixstan, pr_invgain, pr_user5, pr_user6, pr_neginv, pr_maxquan1, pr_maxquan2, pr_fixmat, pr_fixlab, pr_fixbur,
    pr_fixmbur, pr_fixupdt, pr_mrp, pr_catch, pr_catchwgt, pr_tranvar, pr_xferexp, pr_loadcalc1, pr_loadcalc2, pr_loadcalc3,
    pr_burcalc, pr_matburcalc, pr_purtype, pr_taxpo, pr_popso, pr_poppo, pr_custinv, pr_qcid, pr_quota, pr_lifocost,
    pr_tgid, pr_user7, pr_user8, pr_user9, pr_rdid2, pr_secure, pr_hazflag, pr_stanfrt, pr_fixfrt, pr_frtchid,
    pr_phid, pr_shelf, pr_commable, pr_finwip, pr_custreq, pr_poquan, pr_soquan, pr_jobquan, pr_makeord, pr_inherit,
    pr_minmar, pr_tarmar, pr_msfactor, pr_allowbom, pr_prtlabel, pr_futmat, pr_futlab, pr_futbur, pr_futmbur, pr_futfrt,
    pr_futstan, pr_timemrp, pr_nosub, pr_finpart, pr_purunid, pr_unid, pr_lotreqd, pr_orddays, pr_qcfreq, pr_lotrecv,
    pr_vendreq, pr_cofaid, pr_polabid, pr_solabid, pr_itemlabid, pr_msdsid, pr_joblabid, pr_finback, pr_lotlabid, pr_markup,
    pr_xfermarkchid, pr_stanupdt, pr_futupdt, pr_psid, pr_serial, pr_featcost, pr_reqfacility, pr_routing,
    pr_issueoverlimit, pr_issuelimitenforce, pr_porecvlimit, pr_porecvlimitenforce, pr_secureprice, pr_xfercost,
    pr_s1id, pr_s2id, pr_backjob, pr_splitjobs, pr_overissue, pr_unitlen, pr_loid, pr_jobmin, pr_ltid, pr_qclead,
    pr_trakid, pr_trak2id, pr_minquant, pr_qcfreqtype, pr_serialcont, pr_jobmgid, pr_separatejobs, pr_rollupmats,
    pr_rolluplabor, pr_rollupburden, pr_tarewgt, pr_finasissued, pr_countunid, pr_palunid, pr_picture, pr_popjob,
    pr_routesale, pr_contprid, pr_finmatwiploc, pr_scrapcost, pr_rollupwgt, pr_xferchid, pr_measured, pr_creditcost,
    pr_routereturn, pr_combinepos, pr_definqty, pr_incquant, pr_shoprel, pr_frominvprid, pr_minsale, pr_incsale,
    pr_separatepos, pr_splitpos, pr_recatrisk, pr_shipquan, pr_salediscchid, pr_mrpjobsubasm, pr_taretype, pr_tareexp,
    pr_rollupvol, pr_minwgt, pr_maxwgt, pr_haltposting, pr_contunid, pr_commexp, pr_zoneput, pr_frtexpchid, pr_jobinc,
    pr_dnid, pr_safedays, pr_prtjobpl, pr_restrictjobquant, pr_frtrevchid, pr_qcmrpjobplan, pr_reqexpdate, pr_minpallet,
    pr_qcid2, pr_pickorder, pr_wipinv, pr_splitposby, pr_issueunderlimit, pr_issueunderenforce, pr_iataunit, pr_roundupbom,
    pr_finseqstage, pr_recalcbomcalcs, pr_subordjob, pr_suggestbefore, pr_dockrel, pr_restrictjobinc, pr_deresqty,
    pr_restrictloc, pr_forecastback, pr_forecastforward, pr_backordpo, pr_pickunit, pr_leadmins, pr_makemlfinish,
    pr_xfacmarkchid, pr_custreqxfer, pr_backordso, pr_finishltid, pr_finishloid, pr_receiveloid, pr_receiveltid,
    pr_autofinunid, pr_autofinish, pr_rolluprstypes, pr_purdis, pr_splitjobson, pr_bomunid, pr_separateicxfers,
    pr_poallocatable, pr_autoaltwgt, pr_totalcatchml, pr_dfltreserveloc, pr_autolinkmrpjobs, pr_makemlreceive, pr_allowlistprice
) VALUES (
    'WIDGET-A', 'Premium Widget Type A', 1, 0, 0, 29.99, 0, 0, 0, 1,
    1, 0.5, '', 0, '', 10, 1, 1, 1, 'A',
    '', '', '', '', 'High-quality widget', 0, 'S', '', '', 0,
    1, 1.0, 0, 15.00, 0, 1, 1, 0, 0, 0,
    0, 0, 0, 0, 0.1, 0.01, 5, 0, '', 0,
    0, 0, 1.0, 0, 0, 0, 0, 1.0, NULL, 0,
    0, 0, 0, 0, '', 0, 0, 0, 0, 0,
    0, NULL, 0, 0, 0, 0, 0, '', '', '',
    '', '', '', 0, '', '', 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 30, 1, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 1.0, 0, '', 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, NULL, NULL, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, '', 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, '',
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, '', 0, 0, '', '',
    0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, '', 0, '', 0, 0, '', 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, '', 0, 0,
    0, '', 0, 0, 0, 0, 0
);

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmprod] WHERE pr_codenum = 'GADGET-PRO')
INSERT INTO [dbo].[dmprod] (
    pr_codenum, pr_descrip, pr_level, pr_buid, pr_caid, pr_lispric, pr_stanlab, pr_stanmat, pr_stantot, pr_active,
    pr_taxable, pr_unitwgt, pr_ware1, pr_control, pr_drwcode, pr_reorder, pr_salable, pr_purable, pr_stocked, pr_abc,
    pr_user1, pr_user2, pr_user3, pr_user4, pr_notes, pr_make, pr_ordtype, pr_frtclas, pr_retail, pr_burden,
    pr_prunid, pr_prfact, pr_scrap, pr_purpric, pr_c2id, pr_discoun, pr_unquant, pr_singord, pr_chid, pr_invchid,
    pr_matexp, pr_invadj, pr_cogpro, pr_rdid, pr_unitvol, pr_unitcub, pr_reorder2, pr_puradj, pr_hazard, pr_matbur,
    pr_buracct, pr_salunid, pr_salfact, pr_finmat, pr_finlab, pr_finbur, pr_specpar, pr_density, pr_counted, pr_cntflag,
    pr_fixstan, pr_invgain, pr_user5, pr_user6, pr_neginv, pr_maxquan1, pr_maxquan2, pr_fixmat, pr_fixlab, pr_fixbur,
    pr_fixmbur, pr_fixupdt, pr_mrp, pr_catch, pr_catchwgt, pr_tranvar, pr_xferexp, pr_loadcalc1, pr_loadcalc2, pr_loadcalc3,
    pr_burcalc, pr_matburcalc, pr_purtype, pr_taxpo, pr_popso, pr_poppo, pr_custinv, pr_qcid, pr_quota, pr_lifocost,
    pr_tgid, pr_user7, pr_user8, pr_user9, pr_rdid2, pr_secure, pr_hazflag, pr_stanfrt, pr_fixfrt, pr_frtchid,
    pr_phid, pr_shelf, pr_commable, pr_finwip, pr_custreq, pr_poquan, pr_soquan, pr_jobquan, pr_makeord, pr_inherit,
    pr_minmar, pr_tarmar, pr_msfactor, pr_allowbom, pr_prtlabel, pr_futmat, pr_futlab, pr_futbur, pr_futmbur, pr_futfrt,
    pr_futstan, pr_timemrp, pr_nosub, pr_finpart, pr_purunid, pr_unid, pr_lotreqd, pr_orddays, pr_qcfreq, pr_lotrecv,
    pr_vendreq, pr_cofaid, pr_polabid, pr_solabid, pr_itemlabid, pr_msdsid, pr_joblabid, pr_finback, pr_lotlabid, pr_markup,
    pr_xfermarkchid, pr_stanupdt, pr_futupdt, pr_psid, pr_serial, pr_featcost, pr_reqfacility, pr_routing,
    pr_issueoverlimit, pr_issuelimitenforce, pr_porecvlimit, pr_porecvlimitenforce, pr_secureprice, pr_xfercost,
    pr_s1id, pr_s2id, pr_backjob, pr_splitjobs, pr_overissue, pr_unitlen, pr_loid, pr_jobmin, pr_ltid, pr_qclead,
    pr_trakid, pr_trak2id, pr_minquant, pr_qcfreqtype, pr_serialcont, pr_jobmgid, pr_separatejobs, pr_rollupmats,
    pr_rolluplabor, pr_rollupburden, pr_tarewgt, pr_finasissued, pr_countunid, pr_palunid, pr_picture, pr_popjob,
    pr_routesale, pr_contprid, pr_finmatwiploc, pr_scrapcost, pr_rollupwgt, pr_xferchid, pr_measured, pr_creditcost,
    pr_routereturn, pr_combinepos, pr_definqty, pr_incquant, pr_shoprel, pr_frominvprid, pr_minsale, pr_incsale,
    pr_separatepos, pr_splitpos, pr_recatrisk, pr_shipquan, pr_salediscchid, pr_mrpjobsubasm, pr_taretype, pr_tareexp,
    pr_rollupvol, pr_minwgt, pr_maxwgt, pr_haltposting, pr_contunid, pr_commexp, pr_zoneput, pr_frtexpchid, pr_jobinc,
    pr_dnid, pr_safedays, pr_prtjobpl, pr_restrictjobquant, pr_frtrevchid, pr_qcmrpjobplan, pr_reqexpdate, pr_minpallet,
    pr_qcid2, pr_pickorder, pr_wipinv, pr_splitposby, pr_issueunderlimit, pr_issueunderenforce, pr_iataunit, pr_roundupbom,
    pr_finseqstage, pr_recalcbomcalcs, pr_subordjob, pr_suggestbefore, pr_dockrel, pr_restrictjobinc, pr_deresqty,
    pr_restrictloc, pr_forecastback, pr_forecastforward, pr_backordpo, pr_pickunit, pr_leadmins, pr_makemlfinish,
    pr_xfacmarkchid, pr_custreqxfer, pr_backordso, pr_finishltid, pr_finishloid, pr_receiveloid, pr_receiveltid,
    pr_autofinunid, pr_autofinish, pr_rolluprstypes, pr_purdis, pr_splitjobson, pr_bomunid, pr_separateicxfers,
    pr_poallocatable, pr_autoaltwgt, pr_totalcatchml, pr_dfltreserveloc, pr_autolinkmrpjobs, pr_makemlreceive, pr_allowlistprice
) VALUES (
    'GADGET-PRO', 'Professional Gadget Series', 1, 0, 0, 149.99, 0, 0, 0, 1,
    1, 1.2, '', 0, '', 5, 1, 1, 1, 'A',
    '', '', '', '', 'Advanced gadget', 0, 'S', '', '', 0,
    1, 1.0, 0, 75.00, 0, 1, 1, 0, 0, 0,
    0, 0, 0, 0, 0.5, 0.05, 3, 0, '', 0,
    0, 0, 1.0, 0, 0, 0, 0, 1.0, NULL, 0,
    0, 0, 0, 0, '', 0, 0, 0, 0, 0,
    0, NULL, 0, 0, 0, 0, 0, '', '', '',
    '', '', '', 0, '', '', 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 60, 1, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 1.0, 0, '', 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, NULL, NULL, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, '', 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, '',
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, '', 0, 0, '', '',
    0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, '', 0, '', 0, 0, '', 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, '', 0, 0,
    0, '', 0, 0, 0, 0, 0
);

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmprod] WHERE pr_codenum = 'COMP-X100')
INSERT INTO [dbo].[dmprod] (
    pr_codenum, pr_descrip, pr_level, pr_buid, pr_caid, pr_lispric, pr_stanlab, pr_stanmat, pr_stantot, pr_active,
    pr_taxable, pr_unitwgt, pr_ware1, pr_control, pr_drwcode, pr_reorder, pr_salable, pr_purable, pr_stocked, pr_abc,
    pr_user1, pr_user2, pr_user3, pr_user4, pr_notes, pr_make, pr_ordtype, pr_frtclas, pr_retail, pr_burden,
    pr_prunid, pr_prfact, pr_scrap, pr_purpric, pr_c2id, pr_discoun, pr_unquant, pr_singord, pr_chid, pr_invchid,
    pr_matexp, pr_invadj, pr_cogpro, pr_rdid, pr_unitvol, pr_unitcub, pr_reorder2, pr_puradj, pr_hazard, pr_matbur,
    pr_buracct, pr_salunid, pr_salfact, pr_finmat, pr_finlab, pr_finbur, pr_specpar, pr_density, pr_counted, pr_cntflag,
    pr_fixstan, pr_invgain, pr_user5, pr_user6, pr_neginv, pr_maxquan1, pr_maxquan2, pr_fixmat, pr_fixlab, pr_fixbur,
    pr_fixmbur, pr_fixupdt, pr_mrp, pr_catch, pr_catchwgt, pr_tranvar, pr_xferexp, pr_loadcalc1, pr_loadcalc2, pr_loadcalc3,
    pr_burcalc, pr_matburcalc, pr_purtype, pr_taxpo, pr_popso, pr_poppo, pr_custinv, pr_qcid, pr_quota, pr_lifocost,
    pr_tgid, pr_user7, pr_user8, pr_user9, pr_rdid2, pr_secure, pr_hazflag, pr_stanfrt, pr_fixfrt, pr_frtchid,
    pr_phid, pr_shelf, pr_commable, pr_finwip, pr_custreq, pr_poquan, pr_soquan, pr_jobquan, pr_makeord, pr_inherit,
    pr_minmar, pr_tarmar, pr_msfactor, pr_allowbom, pr_prtlabel, pr_futmat, pr_futlab, pr_futbur, pr_futmbur, pr_futfrt,
    pr_futstan, pr_timemrp, pr_nosub, pr_finpart, pr_purunid, pr_unid, pr_lotreqd, pr_orddays, pr_qcfreq, pr_lotrecv,
    pr_vendreq, pr_cofaid, pr_polabid, pr_solabid, pr_itemlabid, pr_msdsid, pr_joblabid, pr_finback, pr_lotlabid, pr_markup,
    pr_xfermarkchid, pr_stanupdt, pr_futupdt, pr_psid, pr_serial, pr_featcost, pr_reqfacility, pr_routing,
    pr_issueoverlimit, pr_issuelimitenforce, pr_porecvlimit, pr_porecvlimitenforce, pr_secureprice, pr_xfercost,
    pr_s1id, pr_s2id, pr_backjob, pr_splitjobs, pr_overissue, pr_unitlen, pr_loid, pr_jobmin, pr_ltid, pr_qclead,
    pr_trakid, pr_trak2id, pr_minquant, pr_qcfreqtype, pr_serialcont, pr_jobmgid, pr_separatejobs, pr_rollupmats,
    pr_rolluplabor, pr_rollupburden, pr_tarewgt, pr_finasissued, pr_countunid, pr_palunid, pr_picture, pr_popjob,
    pr_routesale, pr_contprid, pr_finmatwiploc, pr_scrapcost, pr_rollupwgt, pr_xferchid, pr_measured, pr_creditcost,
    pr_routereturn, pr_combinepos, pr_definqty, pr_incquant, pr_shoprel, pr_frominvprid, pr_minsale, pr_incsale,
    pr_separatepos, pr_splitpos, pr_recatrisk, pr_shipquan, pr_salediscchid, pr_mrpjobsubasm, pr_taretype, pr_tareexp,
    pr_rollupvol, pr_minwgt, pr_maxwgt, pr_haltposting, pr_contunid, pr_commexp, pr_zoneput, pr_frtexpchid, pr_jobinc,
    pr_dnid, pr_safedays, pr_prtjobpl, pr_restrictjobquant, pr_frtrevchid, pr_qcmrpjobplan, pr_reqexpdate, pr_minpallet,
    pr_qcid2, pr_pickorder, pr_wipinv, pr_splitposby, pr_issueunderlimit, pr_issueunderenforce, pr_iataunit, pr_roundupbom,
    pr_finseqstage, pr_recalcbomcalcs, pr_subordjob, pr_suggestbefore, pr_dockrel, pr_restrictjobinc, pr_deresqty,
    pr_restrictloc, pr_forecastback, pr_forecastforward, pr_backordpo, pr_pickunit, pr_leadmins, pr_makemlfinish,
    pr_xfacmarkchid, pr_custreqxfer, pr_backordso, pr_finishltid, pr_finishloid, pr_receiveloid, pr_receiveltid,
    pr_autofinunid, pr_autofinish, pr_rolluprstypes, pr_purdis, pr_splitjobson, pr_bomunid, pr_separateicxfers,
    pr_poallocatable, pr_autoaltwgt, pr_totalcatchml, pr_dfltreserveloc, pr_autolinkmrpjobs, pr_makemlreceive, pr_allowlistprice
) VALUES (
    'COMP-X100', 'Industrial Component X100', 1, 0, 0, 8.50, 0, 0, 0, 1,
    1, 0.1, '', 0, '', 100, 1, 1, 1, 'B',
    '', '', '', '', 'Standard component', 0, 'S', '', '', 0,
    2, 12.0, 0, 4.00, 0, 1, 1, 0, 0, 0,
    0, 0, 0, 0, 0.02, 0.002, 50, 0, '', 0,
    0, 0, 1.0, 0, 0, 0, 0, 1.0, NULL, 0,
    0, 0, 0, 0, '', 0, 0, 0, 0, 0,
    0, NULL, 0, 0, 0, 0, 0, '', '', '',
    '', '', '', 0, '', '', 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 90, 1, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 1.0, 0, '', 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, NULL, NULL, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, '', 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, '',
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, '', 0, 0, '', '',
    0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, '', 0, '', 0, 0, '', 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, '', 0, 0,
    0, '', 0, 0, 0, 0, 0
);

-- ============================================================================
-- 4. SHIP-TO ADDRESSES (dmship)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmship] WHERE sh_name = 'Main Warehouse')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmship] ON;
    INSERT INTO [dbo].[dmship]
    (sh_id, sh_name, sh_biid, sh_brid, sh_s1id, sh_s2id, sh_smid, sh_street, sh_street2, sh_city, sh_state, sh_zip,
     sh_phone, sh_fax, sh_contact, sh_trid, sh_waid, sh_active, sh_statax, sh_loctax, sh_notes, sh_country, sh_ccode,
     sh_default, sh_county, sh_custid, sh_email, sh_frid, sh_s3id, sh_webname, sh_webpass, sh_s4id, sh_s5id,
     sh_credlim, sh_pastday, sh_credhld, sh_collect, sh_teid, sh_phext, sh_lastcred, sh_nextact, sh_nextdate,
     sh_exid, sh_dear, sh_said, sh_tranwaid, sh_fcid, sh_pjid, sh_popup, sh_quota, sh_exempt, sh_service,
     sh_exceed, sh_exday, sh_credflag, sh_dgid, sh_psid, sh_poreqd, sh_pomask, sh_waretaxover, sh_shelfpct,
     sh_popupship, sh_dba, sh_trakid, sh_trak2id, sh_shelfdays, sh_sotrakid, sh_prior, sh_crosswaid,
     sh_bomon, sh_bofulltr, sh_bofullpl, sh_botue, sh_bowed, sh_bothu, sh_bofri, sh_bosat, sh_bosun,
     sh_exreserve, sh_routeacct, sh_latitude, sh_longitude, sh_shortship, sh_reqdsdsig, sh_shipzone, sh_reqcpart,
     sh_availall, sh_street3, sh_ccid, sh_prtdgrpto, sh_caid, sh_noinvdflt, sh_noreserve, sh_retattrib1,
     sh_retattrib2, sh_retattrib3, sh_retdates, sh_laststateprint, sh_creddueshipdays, sh_ttid, sh_addressvalid,
     sh_svctype, sh_edishiptopo, sh_edishiptopodays, sh_retainreservedbo, sh_exemptexpires, sh_linkedjobfinish,
     sh_vatid, sh_cyid, sh_serializeonreserve, sh_taxexemptcode)
    VALUES
    (1, 'Main Warehouse', 0, 0, 0, 0, 0, '100 Industrial Pkwy', '', 'Springfield', 'IL', '62701',
     '555-100-1000', '555-100-1001', 'Warehouse Manager', 0, 0, 1, 0, 0, '', 'USA', '',
     1, '', 'MAIN001', 'warehouse@example.com', 0, 0, '', '', 0, 0,
     0, 0, NULL, '', 0, '', NULL, '', NULL,
     0, '', 0, 0, 0, 0, '', 0, 0, 0,
     0, 0, 0, 0, 0, 0, '', 0, 0,
     '', '', 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 0.0, 0.0, '', 0, '', 0,
     0, '', 0, '', 0, 0, 0, 0,
     0, 0, 0, NULL, 0, 0, NULL,
     '', 0, 0, 0, NULL, '',
     '', 0, 0, '');
    SET IDENTITY_INSERT [dbo].[dmship] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmship] WHERE sh_name = 'East Coast Distribution')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmship] ON;
    INSERT INTO [dbo].[dmship]
    (sh_id, sh_name, sh_biid, sh_brid, sh_s1id, sh_s2id, sh_smid, sh_street, sh_street2, sh_city, sh_state, sh_zip,
     sh_phone, sh_fax, sh_contact, sh_trid, sh_waid, sh_active, sh_statax, sh_loctax, sh_notes, sh_country, sh_ccode,
     sh_default, sh_county, sh_custid, sh_email, sh_frid, sh_s3id, sh_webname, sh_webpass, sh_s4id, sh_s5id,
     sh_credlim, sh_pastday, sh_credhld, sh_collect, sh_teid, sh_phext, sh_lastcred, sh_nextact, sh_nextdate,
     sh_exid, sh_dear, sh_said, sh_tranwaid, sh_fcid, sh_pjid, sh_popup, sh_quota, sh_exempt, sh_service,
     sh_exceed, sh_exday, sh_credflag, sh_dgid, sh_psid, sh_poreqd, sh_pomask, sh_waretaxover, sh_shelfpct,
     sh_popupship, sh_dba, sh_trakid, sh_trak2id, sh_shelfdays, sh_sotrakid, sh_prior, sh_crosswaid,
     sh_bomon, sh_bofulltr, sh_bofullpl, sh_botue, sh_bowed, sh_bothu, sh_bofri, sh_bosat, sh_bosun,
     sh_exreserve, sh_routeacct, sh_latitude, sh_longitude, sh_shortship, sh_reqdsdsig, sh_shipzone, sh_reqcpart,
     sh_availall, sh_street3, sh_ccid, sh_prtdgrpto, sh_caid, sh_noinvdflt, sh_noreserve, sh_retattrib1,
     sh_retattrib2, sh_retattrib3, sh_retdates, sh_laststateprint, sh_creddueshipdays, sh_ttid, sh_addressvalid,
     sh_svctype, sh_edishiptopo, sh_edishiptopodays, sh_retainreservedbo, sh_exemptexpires, sh_linkedjobfinish,
     sh_vatid, sh_cyid, sh_serializeonreserve, sh_taxexemptcode)
    VALUES
    (2, 'East Coast Distribution', 0, 0, 0, 0, 0, '200 Harbor Drive', 'Building B', 'Newark', 'NJ', '07101',
     '555-200-2000', '555-200-2001', 'Distribution Mgr', 0, 0, 1, 0, 0, 'East coast hub', 'USA', '',
     0, 'Essex', 'EAST001', 'eastcoast@example.com', 0, 0, '', '', 0, 0,
     0, 0, NULL, '', 0, '', NULL, '', NULL,
     0, '', 0, 0, 0, 0, '', 0, 0, 0,
     0, 0, 0, 0, 0, 0, '', 0, 0,
     '', '', 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 40.7357, -74.1724, '', 0, 'ZONE-E', 0,
     0, '', 0, '', 0, 0, 0, 0,
     0, 0, 0, NULL, 0, 0, NULL,
     '', 0, 0, 0, NULL, '',
     '', 0, 0, '');
    SET IDENTITY_INSERT [dbo].[dmship] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmship] WHERE sh_name = 'West Coast Fulfillment')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmship] ON;
    INSERT INTO [dbo].[dmship]
    (sh_id, sh_name, sh_biid, sh_brid, sh_s1id, sh_s2id, sh_smid, sh_street, sh_street2, sh_city, sh_state, sh_zip,
     sh_phone, sh_fax, sh_contact, sh_trid, sh_waid, sh_active, sh_statax, sh_loctax, sh_notes, sh_country, sh_ccode,
     sh_default, sh_county, sh_custid, sh_email, sh_frid, sh_s3id, sh_webname, sh_webpass, sh_s4id, sh_s5id,
     sh_credlim, sh_pastday, sh_credhld, sh_collect, sh_teid, sh_phext, sh_lastcred, sh_nextact, sh_nextdate,
     sh_exid, sh_dear, sh_said, sh_tranwaid, sh_fcid, sh_pjid, sh_popup, sh_quota, sh_exempt, sh_service,
     sh_exceed, sh_exday, sh_credflag, sh_dgid, sh_psid, sh_poreqd, sh_pomask, sh_waretaxover, sh_shelfpct,
     sh_popupship, sh_dba, sh_trakid, sh_trak2id, sh_shelfdays, sh_sotrakid, sh_prior, sh_crosswaid,
     sh_bomon, sh_bofulltr, sh_bofullpl, sh_botue, sh_bowed, sh_bothu, sh_bofri, sh_bosat, sh_bosun,
     sh_exreserve, sh_routeacct, sh_latitude, sh_longitude, sh_shortship, sh_reqdsdsig, sh_shipzone, sh_reqcpart,
     sh_availall, sh_street3, sh_ccid, sh_prtdgrpto, sh_caid, sh_noinvdflt, sh_noreserve, sh_retattrib1,
     sh_retattrib2, sh_retattrib3, sh_retdates, sh_laststateprint, sh_creddueshipdays, sh_ttid, sh_addressvalid,
     sh_svctype, sh_edishiptopo, sh_edishiptopodays, sh_retainreservedbo, sh_exemptexpires, sh_linkedjobfinish,
     sh_vatid, sh_cyid, sh_serializeonreserve, sh_taxexemptcode)
    VALUES
    (3, 'West Coast Fulfillment', 0, 0, 0, 0, 0, '300 Pacific Way', '', 'Los Angeles', 'CA', '90001',
     '555-300-3000', '555-300-3001', 'Fulfillment Director', 0, 0, 1, 0, 0, 'West coast hub', 'USA', '',
     0, 'Los Angeles', 'WEST001', 'westcoast@example.com', 0, 0, '', '', 0, 0,
     0, 0, NULL, '', 0, '', NULL, '', NULL,
     0, '', 0, 0, 0, 0, '', 0, 0, 0,
     0, 0, 0, 0, 0, 0, '', 0, 0,
     '', '', 0, 0, 0, 0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0, 0,
     0, 0, 34.0522, -118.2437, '', 0, 'ZONE-W', 0,
     0, '', 0, '', 0, 0, 0, 0,
     0, 0, 0, NULL, 0, 0, NULL,
     '', 0, 0, 0, NULL, '',
     '', 0, 0, '');
    SET IDENTITY_INSERT [dbo].[dmship] OFF;
END;

-- ============================================================================
-- 5. WAREHOUSES (dmware)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmware] WHERE wa_name = 'Main Warehouse')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmware] ON;
    INSERT INTO [dbo].[dmware]
    (wa_id, wa_name, wa_active, wa_default, wa_exid, wa_taid1, wa_taid2, wa_neginv, wa_reid, wa_icxfer,
     wa_street, wa_street2, wa_city, wa_state, wa_zip, wa_phone, wa_fax, wa_reqid, wa_psid, wa_markup,
     wa_marktype, wa_biid, wa_ccode, wa_haltposting, wa_lottrackdsd, wa_prodrel, wa_shiponsave, wa_comport,
     wa_baudrate, wa_stopbits, wa_parity, wa_handshake, wa_databits, wa_custfirst, wa_retainicloc,
     wa_finlinkjob, wa_addthandle, wa_emergency, wa_ictautoreceive, wa_cyid, wa_country, wa_gln, wa_fcid,
     wa_tranholdlotcont, wa_overissueprompt, wa_overreserveprompt, wa_wmsincreserve, wa_wmsincissue,
     wa_underissueprompt, wa_restrictop, wa_taxjaroverride, wa_issuinggroupby, wa_ictrecqty,
     wa_linkedsoallocate, wa_splitmrojobs, wa_fedacc, wa_fedpass, wa_fedauth, wa_fedmeternum, wa_fedshipacc,
     wa_fedtest, wa_fedusefacility, wa_upsacc, wa_upspass, wa_upsauthkey, wa_upsshipnum, wa_upstest,
     wa_upsusefacility, wa_ecomminv, wa_ccprocid, wa_taxtype, wa_tjkey, wa_taxuser, wa_taxpass, wa_tjname,
     wa_taxsandboxmode, wa_taxexemptapis, wa_easypostapikey, wa_taxcompcode, wa_shipquan, wa_defissquan,
     wa_fedacclegacy, wa_fedpasslegacy, wa_fedauthlegacy, wa_fedshipacclegacy, wa_fedmeternumlegacy,
     wa_retainlotcost, wa_xfercostexp, wa_recmarkupover)
    VALUES
    (1, 'Main Warehouse', 1, 1, 0, 0, 0, '', 0, 0,
     '100 Industrial Pkwy', '', 'Springfield', 'IL', '62701', '555-100-1000', '555-100-1001', 0, 0, 0.00,
     '', 0, '', 0, 0, '', 0, '',
     '', '', '', '', '', 0, 0,
     0, '', '', 0, 0, 'USA', '', 0,
     0, 0, 0, '', '',
     0, 0, 0, 0, '',
     0, 0, '', '', '', '', '',
     0, 0, '', '', '', '', 0,
     0, 0, 0, '', '', '', '', '',
     0, 0, '', '', '', '',
     '', '', '', '', '',
     0, '', 0);
    SET IDENTITY_INSERT [dbo].[dmware] OFF;
END;

-- ============================================================================
-- 6. BILL-TO CUSTOMERS (dmbill)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmbill] WHERE bi_name = 'Acme Corporation')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmbill] ON;
    INSERT INTO [dbo].[dmbill]
    (bi_id, bi_name, bi_grid, bi_street, bi_street2, bi_city, bi_state, bi_zip, bi_phone, bi_fax, bi_contact,
     bi_credlim, bi_teid, bi_credhld, bi_active, bi_notes, bi_collect, bi_country, bi_ccode, bi_user1, bi_brid, bi_smid,
     bi_s1id, bi_s2id, bi_trid, bi_waid, bi_statax, bi_loctax, bi_highcrd, bi_county, bi_custid, bi_email,
     bi_poreqd, bi_frid, bi_pastday, bi_service, bi_s3id, bi_webname, bi_webpass, bi_backord, bi_dba, bi_s4id,
     bi_s5id, bi_credmast, bi_phext, bi_lastcred, bi_nextact, bi_nextdate, bi_exid, bi_dear, bi_said, bi_fcid, bi_popup, bi_invdest,
     bi_statedest, bi_psid, bi_quota, bi_exempt, bi_exceed, bi_exday, bi_credflag, bi_dgid, bi_pomask,
     bi_shelfpct, bi_archid, bi_mobileid, bi_popupship, bi_trakid, bi_trak2id, bi_shelfdays, bi_pfuser,
     bi_sotrakid, bi_posprice, bi_exreserve, bi_routeacct, bi_shortship, bi_pfid, bi_nopospay, bi_reqcpart,
     bi_availall, bi_street3, bi_ccid, bi_caid, bi_pdid, bi_restrictshipfrom, bi_noinvdflt, bi_rebill,
     bi_rebillworkflow, bi_shortpayprid, bi_noreserve, bi_cardvaultid, bi_retattrib1, bi_retattrib2,
     bi_retattrib3, bi_retdates, bi_laststateprint, bi_creddueshipdays, bi_ttid, bi_addressvalid, bi_edibilltopo, bi_edibilltopodays, bi_c3id,
     bi_emailtype, bi_linkedjobfinish, bi_vatid, bi_cyid, bi_serializeonreserve, bi_invoiceemail, bi_statementemail, bi_baid, bi_ccproccontactid)
    VALUES
    (1, 'Acme Corporation', 0, '500 Business Park Dr', '', 'Chicago', 'IL', '60601', '555-500-5000', '555-500-5001', 'Jane Buyer',
     50000, 0, NULL, 1, '', '', 'USA', '', '', 0, 0,
     0, 0, 0, 0, 0, 0, 0.00, '', 'ACME-BILL', 'billing@acme.com',
     0, 0, 0, 0, 0, '', '', 0, '', 0,
     0, 0, '', NULL, '', NULL, 0, '', 0, 0, '', '',
     '', 0, 0.00, 0, 0.00, 0, 0, 0, '',
     0.00, 0, 0, '', 0, 0, 0, '',
     0, 0, 0, 0, '', 0, 0, 0,
     0, '', 0, 0, 0, 0, 0, 0,
     0, 0, 0, '', 0, 0,
     0, 0, NULL, 0, 0, NULL, 0, 0, 0,
     '', '', '', 0, 0, '', '', 0, '');
    SET IDENTITY_INSERT [dbo].[dmbill] OFF;
END;

-- ============================================================================
-- 7. SALES ORDERS (dtord)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[dtord] WHERE or_ordnum = 1001)
BEGIN
    SET IDENTITY_INSERT [dbo].[dtord] ON;
    INSERT INTO [dbo].[dtord]
    (or_id, or_ordnum, or_linenum, or_chid, or_cogsid, or_prid, or_quant, or_qship, or_price, or_exten,
     or_notes, or_taxable, or_stocked, or_control, or_wanted, or_promise, or_dueship, or_confirm, or_expires,
     or_jobnum, or_user1, or_prunid, or_prfact, or_unitwgt,
     or_taid, or_unitcos, or_subtot, or_discoun, or_tally, or_lispric, or_stantot, or_purnum, or_loadcos,
     or_prictyp, or_phid, or_salunid, or_salfact, or_release, or_toid, or_special, or_tranrecv, or_feattree, or_override,
     or_origprice, or_dealpric, or_avgcost, or_cuid, or_linedisc, or_origprod, or_sizeprod, or_quotedcost,
     or_catchwgt, or_blanket, or_blanketid, or_inclfeat, or_featpric, or_pmid, or_pmfact, or_p4id, or_noinv,
     or_ordquant, or_shipquant, or_duedock, or_rtid, or_dockmins, or_tarewgt, or_packages, or_cogsdelta, or_frtcost,
     or_overridedate, or_overrideuser, or_priceordnum, or_planquant, or_qplan, or_totalorder, or_scid, or_siid, or_backquant,
     or_autoaddfreight, or_discountid, or_noreserve, or_commable, or_promoamt, or_poallocatable, or_pickunit,
     or_linejob, or_repack, or_shid, or_masterorid, or_trid, or_frid, or_doid, or_actualfrtcost, or_gcid,
     or_vaid, or_laborcogsid, or_burdencogsid, or_pricefactor)
    VALUES
    (1, 1001, 1, 0, 0, 1, 10.0, 0.0, 29.99, 299.90,
     'Sample order line', 1, 1, 0, NULL, NULL, NULL, NULL, NULL,
     0, '', 1, 1.0, 0.5,
     0, 0.0, 0, 0, '', 29.99, 0.0, 0, 0.0,
     'Standard', 0, 0, 1.0, NULL, 0, 0, 0.0, '', 0,
     29.99, 29.99, 0.0, 0, 0.0, 0, 0, 0.0,
     0.0, 0.0, 0, 0, 0.0, 0, 0.0, 0, 0,
     10.0, 0.0, NULL, 0, 0.0, 0.0, '', 0.0, 0.0,
     NULL, '', 0, 0.0, 0.0, 0, 0, 0, 0.0,
     0, 0, 0, 0, 0.0, 0, 0,
     0, 0, 0, 0, 0, 0, 0, 0.0, 0,
     0, 0, 0, 0.0);
    SET IDENTITY_INSERT [dbo].[dtord] OFF;
END;

-- ============================================================================
-- 8. CARRIERS/TRUCKING (dmtruk) - All NOT NULL columns required
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmtruk] WHERE tr_name = 'UPS')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmtruk] ON;
    INSERT INTO [dbo].[dmtruk]
    (tr_id, tr_name, tr_active, tr_default, tr_contact, tr_street, tr_street2, tr_city, tr_state, tr_zip,
     tr_phone, tr_fax, tr_email, tr_maxwgt, tr_ccode, tr_svctype, tr_loadunid, tr_loadsize, tr_splitload, tr_carcode,
     tr_veid, tr_cyid, tr_packinstreq, tr_picktime, tr_pickday, tr_shipday, tr_delday, tr_minord, tr_labor, tr_burden,
     tr_approvalreq, tr_dsdinvsync, tr_dsdinvsyncloc, tr_svcprovider, tr_shipdays, tr_deliverydays, tr_splitloadsize,
     tr_country, tr_deliverto, tr_dsdloid, tr_dsdchid, tr_ordtype)
    VALUES
    (1, 'UPS', 1, 1, 'UPS Support', '', '', '', '', '', '1-800-742-5877', '', 'support@ups.com', 150, '', 'Ground', 0, 0, 0, 'UPS',
     0, 0, 0, 0, '', '', '', 0, 0, 0,
     0, 0, 0, '', 1, 1, '',
     'USA', 0, 0, 0, '');
    SET IDENTITY_INSERT [dbo].[dmtruk] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmtruk] WHERE tr_name = 'FedEx')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmtruk] ON;
    INSERT INTO [dbo].[dmtruk]
    (tr_id, tr_name, tr_active, tr_default, tr_contact, tr_street, tr_street2, tr_city, tr_state, tr_zip,
     tr_phone, tr_fax, tr_email, tr_maxwgt, tr_ccode, tr_svctype, tr_loadunid, tr_loadsize, tr_splitload, tr_carcode,
     tr_veid, tr_cyid, tr_packinstreq, tr_picktime, tr_pickday, tr_shipday, tr_delday, tr_minord, tr_labor, tr_burden,
     tr_approvalreq, tr_dsdinvsync, tr_dsdinvsyncloc, tr_svcprovider, tr_shipdays, tr_deliverydays, tr_splitloadsize,
     tr_country, tr_deliverto, tr_dsdloid, tr_dsdchid, tr_ordtype)
    VALUES
    (2, 'FedEx', 1, 0, 'FedEx Support', '', '', '', '', '', '1-800-463-3339', '', 'support@fedex.com', 150, '', 'Ground', 0, 0, 0, 'FEDEX',
     0, 0, 0, 0, '', '', '', 0, 0, 0,
     0, 0, 0, '', 2, 2, '',
     'USA', 0, 0, 0, '');
    SET IDENTITY_INSERT [dbo].[dmtruk] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [dbo].[dmtruk] WHERE tr_name = 'Local Delivery')
BEGIN
    SET IDENTITY_INSERT [dbo].[dmtruk] ON;
    INSERT INTO [dbo].[dmtruk]
    (tr_id, tr_name, tr_active, tr_default, tr_contact, tr_street, tr_street2, tr_city, tr_state, tr_zip,
     tr_phone, tr_fax, tr_email, tr_maxwgt, tr_ccode, tr_svctype, tr_loadunid, tr_loadsize, tr_splitload, tr_carcode,
     tr_veid, tr_cyid, tr_packinstreq, tr_picktime, tr_pickday, tr_shipday, tr_delday, tr_minord, tr_labor, tr_burden,
     tr_approvalreq, tr_dsdinvsync, tr_dsdinvsyncloc, tr_svcprovider, tr_shipdays, tr_deliverydays, tr_splitloadsize,
     tr_country, tr_deliverto, tr_dsdloid, tr_dsdchid, tr_ordtype)
    VALUES
    (3, 'Local Delivery', 1, 0, 'Local Fleet', '', '', '', '', '', '555-LOCAL', '', '', 500, '', 'Local', 0, 0, 0, 'LOCAL',
     0, 0, 0, 0, '', '', '', 0, 0, 0,
     0, 0, 0, '', 0, 0, '',
     'USA', 0, 0, 0, '');
    SET IDENTITY_INSERT [dbo].[dmtruk] OFF;
END;

-- ============================================================================
-- 9. SALES ORDER HEADERS (dttord) - FOR ALLOCATION TESTING
-- All NOT NULL columns must be included
-- ============================================================================
PRINT '';
PRINT '========== LOADING ALLOCATION ORDER HEADERS (dttord) ==========';

-- Clear existing test orders (all allocation test orders)
DELETE FROM [dbo].[dttord] WHERE to_ordnum BETWEEN 50001 AND 50999;

-- Order 50001: CPFG (waid=3) - Not allocated, ready for allocation
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50001, 's', 1, 1, 0, 0, 0, 0,
 0, 'PO-ALLOC-001', '', 1, 0, 1500.00, 0.00, 'Allocation Test - Not Allocated', '',
 3, 1, 'Test Order 50001', 0, '', 0, 0, 0, 0,
 0, '2026-02-02', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '08:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

-- Order 50002: CPFG (waid=3) - Partially allocated (will have some gai_allocate records)
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50002, 's', 1, 1, 0, 0, 0, 0,
 0, 'PO-ALLOC-002', '', 2, 0, 2000.00, 0.00, 'Allocation Test - Partially Allocated', '',
 3, 1, 'Test Order 50002', 0, '', 0, 0, 0, 0,
 0, '2026-02-02', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '09:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

-- Order 50003: CPFG (waid=3) - Fully allocated
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50003, 's', 1, 1, 0, 0, 0, 0,
 0, 'PO-ALLOC-003', '', 1, 0, 1000.00, 0.00, 'Allocation Test - Fully Allocated', '',
 3, 1, 'Test Order 50003', 0, '', 0, 0, 0, 0,
 0, '2026-02-02', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '10:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

-- Order 50004: CPFG (waid=3) - Credit Hold (Terms ID 51), balance exceeds 3% tolerance
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50004, 's', 1, 1, 0, 0, 0, 0,
 0, 'PO-ALLOC-004', '', 1, 51, 1000.00, 500.00, 'Allocation Test - Credit Hold (50% balance > 3%)', '',
 3, 1, 'Test Order 50004 - CREDIT HOLD', 0, '', 0, 0, 0, 0,
 0, '2026-02-02', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '11:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

-- Order 50005: Northlake (waid=92) - Ready for allocation
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50005, 's', 1, 2, 0, 0, 0, 0,
 0, 'PO-ALLOC-005', '', 2, 0, 1800.00, 0.00, 'Allocation Test - Northlake', '',
 92, 1, 'Test Order 50005 - Northlake', 0, '', 0, 0, 0, 0,
 0, '2026-02-02', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '12:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

-- Order 50006: CPFG (waid=3) - Tomorrow's order (2026-02-03)
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50006, 's', 1, 1, 0, 0, 0, 0,
 0, 'PO-ALLOC-006', '', 1, 0, 2500.00, 0.00, 'Allocation Test - Tomorrow', '',
 3, 1, 'Test Order 50006 - Tomorrow', 0, '', 0, 0, 0, 0,
 0, '2026-02-03', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '08:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

-- ============================================================================
-- HISTORICAL ORDERS (2026-01-20 to 2026-02-01) - Sample orders per day
-- Uses full column list required by dttord NOT NULL constraints
-- ============================================================================

-- Define column list as reference (matches working order 50001 format)
-- to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
-- to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
-- to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
-- to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
-- to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
-- to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
-- to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
-- to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
-- to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
-- to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
-- to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid

-- 2026-01-27: CPFG order (Monday)
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50171, 's', 1, 1, 0, 0, 0, 0,
 0, 'PO-0127-001', '', 1, 0, 3200.00, 0.00, 'Jan 27 Order 1', '',
 3, 1, 'Order 50171', 0, '', 0, 0, 0, 0,
 0, '2026-01-27', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '07:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

-- 2026-01-28: Northlake order
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50182, 's', 1, 2, 0, 0, 0, 0,
 0, 'PO-0128-002', '', 2, 0, 2400.00, 0.00, 'Jan 28 Order - Northlake', '',
 92, 1, 'Order 50182 - Northlake', 0, '', 0, 0, 0, 0,
 0, '2026-01-28', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '09:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

-- 2026-01-30: CPFG order
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50201, 's', 1, 1, 0, 0, 0, 0,
 0, 'PO-0130-001', '', 1, 0, 1950.00, 0.00, 'Jan 30 Order 1', '',
 3, 1, 'Order 50201', 0, '', 0, 0, 0, 0,
 0, '2026-01-30', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '07:30:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

-- 2026-02-01: CPFG and Northlake orders
INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50221, 's', 1, 1, 0, 0, 0, 0,
 0, 'PO-0201-001', '', 1, 0, 1800.00, 0.00, 'Feb 1 Order 1', '',
 3, 1, 'Order 50221', 0, '', 0, 0, 0, 0,
 0, '2026-02-01', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '08:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

INSERT INTO [dbo].[dttord]
(to_ordnum, to_ordtype, to_biid, to_shid, to_smid, to_brid, to_s1id, to_s2id,
 to_grid, to_billpo, to_shippo, to_trid, to_teid, to_totdue, to_balance, to_notes, to_confirm,
 to_waid, to_header, to_descrip, to_prognum, to_user1, to_linkto, to_frid, to_flush, to_trakid,
 to_trak2id, to_dueship, to_archid, to_discoun, to_remarks, to_history, to_usid, to_trid2, to_prepay,
 to_s3id, to_statax, to_loctax, to_sgid, to_prior, to_s4id, to_s5id, to_deltime, to_status, to_savetime,
 to_minquan, to_tranwaid, to_fcid, to_fcrate, to_totwgt, to_pjid, to_saletax, to_cashsale, to_overcred,
 to_tendered, to_paysched, to_distance, to_auid, to_signature, to_dgid, to_psid, to_crosswaid, to_ccauth,
 to_authorize, to_authc3id, to_fcrate2, to_cpid, to_intransit, to_facilitypricing, to_pickuptime, to_cclast4,
 to_doid, to_trandoid, to_tottare, to_shipfromid, to_said, to_stagcnt, to_frominvjobnum, to_coid,
 to_recurtype, to_recurinterval, to_cardtoken, to_seasonal, to_easypostrateid, to_ccinvnum, to_masterordnum,
 to_rgid, to_ttid, to_ruid, to_groupnum, to_lastusid)
VALUES
(50223, 's', 1, 2, 0, 0, 0, 0,
 0, 'PO-0201-003', '', 1, 0, 1650.00, 0.00, 'Feb 1 Order 3 - Northlake', '',
 92, 1, 'Order 50223 - Northlake', 0, '', 0, 0, 0, 0,
 0, '2026-02-01', 0, 0.00, '', '', 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 'C', '10:00:00',
 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, '', 0, 0, '', 0, 0, 0, '',
 0, 0, 0, 0, '', 0, 0, '',
 0, 0, 0, 0, 0, 0, 0, 0,
 '', 0, '', 0, '', '', 0,
 0, 0, 0, 0, 0);

PRINT 'Inserted orders into dttord:';
PRINT '  - 50001-50006: Core test orders (2026-02-02 and 2026-02-03)';
PRINT '  - 50171, 50182, 50201, 50221, 50223: Sample historical orders (2026-01-27 to 2026-02-01)';
PRINT '  - Total: 11 orders across CPFG (waid=3) and Northlake (waid=92)';

-- ============================================================================
-- 10. SALES ORDER LINES (dtord) - FOR ALLOCATION TESTING
-- ============================================================================
PRINT '';
PRINT '========== LOADING ALLOCATION ORDER LINES (dtord) ==========';

-- Get the to_id values for our test orders
DECLARE @to_id_50001 INT, @to_id_50002 INT, @to_id_50003 INT, @to_id_50004 INT, @to_id_50005 INT, @to_id_50006 INT;
SELECT @to_id_50001 = to_id FROM dttord WHERE to_ordnum = 50001;
SELECT @to_id_50002 = to_id FROM dttord WHERE to_ordnum = 50002;
SELECT @to_id_50003 = to_id FROM dttord WHERE to_ordnum = 50003;
SELECT @to_id_50004 = to_id FROM dttord WHERE to_ordnum = 50004;
SELECT @to_id_50005 = to_id FROM dttord WHERE to_ordnum = 50005;
SELECT @to_id_50006 = to_id FROM dttord WHERE to_ordnum = 50006;

-- Clear existing test order lines
DELETE FROM [dbo].[dtord] WHERE or_ordnum IN (50001, 50002, 50003, 50004, 50005, 50006);

-- Order 50001 lines (Not allocated - 2 products)
INSERT INTO [dbo].[dtord]
(or_ordnum, or_linenum, or_chid, or_cogsid, or_prid, or_quant, or_qship, or_price, or_exten,
 or_notes, or_taxable, or_stocked, or_control, or_jobnum, or_user1, or_prunid, or_prfact, or_unitwgt,
 or_taid, or_unitcos, or_subtot, or_discoun, or_tally, or_lispric, or_stantot, or_purnum, or_loadcos,
 or_prictyp, or_phid, or_salunid, or_salfact, or_toid, or_special, or_tranrecv, or_feattree, or_override,
 or_origprice, or_dealpric, or_avgcost, or_cuid, or_linedisc, or_origprod, or_sizeprod, or_quotedcost,
 or_catchwgt, or_blanket, or_blanketid, or_inclfeat, or_featpric, or_pmid, or_pmfact, or_p4id, or_noinv,
 or_ordquant, or_shipquant, or_rtid, or_dockmins, or_tarewgt, or_packages, or_cogsdelta, or_frtcost,
 or_priceordnum, or_planquant, or_qplan, or_totalorder, or_scid, or_siid, or_backquant,
 or_autoaddfreight, or_discountid, or_noreserve, or_commable, or_promoamt, or_poallocatable, or_pickunit,
 or_linejob, or_repack, or_shid, or_masterorid, or_trid, or_frid, or_doid, or_actualfrtcost, or_gcid,
 or_vaid, or_laborcogsid, or_burdencogsid, or_pricefactor)
VALUES
(50001, 1, 0, 0, 1, 100.0, 0.0, 29.99, 2999.00,
 'WIDGET-A line', 1, 1, 0, 0, '', 1, 1.0, 0.5,
 0, 15.00, 0, 0, '', 29.99, 0.0, 0, 0.0,
 'Standard', 0, 0, 1.0, @to_id_50001, 0, 0.0, '', 0,
 29.99, 29.99, 15.0, 0, 0.0, 0, 0, 0.0,
 0.0, 0.0, 0, 0, 0.0, 0, 0.0, 0, 0,
 100.0, 0.0, 0, 0.0, 0.0, '', 0.0, 0.0,
 0, 0.0, 0.0, 0, 0, 0, 0.0,
 0, 0, 0, 0, 0.0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0.0, 0,
 0, 0, 0, 0.0),
(50001, 2, 0, 0, 2, 50.0, 0.0, 149.99, 7499.50,
 'GADGET-PRO line', 1, 1, 0, 0, '', 1, 1.0, 1.2,
 0, 75.00, 0, 0, '', 149.99, 0.0, 0, 0.0,
 'Standard', 0, 0, 1.0, @to_id_50001, 0, 0.0, '', 0,
 149.99, 149.99, 75.0, 0, 0.0, 0, 0, 0.0,
 0.0, 0.0, 0, 0, 0.0, 0, 0.0, 0, 0,
 50.0, 0.0, 0, 0.0, 0.0, '', 0.0, 0.0,
 0, 0.0, 0.0, 0, 0, 0, 0.0,
 0, 0, 0, 0, 0.0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0.0, 0,
 0, 0, 0, 0.0);

-- Order 50002 lines (Partially allocated - 2 products, 1 allocated)
INSERT INTO [dbo].[dtord]
(or_ordnum, or_linenum, or_chid, or_cogsid, or_prid, or_quant, or_qship, or_price, or_exten,
 or_notes, or_taxable, or_stocked, or_control, or_jobnum, or_user1, or_prunid, or_prfact, or_unitwgt,
 or_taid, or_unitcos, or_subtot, or_discoun, or_tally, or_lispric, or_stantot, or_purnum, or_loadcos,
 or_prictyp, or_phid, or_salunid, or_salfact, or_toid, or_special, or_tranrecv, or_feattree, or_override,
 or_origprice, or_dealpric, or_avgcost, or_cuid, or_linedisc, or_origprod, or_sizeprod, or_quotedcost,
 or_catchwgt, or_blanket, or_blanketid, or_inclfeat, or_featpric, or_pmid, or_pmfact, or_p4id, or_noinv,
 or_ordquant, or_shipquant, or_rtid, or_dockmins, or_tarewgt, or_packages, or_cogsdelta, or_frtcost,
 or_priceordnum, or_planquant, or_qplan, or_totalorder, or_scid, or_siid, or_backquant,
 or_autoaddfreight, or_discountid, or_noreserve, or_commable, or_promoamt, or_poallocatable, or_pickunit,
 or_linejob, or_repack, or_shid, or_masterorid, or_trid, or_frid, or_doid, or_actualfrtcost, or_gcid,
 or_vaid, or_laborcogsid, or_burdencogsid, or_pricefactor)
VALUES
(50002, 1, 0, 0, 1, 200.0, 0.0, 29.99, 5998.00,
 'WIDGET-A line - allocated', 1, 1, 0, 0, '', 1, 1.0, 0.5,
 0, 15.00, 0, 0, '', 29.99, 0.0, 0, 0.0,
 'Standard', 0, 0, 1.0, @to_id_50002, 0, 0.0, '', 0,
 29.99, 29.99, 15.0, 0, 0.0, 0, 0, 0.0,
 0.0, 0.0, 0, 0, 0.0, 0, 0.0, 0, 0,
 200.0, 0.0, 0, 0.0, 0.0, '', 0.0, 0.0,
 0, 0.0, 0.0, 0, 0, 0, 0.0,
 0, 0, 0, 0, 0.0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0.0, 0,
 0, 0, 0, 0.0),
(50002, 2, 0, 0, 2, 30.0, 0.0, 149.99, 4499.70,
 'GADGET-PRO line - NOT allocated', 1, 1, 0, 0, '', 1, 1.0, 1.2,
 0, 75.00, 0, 0, '', 149.99, 0.0, 0, 0.0,
 'Standard', 0, 0, 1.0, @to_id_50002, 0, 0.0, '', 0,
 149.99, 149.99, 75.0, 0, 0.0, 0, 0, 0.0,
 0.0, 0.0, 0, 0, 0.0, 0, 0.0, 0, 0,
 30.0, 0.0, 0, 0.0, 0.0, '', 0.0, 0.0,
 0, 0.0, 0.0, 0, 0, 0, 0.0,
 0, 0, 0, 0, 0.0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0.0, 0,
 0, 0, 0, 0.0);

-- Order 50003 lines (Fully allocated - 1 product)
INSERT INTO [dbo].[dtord]
(or_ordnum, or_linenum, or_chid, or_cogsid, or_prid, or_quant, or_qship, or_price, or_exten,
 or_notes, or_taxable, or_stocked, or_control, or_jobnum, or_user1, or_prunid, or_prfact, or_unitwgt,
 or_taid, or_unitcos, or_subtot, or_discoun, or_tally, or_lispric, or_stantot, or_purnum, or_loadcos,
 or_prictyp, or_phid, or_salunid, or_salfact, or_toid, or_special, or_tranrecv, or_feattree, or_override,
 or_origprice, or_dealpric, or_avgcost, or_cuid, or_linedisc, or_origprod, or_sizeprod, or_quotedcost,
 or_catchwgt, or_blanket, or_blanketid, or_inclfeat, or_featpric, or_pmid, or_pmfact, or_p4id, or_noinv,
 or_ordquant, or_shipquant, or_rtid, or_dockmins, or_tarewgt, or_packages, or_cogsdelta, or_frtcost,
 or_priceordnum, or_planquant, or_qplan, or_totalorder, or_scid, or_siid, or_backquant,
 or_autoaddfreight, or_discountid, or_noreserve, or_commable, or_promoamt, or_poallocatable, or_pickunit,
 or_linejob, or_repack, or_shid, or_masterorid, or_trid, or_frid, or_doid, or_actualfrtcost, or_gcid,
 or_vaid, or_laborcogsid, or_burdencogsid, or_pricefactor)
VALUES
(50003, 1, 0, 0, 1, 150.0, 0.0, 29.99, 4498.50,
 'WIDGET-A line - fully allocated', 1, 1, 0, 0, '', 1, 1.0, 0.5,
 0, 15.00, 0, 0, '', 29.99, 0.0, 0, 0.0,
 'Standard', 0, 0, 1.0, @to_id_50003, 0, 0.0, '', 0,
 29.99, 29.99, 15.0, 0, 0.0, 0, 0, 0.0,
 0.0, 0.0, 0, 0, 0.0, 0, 0.0, 0, 0,
 150.0, 0.0, 0, 0.0, 0.0, '', 0.0, 0.0,
 0, 0.0, 0.0, 0, 0, 0, 0.0,
 0, 0, 0, 0, 0.0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0.0, 0,
 0, 0, 0, 0.0);

-- Order 50005 lines (Northlake - 1 product)
INSERT INTO [dbo].[dtord]
(or_ordnum, or_linenum, or_chid, or_cogsid, or_prid, or_quant, or_qship, or_price, or_exten,
 or_notes, or_taxable, or_stocked, or_control, or_jobnum, or_user1, or_prunid, or_prfact, or_unitwgt,
 or_taid, or_unitcos, or_subtot, or_discoun, or_tally, or_lispric, or_stantot, or_purnum, or_loadcos,
 or_prictyp, or_phid, or_salunid, or_salfact, or_toid, or_special, or_tranrecv, or_feattree, or_override,
 or_origprice, or_dealpric, or_avgcost, or_cuid, or_linedisc, or_origprod, or_sizeprod, or_quotedcost,
 or_catchwgt, or_blanket, or_blanketid, or_inclfeat, or_featpric, or_pmid, or_pmfact, or_p4id, or_noinv,
 or_ordquant, or_shipquant, or_rtid, or_dockmins, or_tarewgt, or_packages, or_cogsdelta, or_frtcost,
 or_priceordnum, or_planquant, or_qplan, or_totalorder, or_scid, or_siid, or_backquant,
 or_autoaddfreight, or_discountid, or_noreserve, or_commable, or_promoamt, or_poallocatable, or_pickunit,
 or_linejob, or_repack, or_shid, or_masterorid, or_trid, or_frid, or_doid, or_actualfrtcost, or_gcid,
 or_vaid, or_laborcogsid, or_burdencogsid, or_pricefactor)
VALUES
(50005, 1, 0, 0, 1, 80.0, 0.0, 29.99, 2399.20,
 'WIDGET-A line - Northlake', 1, 1, 0, 0, '', 1, 1.0, 0.5,
 0, 15.00, 0, 0, '', 29.99, 0.0, 0, 0.0,
 'Standard', 0, 0, 1.0, @to_id_50005, 0, 0.0, '', 0,
 29.99, 29.99, 15.0, 0, 0.0, 0, 0, 0.0,
 0.0, 0.0, 0, 0, 0.0, 0, 0.0, 0, 0,
 80.0, 0.0, 0, 0.0, 0.0, '', 0.0, 0.0,
 0, 0.0, 0.0, 0, 0, 0, 0.0,
 0, 0, 0, 0, 0.0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0.0, 0,
 0, 0, 0, 0.0);

-- Order 50006 lines (Tomorrow's order)
INSERT INTO [dbo].[dtord]
(or_ordnum, or_linenum, or_chid, or_cogsid, or_prid, or_quant, or_qship, or_price, or_exten,
 or_notes, or_taxable, or_stocked, or_control, or_jobnum, or_user1, or_prunid, or_prfact, or_unitwgt,
 or_taid, or_unitcos, or_subtot, or_discoun, or_tally, or_lispric, or_stantot, or_purnum, or_loadcos,
 or_prictyp, or_phid, or_salunid, or_salfact, or_toid, or_special, or_tranrecv, or_feattree, or_override,
 or_origprice, or_dealpric, or_avgcost, or_cuid, or_linedisc, or_origprod, or_sizeprod, or_quotedcost,
 or_catchwgt, or_blanket, or_blanketid, or_inclfeat, or_featpric, or_pmid, or_pmfact, or_p4id, or_noinv,
 or_ordquant, or_shipquant, or_rtid, or_dockmins, or_tarewgt, or_packages, or_cogsdelta, or_frtcost,
 or_priceordnum, or_planquant, or_qplan, or_totalorder, or_scid, or_siid, or_backquant,
 or_autoaddfreight, or_discountid, or_noreserve, or_commable, or_promoamt, or_poallocatable, or_pickunit,
 or_linejob, or_repack, or_shid, or_masterorid, or_trid, or_frid, or_doid, or_actualfrtcost, or_gcid,
 or_vaid, or_laborcogsid, or_burdencogsid, or_pricefactor)
VALUES
(50006, 1, 0, 0, 1, 250.0, 0.0, 29.99, 7497.50,
 'WIDGET-A line - Tomorrow', 1, 1, 0, 0, '', 1, 1.0, 0.5,
 0, 15.00, 0, 0, '', 29.99, 0.0, 0, 0.0,
 'Standard', 0, 0, 1.0, @to_id_50006, 0, 0.0, '', 0,
 29.99, 29.99, 15.0, 0, 0.0, 0, 0, 0.0,
 0.0, 0.0, 0, 0, 0.0, 0, 0.0, 0, 0,
 250.0, 0.0, 0, 0.0, 0.0, '', 0.0, 0.0,
 0, 0.0, 0.0, 0, 0, 0, 0.0,
 0, 0, 0, 0, 0.0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0.0, 0,
 0, 0, 0, 0.0);

PRINT 'Inserted order lines for allocation testing';

-- ============================================================================
-- 11. INVENTORY LOTS FOR FIFO ALLOCATION (dtfifo)
-- ============================================================================
PRINT '';
PRINT '========== LOADING FIFO INVENTORY LOTS =========='

-- Clear existing test lots
DELETE FROM [dbo].[dtfifo] WHERE fi_userlot LIKE 'ALLOC-TEST-%';

-- Insert inventory lots for FIFO allocation testing
-- Lot 1: WIDGET-A, oldest receipt date (should be allocated first)
INSERT INTO [dbo].[dtfifo] (
    fi_date, fi_lotdate, fi_lotnum, fi_userlot, fi_prid, fi_zeroed,
    fi_quant, fi_balance, fi_cost, fi_postref, fi_action, fi_loc,
    fi_allonum, fi_type, fi_group, fi_waid, fi_chid, fi_orid,
    fi_exten, fi_catchwgt, fi_serial, fi_expires, fi_invcost,
    fi_attrib1, fi_attrib2, fi_attrib3, fi_descrip, fi_q4group, fi_qc
) VALUES (
    DATEADD(DAY, -60, GETDATE()), DATEADD(DAY, -60, GETDATE()), 1001, 'ALLOC-TEST-001', 1, NULL,
    500, 500, 15.00, 'PO-1001', 'RECEIVE', '01-A-01',
    0, '', 0, 3, 0, 0,
    7500.00, 0, '', DATEADD(DAY, 90, GETDATE()), 15.00,
    '', '', '', 'Premium Widget Type A', 0, ''
);

-- Lot 2: WIDGET-A, newer receipt date, expiring sooner
INSERT INTO [dbo].[dtfifo] (
    fi_date, fi_lotdate, fi_lotnum, fi_userlot, fi_prid, fi_zeroed,
    fi_quant, fi_balance, fi_cost, fi_postref, fi_action, fi_loc,
    fi_allonum, fi_type, fi_group, fi_waid, fi_chid, fi_orid,
    fi_exten, fi_catchwgt, fi_serial, fi_expires, fi_invcost,
    fi_attrib1, fi_attrib2, fi_attrib3, fi_descrip, fi_q4group, fi_qc
) VALUES (
    DATEADD(DAY, -30, GETDATE()), DATEADD(DAY, -30, GETDATE()), 1002, 'ALLOC-TEST-002', 1, NULL,
    300, 300, 15.50, 'PO-1002', 'RECEIVE', '01-A-02',
    0, '', 0, 3, 0, 0,
    4650.00, 0, '', DATEADD(DAY, 45, GETDATE()), 15.50,
    '', '', '', 'Premium Widget Type A', 0, ''
);

-- Lot 3: WIDGET-A, newest receipt, expiring later (should be allocated last)
INSERT INTO [dbo].[dtfifo] (
    fi_date, fi_lotdate, fi_lotnum, fi_userlot, fi_prid, fi_zeroed,
    fi_quant, fi_balance, fi_cost, fi_postref, fi_action, fi_loc,
    fi_allonum, fi_type, fi_group, fi_waid, fi_chid, fi_orid,
    fi_exten, fi_catchwgt, fi_serial, fi_expires, fi_invcost,
    fi_attrib1, fi_attrib2, fi_attrib3, fi_descrip, fi_q4group, fi_qc
) VALUES (
    DATEADD(DAY, -10, GETDATE()), DATEADD(DAY, -10, GETDATE()), 1003, 'ALLOC-TEST-003', 1, NULL,
    200, 200, 16.00, 'PO-1003', 'RECEIVE', '01-A-03',
    0, '', 0, 3, 0, 0,
    3200.00, 0, '', DATEADD(DAY, 120, GETDATE()), 16.00,
    '', '', '', 'Premium Widget Type A', 0, ''
);

-- Lot 4: WIDGET-A, expiring within 30 days (should be excluded by shelf-life validation)
INSERT INTO [dbo].[dtfifo] (
    fi_date, fi_lotdate, fi_lotnum, fi_userlot, fi_prid, fi_zeroed,
    fi_quant, fi_balance, fi_cost, fi_postref, fi_action, fi_loc,
    fi_allonum, fi_type, fi_group, fi_waid, fi_chid, fi_orid,
    fi_exten, fi_catchwgt, fi_serial, fi_expires, fi_invcost,
    fi_attrib1, fi_attrib2, fi_attrib3, fi_descrip, fi_q4group, fi_qc
) VALUES (
    DATEADD(DAY, -90, GETDATE()), DATEADD(DAY, -90, GETDATE()), 1004, 'ALLOC-TEST-004', 1, NULL,
    100, 100, 14.00, 'PO-1004', 'RECEIVE', '01-A-04',
    0, '', 0, 3, 0, 0,
    1400.00, 0, '', DATEADD(DAY, 15, GETDATE()), 14.00,
    '', '', '', 'Premium Widget Type A - EXPIRING SOON', 0, ''
);

-- Lot 5: GADGET-PRO at CPFG warehouse
INSERT INTO [dbo].[dtfifo] (
    fi_date, fi_lotdate, fi_lotnum, fi_userlot, fi_prid, fi_zeroed,
    fi_quant, fi_balance, fi_cost, fi_postref, fi_action, fi_loc,
    fi_allonum, fi_type, fi_group, fi_waid, fi_chid, fi_orid,
    fi_exten, fi_catchwgt, fi_serial, fi_expires, fi_invcost,
    fi_attrib1, fi_attrib2, fi_attrib3, fi_descrip, fi_q4group, fi_qc
) VALUES (
    DATEADD(DAY, -45, GETDATE()), DATEADD(DAY, -45, GETDATE()), 2001, 'ALLOC-TEST-005', 2, NULL,
    150, 150, 75.00, 'PO-2001', 'RECEIVE', '02-B-01',
    0, '', 0, 3, 0, 0,
    11250.00, 0, '', DATEADD(DAY, 180, GETDATE()), 75.00,
    '', '', '', 'Professional Gadget Series', 0, ''
);

-- Lot 6: WIDGET-A at Northlake warehouse (WID=92)
INSERT INTO [dbo].[dtfifo] (
    fi_date, fi_lotdate, fi_lotnum, fi_userlot, fi_prid, fi_zeroed,
    fi_quant, fi_balance, fi_cost, fi_postref, fi_action, fi_loc,
    fi_allonum, fi_type, fi_group, fi_waid, fi_chid, fi_orid,
    fi_exten, fi_catchwgt, fi_serial, fi_expires, fi_invcost,
    fi_attrib1, fi_attrib2, fi_attrib3, fi_descrip, fi_q4group, fi_qc
) VALUES (
    DATEADD(DAY, -20, GETDATE()), DATEADD(DAY, -20, GETDATE()), 3001, 'ALLOC-TEST-006', 1, NULL,
    400, 400, 15.25, 'PO-3001', 'RECEIVE', '01-C-01',
    0, '', 0, 92, 0, 0,
    6100.00, 0, '', DATEADD(DAY, 100, GETDATE()), 15.25,
    '', '', '', 'Premium Widget Type A - Northlake', 0, ''
);

-- Lot 7: Staging inventory (should be excluded - type = 'staging')
INSERT INTO [dbo].[dtfifo] (
    fi_date, fi_lotdate, fi_lotnum, fi_userlot, fi_prid, fi_zeroed,
    fi_quant, fi_balance, fi_cost, fi_postref, fi_action, fi_loc,
    fi_allonum, fi_type, fi_group, fi_waid, fi_chid, fi_orid,
    fi_exten, fi_catchwgt, fi_serial, fi_expires, fi_invcost,
    fi_attrib1, fi_attrib2, fi_attrib3, fi_descrip, fi_q4group, fi_qc
) VALUES (
    DATEADD(DAY, -5, GETDATE()), DATEADD(DAY, -5, GETDATE()), 4001, 'ALLOC-TEST-007', 1, NULL,
    50, 50, 15.00, 'STAGING', 'STAGE', '19-STAGE-01',
    0, 'staging', 0, 3, 0, 0,
    750.00, 0, '', DATEADD(DAY, 60, GETDATE()), 15.00,
    '', '', '', 'Premium Widget Type A - STAGING', 0, ''
);

-- Lot 8: Quarantine inventory (should be excluded - type = 'quarantine')
INSERT INTO [dbo].[dtfifo] (
    fi_date, fi_lotdate, fi_lotnum, fi_userlot, fi_prid, fi_zeroed,
    fi_quant, fi_balance, fi_cost, fi_postref, fi_action, fi_loc,
    fi_allonum, fi_type, fi_group, fi_waid, fi_chid, fi_orid,
    fi_exten, fi_catchwgt, fi_serial, fi_expires, fi_invcost,
    fi_attrib1, fi_attrib2, fi_attrib3, fi_descrip, fi_q4group, fi_qc
) VALUES (
    DATEADD(DAY, -15, GETDATE()), DATEADD(DAY, -15, GETDATE()), 4002, 'ALLOC-TEST-008', 1, NULL,
    75, 75, 15.00, 'QC-HOLD', 'QUARANTINE', '20-QC-01',
    0, 'quarantine', 0, 3, 0, 0,
    1125.00, 0, '', DATEADD(DAY, 80, GETDATE()), 15.00,
    '', '', '', 'Premium Widget Type A - QUARANTINE', 0, ''
);

PRINT 'Inserted 8 test inventory lots for FIFO allocation';
PRINT '  - Lots 1-4: WIDGET-A at CPFG (various dates/expirations)';
PRINT '  - Lot 5: GADGET-PRO at CPFG';
PRINT '  - Lot 6: WIDGET-A at Northlake';
PRINT '  - Lot 7-8: Excluded types (staging, quarantine)';

-- ============================================================================
-- DATA VERIFICATION - GAI DATABASE
-- ============================================================================

PRINT '';
PRINT '========== GAI DATABASE SEED DATA SUMMARY ==========';
SELECT 'UNITS' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dbo].[dmunit];
SELECT 'VENDORS' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dbo].[dmvend];
SELECT 'PRODUCTS' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dbo].[dmprod];
SELECT 'SHIP-TO' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dbo].[dmship];
SELECT 'WAREHOUSES' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dbo].[dmware];
SELECT 'BILL-TO' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dbo].[dmbill];
SELECT 'ORDERS' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dbo].[dtord];
SELECT 'FIFO LOTS' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dbo].[dtfifo];
PRINT '====================================================';

-- ============================================================================
-- GAIMisc DATABASE
-- ============================================================================
USE [GAIMisc];
GO

-- ============================================================================
-- 1. ACID CORRECTION TABLE (AcidCorrection)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [GAIMisc].[dbo].[AcidCorrection] WHERE PercentAcid = 0.5)
    INSERT INTO [GAIMisc].[dbo].[AcidCorrection] (PercentAcid, AcidCorrection)
    VALUES (0.5, 1.02);

IF NOT EXISTS (SELECT 1 FROM [GAIMisc].[dbo].[AcidCorrection] WHERE PercentAcid = 1.0)
    INSERT INTO [GAIMisc].[dbo].[AcidCorrection] (PercentAcid, AcidCorrection)
    VALUES (1.0, 1.05);

IF NOT EXISTS (SELECT 1 FROM [GAIMisc].[dbo].[AcidCorrection] WHERE PercentAcid = 1.5)
    INSERT INTO [GAIMisc].[dbo].[AcidCorrection] (PercentAcid, AcidCorrection)
    VALUES (1.5, 1.08);

-- ============================================================================
-- 2. BRIX CHART (BrixChart)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [GAIMisc].[dbo].[BrixChart] WHERE Brix = 10.0)
    INSERT INTO [GAIMisc].[dbo].[BrixChart] (RefractiveIndex, Brix, SpecificGravity, LbPerGallon, PoundSolid)
    VALUES (1.3478, 10.0, 1.0403, 8.668, 0.867);

IF NOT EXISTS (SELECT 1 FROM [GAIMisc].[dbo].[BrixChart] WHERE Brix = 15.0)
    INSERT INTO [GAIMisc].[dbo].[BrixChart] (RefractiveIndex, Brix, SpecificGravity, LbPerGallon, PoundSolid)
    VALUES (1.3554, 15.0, 1.0615, 8.844, 1.327);

IF NOT EXISTS (SELECT 1 FROM [GAIMisc].[dbo].[BrixChart] WHERE Brix = 20.0)
    INSERT INTO [GAIMisc].[dbo].[BrixChart] (RefractiveIndex, Brix, SpecificGravity, LbPerGallon, PoundSolid)
    VALUES (1.3639, 20.0, 1.0835, 9.029, 1.806);

-- ============================================================================
-- 3. ALLOCATION TABLE (gai_allocate)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [GAIMisc].[dbo].[gai_allocate] WHERE all_id = 1 AND all_ordernum = 1001)
    INSERT INTO [GAIMisc].[dbo].[gai_allocate]
    (all_id, all_ordernum, all_codenum, all_userlot, all_qty, all_pick, all_date, all_chr1, all_chr2, all_chr3,
     all_description, all_um, all_status, all_carrier)
    VALUES
    (1, 1001, 'WIDGET-A', 'LOT-2025-001', 100, 100, GETDATE(), '', '', '',
     'Premium Widget Type A', 'EA', 'ALLOCATED', 'UPS');

IF NOT EXISTS (SELECT 1 FROM [GAIMisc].[dbo].[gai_allocate] WHERE all_id = 2 AND all_ordernum = 1002)
    INSERT INTO [GAIMisc].[dbo].[gai_allocate]
    (all_id, all_ordernum, all_codenum, all_userlot, all_qty, all_pick, all_date, all_chr1, all_chr2, all_chr3,
     all_description, all_um, all_status, all_carrier)
    VALUES
    (2, 1002, 'GADGET-PRO', 'LOT-2025-002', 50, 50, GETDATE(), '', '', '',
     'Professional Gadget Series', 'EA', 'ALLOCATED', 'FedEx');

-- ============================================================================
-- ACUITY IMPORT - SEED DATA FOR PHASE 2
-- ============================================================================
PRINT '';
PRINT '========== LOADING ACUITY IMPORT SEED DATA ==========';

-- User Configuration (gai_dmstech)
PRINT 'Seeding gai_dmstech (User Warehouse Assignments)...';

DELETE FROM [GAIMisc].[dbo].[gai_dmstech] WHERE gs_chr1 IN ('testuser', 'admin', 'cpfg_user', 'northlake_user', 'jrade');

-- gs_index is IDENTITY column, so we don't specify it
INSERT INTO [GAIMisc].[dbo].[gai_dmstech] (gs_id, gs_type, gs_chr1, gs_chr2, gs_chr3, gs_int1)
VALUES
    (1, 1, 'admin', 'Administrator', 'CPFG', 0),
    (1, 1, 'testuser', 'Test User', 'CPFG', 1),
    (1, 1, 'cpfg_user', 'CPFG User', 'CPFG', 1),
    (2, 1, 'northlake_user', 'Northlake User', 'Northlake', 1),
    (1, 1, 'jrade', 'John Rade', 'CPFG', 0);

PRINT 'Inserted 5 test users into gai_dmstech';

-- Sample Scheduler Data (for testing updates)
PRINT 'Seeding sample gai_scheduler records...';

DELETE FROM [GAIMisc].[dbo].[gai_scheduler] WHERE gs_ordnum IN (20250123499, 20250123400, 20250123401);

-- gs_index is IDENTITY column, so we don't specify it
IF NOT EXISTS (SELECT 1 FROM [GAIMisc].[dbo].[gai_scheduler] WHERE gs_ordnum = 20250123499)
    INSERT INTO [GAIMisc].[dbo].[gai_scheduler] (
        gs_id, gs_ordnum, gs_dock, gs_datestart, gs_dateend,
        gs_dockm, gs_company, gs_carrier, gs_driver, gs_chr2,
        gs_notes, gs_status, gs_datechkin, gs_appid, gs_forkop,
        gs_num1, gs_chr3, gs_date1
    )
    VALUES
        (3, 20250123499, '0', '2025-10-17 07:00:00', '2025-10-17 07:30:00',
         '00:00:00', 'Greenwood Associates Inc.', 'TBD', '', '()',
         'Notes', 'N/A', '2025-10-17 07:00:00', '', '',
         3, NULL, '2025-10-17 07:00:00');

PRINT 'Inserted 1 sample ICT order into gai_scheduler';
PRINT '========================================================';

-- ============================================================================
-- ICT (INTER-COMPANY TRANSFER) - SEED DATA
-- ============================================================================
PRINT '';
PRINT '========== ICT SEED DATA ==========';
PRINT 'Creating sample ICT orders for testing...';

-- Clear existing test ICT orders (different from Acuity test order above)
DELETE FROM gai_scheduler WHERE gs_ordnum IN (20250000199, 20250000299);
DELETE FROM gai_allocate WHERE all_ordernum IN (20250000199, 20250000299);

-- Sample ICT Order 1: CPFG to Northlake (empty order, ready for products)
INSERT INTO gai_scheduler (
    gs_id, gs_ordnum, gs_dock, gs_datestart, gs_dateend, gs_dockm,
    gs_company, gs_carrier, gs_driver, gs_chr2, gs_notes,
    gs_status, gs_datechkin, gs_appid, gs_forkop, gs_chr1,
    gs_num1, gs_chr3, gs_date1, gs_chr4,
    gs_picker, gs_auditor, gs_assembler,
    gs_log1, gs_dec3, gs_chr5, gs_chr6
) VALUES (
    92, 20250000199, '', GETDATE(), GETDATE(), '00:00:00',
    'Greenwood Associates, Inc.', 'TBD', 'TBD', 'TBD', 'Test ICT Order - CPFG to Northlake',
    'N/A', GETDATE(), '20250000199', '', '',
    3, '', GETDATE(), '',
    '', '', '',
    0, 99, 'Ready for dispatch', 'TBD'
);

-- Sample ICT Order 2: Northlake to CPFG (with line items and totals)
INSERT INTO gai_scheduler (
    gs_id, gs_ordnum, gs_dock, gs_datestart, gs_dateend, gs_dockm,
    gs_company, gs_carrier, gs_driver, gs_chr2, gs_notes,
    gs_status, gs_datechkin, gs_appid, gs_forkop, gs_chr1,
    gs_num1, gs_chr3, gs_date1, gs_chr4,
    gs_picker, gs_auditor, gs_assembler,
    gs_log1, gs_dec3, gs_chr5, gs_chr6,
    gs_num4, gs_num5, gs_pronum, gs_pallets, gs_nwt, gs_gwt
) VALUES (
    3, 20250000299, '', GETDATE(), GETDATE(), '00:00:00',
    'Greenwood Associates, Inc.', 'TBD', 'TBD', 'TBD', 'Test ICT Order - Northlake to CPFG',
    'N/A', GETDATE(), '20250000299', '', '',
    4, 'JOB-2025-001', GETDATE(), '',
    '', '', '',
    0, 99, 'Ready for dispatch', 'TBD',
    2, 5, 2, 5, 500.00, 550.00
);

-- Line items for Order 2 (202500002​99)
INSERT INTO gai_allocate (
    all_id, all_ordernum, all_codenum, all_userlot, all_qty, all_pick,
    all_date, all_chx1, all_chx2, all_chr1, all_chr2, all_dec1,
    all_date1, all_chx3, all_int1, all_chr3, all_description,
    all_um, all_int2, all_dec3, all_nwt, all_gwt
) VALUES
    -- Line 1: Product TEST-001, 100 cases, 3 pallets (100/40 = 2.5 → 3)
    (3, 20250000299, 'TEST-001', '', 100, 0,
     GETDATE(), '', '', 'CS', '', 0,
     GETDATE(), '', 0, 'JOB-2025-001', 'Test Product 001 - Widget Assembly',
     'CS', 3, 99, 250.00, 275.00),

    -- Line 2: Product TEST-002, 50 cases, 2 pallets (50/40 = 1.25 → 2)
    (3, 20250000299, 'TEST-002', '', 50, 0,
     GETDATE(), '', '', 'CS', '', 0,
     GETDATE(), '', 0, 'JOB-2025-001', 'Test Product 002 - Component Pack',
     'CS', 2, 99, 250.00, 275.00);

PRINT 'ICT Seed Data Complete:';
PRINT '  - 2 test ICT orders created';
PRINT '  - 2 line items added to order 202500002​99';
PRINT '  - Ready for testing at /ict-orders';
PRINT '========================================================';

-- ============================================================================
-- PREPICK WORKFLOW - SEED DATA
-- ============================================================================
PRINT '';
PRINT '========== PREPICK SEED DATA ==========';
PRINT 'Creating sample PrePick orders for testing...';

-- Clear existing test PrePick orders (regular orders, NOT ending in 99)
DELETE FROM gai_scheduler WHERE gs_ordnum IN (20260201001, 20260201002, 20260201003, 20260201004);
DELETE FROM gai_allocate WHERE all_ordernum IN (20260201001, 20260201002, 20260201003, 20260201004);

-- Sample PrePick Order 1: CPFG - Not allocated (no picker/auditor)
INSERT INTO gai_scheduler (
    gs_id, gs_ordnum, gs_dock, gs_datestart, gs_dateend, gs_dockm,
    gs_company, gs_carrier, gs_driver, gs_chr2, gs_notes,
    gs_status, gs_datechkin, gs_appid, gs_forkop, gs_chr1,
    gs_num1, gs_chr3, gs_date1, gs_chr4,
    gs_picker, gs_auditor, gs_assembler,
    gs_log1, gs_pronum, gs_pallets
) VALUES (
    3, 20260201001, 'A1', GETDATE(), GETDATE(), '08:00:00',
    'Acme Corporation', 'UPS', 'Driver A', 'TBD', 'Test PrePick Order 1 - Not started',
    'C', GETDATE(), '20260201001', 'jrade', '',
    1, '', GETDATE(), '',
    '', '', '',
    0, 5, 3
);

-- Sample PrePick Order 2: CPFG - Picker assigned, partially allocated
INSERT INTO gai_scheduler (
    gs_id, gs_ordnum, gs_dock, gs_datestart, gs_dateend, gs_dockm,
    gs_company, gs_carrier, gs_driver, gs_chr2, gs_notes,
    gs_status, gs_datechkin, gs_appid, gs_forkop, gs_chr1,
    gs_num1, gs_chr3, gs_date1, gs_chr4,
    gs_picker, gs_pickerin, gs_pickerout,
    gs_auditor, gs_assembler,
    gs_log1, gs_pronum, gs_pallets
) VALUES (
    3, 20260201002, 'B2', GETDATE(), GETDATE(), '09:30:00',
    'Global Parts Co', 'FedEx', 'Driver B', 'TBD', 'Test PrePick Order 2 - Picker in progress',
    'C', GETDATE(), '20260201002', 'jrade', 'admin',
    2, '', GETDATE(), 'testuser',
    'cpfg_user', DATEADD(HOUR, -1, GETDATE()), NULL,
    '', '',
    0, 8, 5
);

-- Sample PrePick Order 3: CPFG - Picker complete, auditor in progress (UPS carrier allows partial)
INSERT INTO gai_scheduler (
    gs_id, gs_ordnum, gs_dock, gs_datestart, gs_dateend, gs_dockm,
    gs_company, gs_carrier, gs_driver, gs_chr2, gs_notes,
    gs_status, gs_datechkin, gs_appid, gs_forkop, gs_chr1,
    gs_num1, gs_chr3, gs_date1, gs_chr4,
    gs_picker, gs_pickerin, gs_pickerout,
    gs_auditor, gs_auditorin, gs_auditorout,
    gs_assembler,
    gs_log1, gs_pronum, gs_pallets
) VALUES (
    3, 20260201003, 'C3', GETDATE(), GETDATE(), '10:00:00',
    'Premier Materials LLC', 'UPS', 'Driver C', 'TBD', 'Test PrePick Order 3 - Auditor in progress',
    'C', GETDATE(), '20260201003', 'jrade', 'admin',
    3, '', GETDATE(), 'testuser',
    'cpfg_user', DATEADD(HOUR, -2, GETDATE()), DATEADD(HOUR, -1, GETDATE()),
    'admin', DATEADD(MINUTE, -30, GETDATE()), NULL,
    '',
    0, 12, 8
);

-- Sample PrePick Order 4: Northlake - Complete (all workers clocked out)
INSERT INTO gai_scheduler (
    gs_id, gs_ordnum, gs_dock, gs_datestart, gs_dateend, gs_dockm,
    gs_company, gs_carrier, gs_driver, gs_chr2, gs_notes,
    gs_status, gs_datechkin, gs_appid, gs_forkop, gs_chr1,
    gs_num1, gs_chr3, gs_date1, gs_chr4,
    gs_picker, gs_pickerin, gs_pickerout,
    gs_auditor, gs_auditorin, gs_auditorout,
    gs_assembler, gs_assemblerin, gs_assemblerout,
    gs_log1, gs_pronum, gs_pallets, gs_num2
) VALUES (
    92, 20260201004, 'D4', GETDATE(), GETDATE(), '14:00:00',
    'Acme Corporation', 'Federal Express', 'Driver D', 'TBD', 'Test PrePick Order 4 - Complete',
    'C', GETDATE(), '20260201004', 'northlake_user', 'admin',
    4, '', GETDATE(), 'northlake_user',
    'northlake_user', DATEADD(HOUR, -4, GETDATE()), DATEADD(HOUR, -3, GETDATE()),
    'northlake_user', DATEADD(HOUR, -3, GETDATE()), DATEADD(HOUR, -2, GETDATE()),
    'northlake_user', DATEADD(HOUR, -2, GETDATE()), DATEADD(HOUR, -1, GETDATE()),
    1, 6, 4, 11
);

-- Add allocation records for testing auditor validation
-- Order 20260201002: Partially allocated
INSERT INTO gai_allocate (
    all_id, all_ordernum, all_codenum, all_userlot, all_qty, all_pick,
    all_date, all_chr1, all_chr2, all_chr3, all_description, all_um
) VALUES
    (3, 20260201002, 'WIDGET-A', 'LOT-2026-001', 50, 0, GETDATE(), '', '', '', 'Premium Widget Type A', 'EA'),
    (3, 20260201002, 'GADGET-PRO', 'LOT-2026-002', 25, 0, GETDATE(), '', '', '', 'Professional Gadget Series', 'EA');

-- Order 20260201003: Fully allocated (all qty > 0)
INSERT INTO gai_allocate (
    all_id, all_ordernum, all_codenum, all_userlot, all_qty, all_pick,
    all_date, all_chr1, all_chr2, all_chr3, all_description, all_um
) VALUES
    (3, 20260201003, 'WIDGET-A', 'LOT-2026-003', 100, 0, GETDATE(), '', '', '', 'Premium Widget Type A', 'EA'),
    (3, 20260201003, 'COMP-X100', 'LOT-2026-004', 200, 0, GETDATE(), '', '', '', 'Industrial Component X100', 'EA');

-- Order 20260201004: Fully picked (all pick > 0)
INSERT INTO gai_allocate (
    all_id, all_ordernum, all_codenum, all_userlot, all_qty, all_pick,
    all_date, all_chr1, all_chr2, all_chr3, all_description, all_um
) VALUES
    (92, 20260201004, 'WIDGET-A', 'LOT-2026-005', 75, 75, GETDATE(), '', '', '', 'Premium Widget Type A', 'EA'),
    (92, 20260201004, 'GADGET-PRO', 'LOT-2026-006', 30, 30, GETDATE(), '', '', '', 'Professional Gadget Series', 'EA');

PRINT 'PrePick Seed Data Complete:';
PRINT '  - Order 20260201001: CPFG, not started (Status 1)';
PRINT '  - Order 20260201002: CPFG, picker in progress, partially allocated (Status 2)';
PRINT '  - Order 20260201003: CPFG, auditor in progress, fully allocated (Status 3)';
PRINT '  - Order 20260201004: Northlake, complete, fully picked (Status 4)';
PRINT '  - Ready for testing at /prepick-orders';
PRINT '========================================================';

-- ============================================================================
-- ALLOCATION - SEED DATA FOR FIFO ALLOCATION & LOCKING
-- ============================================================================
-- NOTE: Allocation orders are in GAI.dbo.dttord (order headers seeded above)
-- This section adds allocation records (gai_allocate) and locks (gai_lock)
-- ============================================================================
PRINT '';
PRINT '========== ALLOCATION SEED DATA ==========';
PRINT 'Creating allocation records and locks for testing...';

-- Clear existing test Allocation records (using dttord order numbers 50001-50999)
DELETE FROM gai_allocate WHERE all_ordernum BETWEEN 50001 AND 50999;
DELETE FROM gai_lock WHERE gl_ordnum BETWEEN 50001 AND 50999;

-- ============================================================================
-- Allocation Records (gai_allocate) for Allocation Testing
-- These reference dttord orders 50001-50005 seeded in GAI database
-- ============================================================================

-- Order 50002: Partially allocated - only some products have allocations
INSERT INTO gai_allocate (
    all_id, all_ordernum, all_codenum, all_userlot, all_qty, all_pick,
    all_date, all_chr1, all_chr2, all_chr3, all_description, all_um, all_status
) VALUES
    (3, 50002, 'WIDGET-A', 'ALLOC-TEST-001', 100, 0, GETDATE(), '', '', '', 'Premium Widget Type A', 'EA', 'ALLOCATED'),
    (3, 50002, 'GADGET-PRO', '', 30, 0, GETDATE(), '', '', '', 'Professional Gadget Series - NOT ALLOCATED', 'EA', '');

-- Order 50003: Fully allocated - all products have allocations (150 qty matches dtord line)
INSERT INTO gai_allocate (
    all_id, all_ordernum, all_codenum, all_userlot, all_qty, all_pick,
    all_date, all_chr1, all_chr2, all_chr3, all_description, all_um, all_status
) VALUES
    (3, 50003, 'WIDGET-A', 'ALLOC-TEST-001', 100, 0, GETDATE(), '', '', '', 'Premium Widget Type A', 'EA', 'ALLOCATED'),
    (3, 50003, 'WIDGET-A', 'ALLOC-TEST-002', 50, 0, GETDATE(), '', '', '', 'Premium Widget Type A', 'EA', 'ALLOCATED');

-- ============================================================================
-- Lock Records (gai_lock) for Pessimistic Locking Testing
-- ============================================================================

-- Active lock on Order 50002 (within 10-minute timeout)
INSERT INTO gai_lock (
    gl_id, gl_ordnum, gl_partnum, gl_userlot, gl_username, gl_datel, gl_int1
) VALUES (
    1, 50002, '', '', 'testuser', DATEADD(MINUTE, -5, GETDATE()), 3
);

-- Expired lock on Order 50004 (older than 10 minutes - should be released)
INSERT INTO gai_lock (
    gl_id, gl_ordnum, gl_partnum, gl_userlot, gl_username, gl_datel, gl_int1
) VALUES (
    1, 50004, '', '', 'admin', DATEADD(MINUTE, -15, GETDATE()), 3
);

PRINT 'Allocation Seed Data Complete:';
PRINT '  - Order 50001: CPFG, not allocated (White status)';
PRINT '  - Order 50002: CPFG, partially allocated (Gold), locked by testuser';
PRINT '  - Order 50003: CPFG, fully allocated (LightCoral)';
PRINT '  - Order 50004: CPFG, credit hold (Terms 51) - EXCLUDED from list due to balance > 3%';
PRINT '  - Order 50005: Northlake, ready for allocation';
PRINT '  - Orders 50101-50223: Historical orders (2026-01-20 to 2026-02-01)';
PRINT '  - 2 lock records: 1 active, 1 expired';
PRINT '  - Ready for testing at /app/allocation';
PRINT '========================================================';

-- ============================================================================
-- DATA VERIFICATION - GAIMisc DATABASE
-- ============================================================================

PRINT '';
PRINT '========== GAIMisc DATABASE SEED DATA SUMMARY ==========';
SELECT 'ACID CORRECTIONS' AS [Category], COUNT(*) AS [Count] FROM [GAIMisc].[dbo].[AcidCorrection];
SELECT 'BRIX CHART' AS [Category], COUNT(*) AS [Count] FROM [GAIMisc].[dbo].[BrixChart];
SELECT 'ALLOCATIONS' AS [Category], COUNT(*) AS [Count] FROM [GAIMisc].[dbo].[gai_allocate];
SELECT 'USER ASSIGNMENTS' AS [Category], COUNT(*) AS [Count] FROM [GAIMisc].[dbo].[gai_dmstech];
SELECT 'SCHEDULER ORDERS' AS [Category], COUNT(*) AS [Count] FROM [GAIMisc].[dbo].[gai_scheduler];
SELECT 'LOCKS' AS [Category], COUNT(*) AS [Count] FROM [GAIMisc].[dbo].[gai_lock];
PRINT '========================================================';

PRINT '';
PRINT 'All seed data loaded successfully across all databases!';
