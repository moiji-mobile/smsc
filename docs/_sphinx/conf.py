extensions = []
source_suffix = '.rst'
master_doc = 'index'

# General information about the project.
project = u'smsc'
copyright = u'2016, Holger Hans Peter Freyther'
author = u'Holger Hans Peter Freyther'

version = u'stable'
release = u'stable'

language = None

exclude_patterns = []
pygments_style = 'sphinx'
todo_include_todos = False
html_theme = 'alabaster'

htmlhelp_basename = 'smscdoc'

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {
}

latex_documents = [
    (master_doc, 'smsc.tex', u'smsc Documentation',
     u'Holger Hans Peter Freyther', 'manual'),
]

# The name of an image file (relative to this directory) to place at the top of
# the title page.
#
# latex_logo = None

man_pages = [
    (master_doc, 'smsc', u'smsc Documentation',
     [author], 1)
]

texinfo_documents = [
    (master_doc, 'smsc', u'smsc Documentation',
     author, 'smsc', 'One line description of project.',
     'Miscellaneous'),
]

# -- Options for Epub output ----------------------------------------------

# Bibliographic Dublin Core info.
epub_title = project
epub_author = author
epub_publisher = author
epub_copyright = copyright

# A list of files that should not be packed into the epub file.
epub_exclude_files = ['search.html']

import os
on_rtd = os.environ.get('READTHEDOCS') == 'True'
if on_rtd:
    html_theme = 'default'
