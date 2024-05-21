%let pgm=utl-publication-quality-reports-with-different-tiles-and-footnotes-on-each-page;

Publication quality reports with different tiles and footnotes on each page

Related report repos on end

  SECTIONS

    1 input process output
    2 rtf ods template
    3 related report repositories


report as a pdf
https://tinyurl.com/2esarde8
https://github.com/rogerjdeangelis/utl-publication-quality-reports-with-different-tiles-and-footnotes-on-each-page/blob/main/pgeBrk.pdf

report as a ms word
https://tinyurl.com/y3rebf2n
https://github.com/rogerjdeangelis/utl-publication-quality-reports-with-different-tiles-and-footnotes-on-each-page/blob/main/pgeBrk.docx

https://tinyurl.com/yr64wsvn
https://github.com/rogerjdeangelis/utl-publication-quality-reports-with-different-tiles-and-footnotes-on-each-page/blob/main/pgeBrk.rtf

report as rtf
github
https://tinyurl.com/4wadtpf7
https://github.com/rogerjdeangelis/utl-publication-quality-reports-with-different-tiles-and-footnotes-on-each-page

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

data have;
 length sex $8;
 set sashelp.class;
 if sex=:'F' then do;
    pgeBrk=1;
    sex='Female';
 end;
 else do;
    pgeBrk=2;
    sex='Male';
 end;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*    SEX      NAME       AGE    HEIGHT    WEIGHT    PGEBRK                                                               */
/*                                                                                                                        */
/*   Male      Alfred      14     69.0      112.5       2                                                                 */
/*   Female    Alice       13     56.5       84.0       1                                                                 */
/*   Female    Barbara     13     65.3       98.0       1                                                                 */
/*   Female    Carol       14     62.8      102.5       1                                                                 */
/*   Male      Henry       14     63.5      102.5       2                                                                 */
/*   Male      James       12     57.3       83.0       2                                                                 */
/*   Female    Jane        12     59.8       84.5       1                                                                 */
/*   Female    Janet       15     62.5      112.5       1                                                                 */
/*   Male      Jeffrey     13     62.5       84.0       2                                                                 */
/*   Male      John        12     59.0       99.5       2                                                                 */
/*   Female    Joyce       11     51.3       50.5       1                                                                 */
/*   Female    Judy        14     64.3       90.0       1                                                                 */
/*   Female    Louise      12     56.3       77.0       1                                                                 */
/*   Female    Mary        15     66.5      112.0       1                                                                 */
/*   Male      Philip      16     72.0      150.0       2                                                                 */
/*   Male      Robert      12     64.8      128.0       2                                                                 */
/*   Male      Ronald      15     67.0      133.0       2                                                                 */
/*   Male      Thomas      11     57.5       85.0       2                                                                 */
/*   Male      William     15     66.5      112.0       2                                                                 */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*
 _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
*/

%utl_rtflan100;

title;
footnote;
%symdel maxpge / nowarn;
options nodate nonumber orientation=portrait;

ods listing close;
ods escapechar='^';
ods rtf file="d:/pdf/pgeBrk.pdf" style=utl_rtflan100 notoc_data;
%macro Pge();
  %dosubl(%nrstr(proc sql noprint;select count(distinct sex) into :maxpge trimmed from have; quit;));
  %do Pge=1 %to &maxpge;
     %dosubl(%nrstr(proc sql noprint;select max(sex) into :sex trimmed from have where pgeBrk=&pge; quit;));
     %dosubl(%nrstr(proc sql noprint;select count(*) into :obs trimmed from have where pgebrk = &pge; quit;));
     ods rtf prepage=
     "^S={outputwidth=100% just=l font_size=11pt font_face=arial}{Table 1.&pge}^{newline}{Math Class}^{newline}{&sex Students(N=&obs)}";
     proc report data=have(where=(PgeBrk=&Pge)) nowd  missing style(column)={ just=left }  style(header)={ just=left };
       cols name sex age height weight;
       define name      / "Name"     left ;
       define sex       / "Gender"   left ;
       define age       / "Age"      left ;
       define height    / "Height"   left ;
       define weight    / "Weight"   left ;
     run;quit;
     ods rtf text="^S={outputwidth=100% just=r font_size=9pt} Page &Pge of &maxpge";
     %if &pge=&maxpge %then %do;
        ods rtf text="^S={outputwidth=100% just=l font_size=8pt font_style=italic}  {Last Page}";
        ods rtf text="^S={outputwidth=100% just=l font_size=8pt font_style=italic}  {End of report}";
     %end;
  run;
 %end /*pge*/;
 ods rtf close;
 ods listing;
