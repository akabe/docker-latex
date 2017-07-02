FROM debian:8

ENV TEXDIR /usr/share/texlive/texmf-dist/tex

# Add "contrib" and "non-free" packages
RUN sed -i 's/main$/main contrib non-free/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y

# Install TexLive packages
RUN apt-get install -y \
      texlive-base \
      texlive-latex-extra \
      texlive-latex-base \
      texlive-latex-recommended \
      texlive-xetex texlive-luatex \
      texlive-math-extra \
      texlive-lang-cjk

# Install style files
RUN apt-get install -y curl bzip2 nkf && \
    \
    mkdir -p "$TEXDIR/platex/jlisting" && \
    curl -L 'http://sourceforge.jp/frs/redir.php?m=jaist&f=%2Fmytexpert%2F26068%2Fjlisting.sty.bz2' | bunzip2 | nkf --utf8 > "$TEXDIR/platex/jlisting/jlisting.sty" && \
    mktexlsr && \
    \
    apt-get purge -y curl bzip2 nkf && \
    apt-get autoremove -y && \
    apt-get autoclean

RUN apt-get install -y pandoc
