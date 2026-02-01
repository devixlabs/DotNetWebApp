-- ============================================================================
-- SEED DATA FOR DotNetWebApp
-- Uses actual column names from sql/schema.sql
-- Comprehensive seed data for demo purposes
-- ============================================================================

-- ============================================================================
-- 1. UNITS OF MEASURE (dmunit)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmunit] WHERE un_name = 'Each')
    INSERT INTO [GAI].[dmunit] (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES ('Each', 1, 1, 'P', 1, 1.0, 0.0, 0.0, 0, 1.0, '', 'EA');

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmunit] WHERE un_name = 'Case')
    INSERT INTO [GAI].[dmunit] (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES ('Case', 1, 0, 'P', 0, 12.0, 0.0, 0.0, 0, 1.0, '', 'CS');

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmunit] WHERE un_name = 'Box')
    INSERT INTO [GAI].[dmunit] (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES ('Box', 1, 0, 'P', 0, 24.0, 0.0, 0.0, 0, 1.0, '', 'BX');

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmunit] WHERE un_name = 'Pallet')
    INSERT INTO [GAI].[dmunit] (un_name, un_active, un_default, un_type, un_base, un_factor, un_shipmins, un_recmins, un_restcontunid, un_fedexfactor, un_fedexunit, un_edicode)
    VALUES ('Pallet', 1, 0, 'P', 0, 48.0, 5.0, 5.0, 0, 1.0, '', 'PL');

-- ============================================================================
-- 2. VENDORS (dmvend)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmvend] WHERE ve_name = 'Acme Supplies Inc')
BEGIN
    SET IDENTITY_INSERT [GAI].[dmvend] ON;
    INSERT INTO [GAI].[dmvend]
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
    SET IDENTITY_INSERT [GAI].[dmvend] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmvend] WHERE ve_name = 'Global Parts Co')
BEGIN
    SET IDENTITY_INSERT [GAI].[dmvend] ON;
    INSERT INTO [GAI].[dmvend]
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
    SET IDENTITY_INSERT [GAI].[dmvend] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmvend] WHERE ve_name = 'Premier Materials LLC')
BEGIN
    SET IDENTITY_INSERT [GAI].[dmvend] ON;
    INSERT INTO [GAI].[dmvend]
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
    SET IDENTITY_INSERT [GAI].[dmvend] OFF;
END;

-- ============================================================================
-- 3. PRODUCTS (dmprod) - ALL 264 columns (excluding pr_id IDENTITY)
-- ============================================================================

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmprod] WHERE pr_codenum = 'WIDGET-A')
INSERT INTO [GAI].[dmprod] (
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

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmprod] WHERE pr_codenum = 'GADGET-PRO')
INSERT INTO [GAI].[dmprod] (
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

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmprod] WHERE pr_codenum = 'COMP-X100')
INSERT INTO [GAI].[dmprod] (
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

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmship] WHERE sh_name = 'Main Warehouse')
BEGIN
    SET IDENTITY_INSERT [GAI].[dmship] ON;
    INSERT INTO [GAI].[dmship]
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
    SET IDENTITY_INSERT [GAI].[dmship] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmship] WHERE sh_name = 'East Coast Distribution')
BEGIN
    SET IDENTITY_INSERT [GAI].[dmship] ON;
    INSERT INTO [GAI].[dmship]
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
    SET IDENTITY_INSERT [GAI].[dmship] OFF;
END;

IF NOT EXISTS (SELECT 1 FROM [GAI].[dmship] WHERE sh_name = 'West Coast Fulfillment')
BEGIN
    SET IDENTITY_INSERT [GAI].[dmship] ON;
    INSERT INTO [GAI].[dmship]
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
    SET IDENTITY_INSERT [GAI].[dmship] OFF;
END;

-- ============================================================================
-- DATA VERIFICATION
-- ============================================================================

PRINT '';
PRINT '========== SEED DATA SUMMARY ==========';
SELECT 'UNITS' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dmunit];
SELECT 'VENDORS' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dmvend];
SELECT 'PRODUCTS' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dmprod];
SELECT 'SHIP-TO' AS [Category], COUNT(*) AS [Count] FROM [GAI].[dmship];
PRINT 'Seed data loaded successfully!';
PRINT '=======================================';