%mend Pge;
%Pge;

/*           _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| `_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/* ONE INPUT AND DIFFERENT TITLES AND FOOTNOTE IN EACH PAGE                                                               */
/*                                                                                                                        */
/*  Table 1.1                                                                                                             */
/*  Math Class                                                                                                            */
/*  Female Students(N=9)                                                                                                  */
/*                                                                                                                        */
/*  +---------------------------------------------------+                                                                 */
/*  |                                                   |                                                                 */
/*  |  Name      Gender    Age      Height     Weight   |                                                                 */
/*  |                                                   |                                                                 */
/*  |  Alice     Female     13       56.5         84    |                                                                 */
/*  |  Barbara   Female     13       65.3         98    |                                                                 */
/*  |  Carol     Female     14       62.8      102.5    |                                                                 */
/*  |  Jane      Female     12       59.8       84.5    |                                                                 */
/*  |  Janet     Female     15       62.5      112.5    |                                                                 */
/*  |  Joyce     Female     11       51.3       50.5    |                                                                 */
/*  |  Judy      Female     14       64.3         90    |                                                                 */
/*  |  Louise    Female     12       56.3         77    |                                                                 */
/*  |  Mary      Female     15       66.5        112    |                                                                 */
/*  |                                                   |                                                                 */
/*  +---------------------------------------------------+                                                                 */
/*                                            Page 1 of 2                                                                 */
/*                                                                                                                        */
/*                                                                                                                        */
/*  Table 1.2                                                                                                             */
/*  Math Class                                                                                                            */
/*  Female Students(N=10)                                                                                                 */
/*                                                                                                                        */
/*  +---------------------------------------------------+                                                                 */
/*  |                                                   |                                                                 */
/*  |  Name      Gender    Age      Height     Weight   |                                                                 */
/*  |                                             |     |                                                                 */
/*  |  Alfred    Male       14         69      112.5    |                                                                 */
/*  |  Henry     Male       14       63.5      102.5    |                                                                 */
/*  |  James     Male       12       57.3         83    |                                                                 */
/*  |  Jeffrey   Male       13       62.5         84    |                                                                 */
/*  |  John      Male       12         59       99.5    |                                                                 */
/*  |  Philip    Male       16         72        150    |                                                                 */
/*  |  Robert    Male       12       64.8        128    |                                                                 */
/*  |  Ronald    Male       15         67        133    |                                                                 */
/*  |  Thomas    Male       11       57.5         85    |                                                                 */
/*  |  William   Male       15       66.5        112    |                                                                 */
/*  |                                                   |                                                                 */
/*  +---------------------------------------------------+                                                                 */
/*                                                                                                                        */
/*                                            Page 1 of 2                                                                 */
/*  Last Page                                                                                                             */
/*  End of report                                                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*    _    __   _                       _       _
 _ __| |_ / _| | |_ ___ _ __ ___  _ __ | | __ _| |_ ___
| `__| __| |_  | __/ _ \ `_ ` _ \| `_ \| |/ _` | __/ _ \
| |  | |_|  _| | ||  __/ | | | | | |_) | | (_| | ||  __/
|_|   \__|_|    \__\___|_| |_| |_| .__/|_|\__,_|\__\___|
                                 |_|
*/

%Macro utl_rtflan100
    (
      style=utl_rtflan100
      ,outputwidth=100%
      ,frame=box
      ,TitleFont=11pt
      ,docfont=10pt
      ,fixedfont=9pt
      ,rules=none
      ,bottommargin=.25in
      ,topmargin=1.5in
      ,rightmargin=1.0in
      ,leftmargin=.75in
      ,cellheight=13pt
      ,cellpadding = 7pt
      ,cellspacing = 3pt
      ,borderwidth = 1
    ) /  Des="SAS PDF Template for PDF";

ods path work.templat(update) sasuser.templat(update) sashelp.tmplmst(read);

