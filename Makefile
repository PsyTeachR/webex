all : README.md pkgdocs

README.md : README.Rmd
	Rscript -e "rmarkdown::render('README.Rmd')"

pkgdocs : README.md
	Rscript -e "pkgdown::build_site()"
