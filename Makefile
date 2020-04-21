PREFIX=/media/jeksterslab/scripts/r
PKG=${PREFIX}/jeksterslabRterm
UTILS=${PREFIX}/jeksterslabRutils
RPKG=${PKG}/R
RUTILS=${UTILS}/R

.PHONY: all clean

all :
	-rm -rf ${PKG}/docs/*
	-rm -rf ${PKG}/man/*
	-rm -rf ${PKG}/tests/testthat/*.html
	-rm -rf ${PKG}/tests/testthat/*.md
	-rm -rf ${PKG}/vignettes/*.html
	-rm -rf ${PKG}/vignettes/*.md
	cp ${RUTILS}/util_os.R ${RPKG}
	cp ${RUTILS}/util_txt2file.R ${RPKG}
	cp ${UTILS}/tests/testthat/test_util_txt2file.R ${PKG}/tests/testthat
	Rscript -e 'devtools::install("${PKG}")'
	Rscript -e 'jeksterslabRpkg::pkg_build("${PKG}", git = TRUE, github = TRUE)'

clean :
	-rm -rf ${PKG}/docs/*
	-rm -rf ${PKG}/man/*
	-rm -rf ${PKG}/tests/testthat/*.html
	-rm -rf ${PKG}/tests/testthat/*.md
	-rm -rf ${PKG}/vignettes/*.html
	-rm -rf ${PKG}/vignettes/*.md
	cp ${RUTILS}/util_os.R ${RPKG}
	cp ${RUTILS}/util_txt2file.R ${RPKG}
	cp ${UTILS}/tests/testthat/test_util_txt2file.R ${PKG}/tests/testthat
	git add --all
	git commit -m "Automated clean."
	git push