Proc Template;

   define style &Style;
   parent=styles.rtf;

        replace body from Document /

               protectspecialchars=off
               asis=on
               bottommargin=&bottommargin
               topmargin   =&topmargin
               rightmargin =&rightmargin
               leftmargin  =&leftmargin
               ;

        replace color_list /
              'link' = blue
               'bgH'  = _undef_
               'fg'  = black
               'bg'   = _undef_;

        replace fonts /
               'TitleFont2'           = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'TitleFont'            = ("Arial, Helvetica, Helv",&titlefont,Bold)

               'HeadingFont'          = ("Arial, Helvetica, Helv",&titlefont)
               'HeadingEmphasisFont'  = ("Arial, Helvetica, Helv",&titlefont,Italic)

               'StrongFont'           = ("Arial, Helvetica, Helv",&titlefont,Bold)
               'EmphasisFont'         = ("Arial, Helvetica, Helv",&titlefont,Italic)

               'FixedFont'            = ("Courier New, Courier",&fixedfont)
               'FixedEmphasisFont'    = ("Courier New, Courier",&fixedfont,Italic)
               'FixedStrongFont'      = ("Courier New, Courier",&fixedfont,Bold)
               'FixedHeadingFont'     = ("Courier New, Courier",&fixedfont,Bold)
               'BatchFixedFont'       = ("Courier New, Courier",&fixedfont)

               'docFont'              = ("Arial, Helvetica, Helv",&docfont)

               'FootFont'             = ("Arial, Helvetica, Helv", 9pt)
               'StrongFootFont'       = ("Arial, Helvetica, Helv",8pt,Bold)
               'EmphasisFootFont'     = ("Arial, Helvetica, Helv",8pt,Italic)
               'FixedFootFont'        = ("Courier New, Courier",8pt)
               'FixedEmphasisFootFont'= ("Courier New, Courier",8pt,Italic)
               'FixedStrongFootFont'  = ("Courier New, Courier",7pt,Bold);

        style Graph from Output/
                outputwidth = 100% ;

        style table from table /
                outputwidth=&outputwidth
                protectspecialchars=off
                asis=on
                background = colors('tablebg')
                frame=&frame
                rules=&rules
                cellheight  = &cellheight
                cellpadding = &cellpadding
                cellspacing = &cellspacing
                bordercolor = colors('tableborder')
                borderwidth = &borderwidth;

         replace Footer from HeadersAndFooters

                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off ;

                replace FooterFixed from Footer
                / font = fonts('FixedFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterEmpty from Footer
                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off;

                replace FooterEmphasis from Footer
                / font = fonts('EmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterEmphasisFixed from FooterEmphasis
                / font = fonts('FixedEmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterStrong from Footer
                / font = fonts('StrongFootFont')  just=left asis=on protectspecialchars=off;

                replace FooterStrongFixed from FooterStrong
                / font = fonts('FixedStrongFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooter from Footer
                / font = fonts('FootFont')  asis=on protectspecialchars=off just=left;

                replace RowFooterFixed from RowFooter
                / font = fonts('FixedFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterEmpty from RowFooter
                / font = fonts('FootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterEmphasis from RowFooter
                / font = fonts('EmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterEmphasisFixed from RowFooterEmphasis
                / font = fonts('FixedEmphasisFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterStrong from RowFooter
                / font = fonts('StrongFootFont')  just=left asis=on protectspecialchars=off;

                replace RowFooterStrongFixed from RowFooterStrong
                / font = fonts('FixedStrongFootFont')  just=left asis=on protectspecialchars=off;

                replace SystemFooter from TitlesAndFooters / asis=on
                        protectspecialchars=off just=left;
    end;
run;
quit;

%Mend utl_rtflan100;

/*        _       _           _
 _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
| `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
| | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
|_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                          |_|
*/

REPO
----------------------------------------------------------------------------------------------------------------------------------------
https://github.com/rogerjdeangelis/CostReports
https://github.com/rogerjdeangelis/utl-Changing-variable-labels-formats-and-informats-with-proc-sort-transpose-report-and-mean
https://github.com/rogerjdeangelis/utl-Compendium-of-proc-report-clinical-tables
https://github.com/rogerjdeangelis/utl-adding-categories-that-are-NOT-in-your-data-to-proc-report-and--proc-tabulate
https://github.com/rogerjdeangelis/utl-allign-parentheses-decimal-points-in-proc-report
https://github.com/rogerjdeangelis/utl-amazing-proc-report-output-table-with-count-distinct-and-other-statistics-by-group
https://github.com/rogerjdeangelis/utl-array-and-do-over-macros-to-generate-define-statements-of-proc-report
https://github.com/rogerjdeangelis/utl-collapsing-nested-headers-in-proc-report-with-output-sas-dataset
https://github.com/rogerjdeangelis/utl-complex-proc-tabulate-in-proc-report-with-output-table-that-is-an-image-of-tabulate
https://github.com/rogerjdeangelis/utl-compute-column-in-proc-report-works-like-the-datastep
https://github.com/rogerjdeangelis/utl-cost-report-analysis
https://github.com/rogerjdeangelis/utl-create-a-dataset-of-counts-and-percent-differences-with-just-proc-report
https://github.com/rogerjdeangelis/utl-create-a-pdf-excel-html-proc-report-with-greek-letters
https://github.com/rogerjdeangelis/utl-creating-a-clinical-demographic-report-using-r-and-python-sql
https://github.com/rogerjdeangelis/utl-creating-a-crosstab-dataset-with-a-zero-row-using-proc-report-preloadfmt
https://github.com/rogerjdeangelis/utl-creating-a-two-by-two-grid-of-reports-in-excel
https://github.com/rogerjdeangelis/utl-creating-and-output-dataset-from-proc-report-with-meaningful-names
https://github.com/rogerjdeangelis/utl-creating-big-N-headers-in-your-reports-corresp-clinical-ods
https://github.com/rogerjdeangelis/utl-creating-ods-output-table-from-proc-report-experimental
https://github.com/rogerjdeangelis/utl-crosstab-output-tables-from-corresp-report-not-static-tabulate
https://github.com/rogerjdeangelis/utl-detail-proc-freq-crosstab-ods-output-table-instead-of-static-reports
https://github.com/rogerjdeangelis/utl-do-not-program-mutiple-complex-proc-report-compute-blocks
https://github.com/rogerjdeangelis/utl-dosubl-using-meta-data-with-column-names-and-labels-to-create-mutiple-proc-reports
https://github.com/rogerjdeangelis/utl-embed-sql-code-inside-proc-report-using-dosubl
https://github.com/rogerjdeangelis/utl-example-of-ods-crosstab-output-table-with-mean-and-std-using_proc-report
https://github.com/rogerjdeangelis/utl-example-rtf-excel-and-pdf-reports-using-all-sas-provided-style-templates
https://github.com/rogerjdeangelis/utl-excel-changing-cell-contents-inside-proc-report
https://github.com/rogerjdeangelis/utl-excel-grid-of-four-reports-in-one-sheet
https://github.com/rogerjdeangelis/utl-excel-report-with-two-side-by-side-graphs-below_python
https://github.com/rogerjdeangelis/utl-excel-using-proc-report-workarea-columns-to-operate--on-arbitrary-row
https://github.com/rogerjdeangelis/utl-fixing-bugs-in-proc-report-tabulate-and-freq-output-crosstab-datasets
https://github.com/rogerjdeangelis/utl-formatting-aggregated-across-cells-as-character-in-proc-report-not-possible-in-tabulate
https://github.com/rogerjdeangelis/utl-is-proc-report-more-flexible-than-proc-summary-or-tabulate-when-an-output-dataset-is-needed
https://github.com/rogerjdeangelis/utl-is-proc-report-more-powerfull-than-proc-summary-or-proc-means
https://github.com/rogerjdeangelis/utl-layout-ods-excel-reports-in-a-grid
https://github.com/rogerjdeangelis/utl-meta-data-for-publish-quality-reports-with-different-title-footnotes-and-page-n-of-N
https://github.com/rogerjdeangelis/utl-minimum-code-for-a-very-simple-n-percent-crosstab-proc-report
https://github.com/rogerjdeangelis/utl-nice-collection-of-FDA-submission-reports
https://github.com/rogerjdeangelis/utl-nice-example-of-alias-columns-in-wps-proc-report
https://github.com/rogerjdeangelis/utl-proc-report-adding-additional-arbitrary-summary-rows
https://github.com/rogerjdeangelis/utl-proc-report-calculate-sub-totals-and-add-serial-no-with-the-sorted-group-variable
https://github.com/rogerjdeangelis/utl-proc-report-compute-after-grouped-summarizations-not-easy
https://github.com/rogerjdeangelis/utl-proc-report-compute-with-multiple-across-variables
https://github.com/rogerjdeangelis/utl-proc-report-greenbar-or-alternate-shading-of-rows-for-easy-reading
https://github.com/rogerjdeangelis/utl-retaining-header-row-across-pages-on-ods-rtf-proc-report
https://github.com/rogerjdeangelis/utl-sas-ods-excel-to-create-excel-report-and-separate-png-graph-finally-r-for-layout-in-excel
https://github.com/rogerjdeangelis/utl-side-by-side-proc-report-output-in-pdf-html-and-excel
https://github.com/rogerjdeangelis/utl-side-by-side-reports-within-arbitrary-positions-in-one-excel-sheet-wps-r
https://github.com/rogerjdeangelis/utl-simple-interactive-interface-to-run-yearly-or-monthly-report-proc-pmenu
https://github.com/rogerjdeangelis/utl-simple-proc-report-and-tabulate-n-and-percent-crosstab-ourput-datasets-
https://github.com/rogerjdeangelis/utl-skilled-nursing-cost-reports-2011-2019-in-excel
https://github.com/rogerjdeangelis/utl-the-all-powerfull-proc-report-to-create-transposed-sorted-and-summarized-output-datasets
https://github.com/rogerjdeangelis/utl-three-dimensional-crosstab-proc-freq-tabulate-corresp-and-report
https://github.com/rogerjdeangelis/utl-transpose-macro-rather-than-proc-print-report-or-tabulate
https://github.com/rogerjdeangelis/utl-transposing-multiple-variables-using-transpose-macro-sql-arrays-proc-report
https://github.com/rogerjdeangelis/utl-transposing-mutiple-variables-using-a-specific-format-proc-report
https://github.com/rogerjdeangelis/utl-transposing-sorting-and-summarizing-with-a-single-proc-corresp-freq-tabulate-and-report
https://github.com/rogerjdeangelis/utl-undocumented-proc-report-options-seenum-see-char-and-nrkeys
https://github.com/rogerjdeangelis/utl-use-dosubl-to-save-your-format-code-inside-proc-report
https://github.com/rogerjdeangelis/utl-use-proc-report-instead-of-tabulate-most-of-the-time
https://github.com/rogerjdeangelis/utl-use-report-instead-of-tabulate-and-get-the-bonus-of-an-output-table
https://github.com/rogerjdeangelis/utl-use-the-proc-report-list-option-to-understand-what-proc-report-is-doing
https://github.com/rogerjdeangelis/utl-using-proc-report-output-dataset-to-touch-up-a-report
https://github.com/rogerjdeangelis/utl-using-title-and-footnote-meta-data-to-drive-clinical-reports
https://github.com/rogerjdeangelis/utl-workaround-for--proc-report-bug-when-highlighting-individual-cells-in-an-across-variable
https://github.com/rogerjdeangelis/utl_another_N_Percent_report_crosstab
https://github.com/rogerjdeangelis/utl_clinical_report
https://github.com/rogerjdeangelis/utl_compare_corresp_vs_report_output_datasets
https://github.com/rogerjdeangelis/utl_eliminating_gaps_between_records_in_proc_report
https://github.com/rogerjdeangelis/utl_extreme_document_styling_in_four_reporting_formats
https://github.com/rogerjdeangelis/utl_flexible_complex_multi-dimensional_transpose_using_one_proc_report
https://github.com/rogerjdeangelis/utl_flexible_proc_report
https://github.com/rogerjdeangelis/utl_gather_macro_and_proc_report_for_quick_crosstabs_with_meaningful_names
https://github.com/rogerjdeangelis/utl_minimal_code_for_demographic_clinical_n_percent_report
https://github.com/rogerjdeangelis/utl_minimum_code_for_a_complex_proc_report
https://github.com/rogerjdeangelis/utl_minimum_code_npct_clinical_report_with_bigN_headers
https://github.com/rogerjdeangelis/utl_nice_reports_using_put_all_with_various_formats
https://github.com/rogerjdeangelis/utl_ods_excel_font_size_and_justification_proc_report_titles_formatting
https://github.com/rogerjdeangelis/utl_proc_report_add_total_of_amount_in_the_header
https://github.com/rogerjdeangelis/utl_proc_report_creating_three_dimensional_output
https://github.com/rogerjdeangelis/utl_proc_report_different_titles_headers_footnotes_and_number_of_obs_per_page
https://github.com/rogerjdeangelis/utl_proc_report_move_group_label_to_last_line_of_group
https://github.com/rogerjdeangelis/utl_proc_report_page_x_of_y_by_group
https://github.com/rogerjdeangelis/utl_proc_report_useful_tips_counters_conditional_rows_templates
https://github.com/rogerjdeangelis/utl_proc_report_with_different_margins_on_even_and_odd_pages
https://github.com/rogerjdeangelis/utl_recovering_after_you_have_painted_yourself_in_a_corner_with_proc_report
https://github.com/rogerjdeangelis/utl_report_does_not_show_group_variable_across_new_pages_in_rtf_and_pdf
https://github.com/rogerjdeangelis/utl_report_on_duplicated_combinations_of_subject_id_and_other_unique_ids
https://github.com/rogerjdeangelis/utl_resizing_an_image_in_report_writing_interface
https://github.com/rogerjdeangelis/utl_side_by_side_excel_reports
https://github.com/rogerjdeangelis/utl_sort_transpose_and_summarize_a_dataset_using_just_one_proc_report
https://github.com/rogerjdeangelis/utl_tabulate_or_report_spanning_lines
https://github.com/rogerjdeangelis/utl_transpose_with_proc_report


/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
