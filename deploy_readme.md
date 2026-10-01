# 个人主页使用与 GitHub 发布指南

这是一个 Jekyll 学术主页。日常更新主要修改 YAML 和 Markdown 文件，GitHub Actions 会把它们生成网页并发布到 GitHub Pages。

## 1. 修改哪些文件

| 想修改的内容 | 对应文件或文件夹 |
| --- | --- |
| 姓名、单位、邮箱、简介、教育经历、GitHub/Scholar 链接 | `_data/profile.yml` |
| 头像 | `assets/images/photos/portrait.jpg` |
| 论文标题、作者、摘要、论文与代码链接 | `_publications/2026/`，每篇论文一个 Markdown 文件 |
| 论文作者的加粗和个人链接 | `_data/authors.yml` |
| 首页是否显示经历、新闻、精选论文 | `_data/display.yml` |
| 顶部导航 | `_data/navigation.yml` |
| 网站路径、构建设置 | `_config.yml` |
| 字体、颜色、间距等样式 | `assets/css/global.css` |

目前已经填写 Xinxin Li 的简介和论文。新增论文时复制一个现有论文文件，修改开头 `---` 之间的字段。`selected: true` 会把它放到首页精选论文中，`date` 控制排序。YAML 缩进请使用空格。

`_site/` 是生成的网页，每次构建都会重新生成；日常修改上表中的源文件。

## 2. 第一次上传到 GitHub

下面以项目中填写的账号 `XinxinLi-Code` 为例。如果这不是你的账号，请替换仓库名和命令中的用户名。

### 第一步：创建一个空仓库

打开 [GitHub 新建仓库](https://github.com/new)，选择自己的账号：

- Repository name：`XinxinLi-Code.github.io`。
- Visibility：`Public`，适用于免费账号的 GitHub Pages。
- 不要勾选初始化 README、.gitignore 或 License；这些文件本地已经有了。

如果这个仓库已经存在，先查看其中的内容；下面的命令针对新建空仓库，不要用强制推送覆盖已有网站。

### 第二步：上传本地项目

在 macOS 终端执行：

```bash
cd /Users/lixinxin/Downloads/lixinxin-academic-homepage
git init -b main
git add .
git commit -m "Set up academic homepage"
git remote add origin https://github.com/XinxinLi-Code/XinxinLi-Code.github.io.git
git push -u origin main
```

如果提交时提示没有姓名和邮箱，按提示设置 Git 提交身份后重试。HTTPS 推送需要 GitHub 支持的身份验证方式，不能使用账号登录密码；也可以在 GitHub Desktop 登录，使用 File → Add Local Repository 添加已执行 `git init` 的目录，再推送。

上传的是整个源项目，包含隐藏目录 `.github/` 中的工作流。`.gitignore` 会排除 `_site/`、缓存和本地依赖，`Gemfile.lock` 则随源代码上传以固定依赖版本。

### 第三步：启用网页发布

1. 在 GitHub 仓库中打开 **Settings → Pages**。
2. 在 **Build and deployment → Source** 中选择 **GitHub Actions**。
3. 打开 **Actions → Deploy homepage to GitHub Pages → Run workflow**，选择 `main` 并运行。首次推送发生在启用 Pages 之前时，这一步可以重新触发部署。
4. 等待 `build` 和 `deploy` 两个任务成功，再从 Settings → Pages 打开网站。

对于上述个人主页仓库，预期网址是：

[https://xinxinli-code.github.io/](https://xinxinli-code.github.io/)

这个地址要等仓库创建并部署成功后才能访问。工作流已经放在 `.github/workflows/pages.yml`；启用 Pages 时无需再生成第二份工作流。

### 第四步：以后更新

修改本地文件后，在项目目录执行：

```bash
git add .
git commit -m "Update homepage"
git push
```

每次推送到 `main` 后都会自动发布。也可以直接在 GitHub 网页中编辑某篇论文或个人资料并提交到 `main`。

## 3. 本地预览（可选）

这台电脑已找到 Homebrew 自带的 Ruby 3.3.5。项目中的 `preview.command` 会自动选择 Ruby 3.3，并使用项目 `vendor/` 中的依赖。依赖准备好后，可以双击该文件，或在项目目录执行：

```bash
./preview.command
```

预览地址为 [http://127.0.0.1:4000/](http://127.0.0.1:4000/)，支持内容修改后自动刷新。在运行服务的终端按 `Ctrl+C` 停止。第一次在另一台电脑上使用时，仍需准备下述 Ruby 和依赖环境。

发布可以直接由 GitHub 构建。本地预览使用 `.ruby-version` 中指定的 Ruby 3.3，以及 `Gemfile.lock` 中指定的 Bundler 4.0.18。

当前终端检测到的 macOS 系统 Ruby 是 2.6，无法直接运行本项目的锁定依赖。先通过 Ruby 版本管理器准备 Ruby 3.3，再执行：

```bash
gem install bundler -v 4.0.18
bundle config set --local path vendor/bundle
bundle install
bundle exec jekyll serve
```

打开终端输出的地址，通常是 [http://127.0.0.1:4000/](http://127.0.0.1:4000/)。修改 `_config.yml` 后要停止并重新启动预览服务。直接双击源文件 `index.html` 无法渲染其中的 Jekyll 模板。

## 4. 常见问题

- **上传成功，但网站打不开**：确认 Settings → Pages 的 Source 是 GitHub Actions，并检查 Actions 中两个任务是否成功。
- **Actions 没有自动运行**：确认工作流文件已上传，且推送分支名为 `main`。
- **图片或样式路径不正确**：个人主页仓库使用 `baseurl: ""`；普通项目仓库本地预览使用 `baseurl: "/仓库名"`。线上工作流会根据 Pages 配置自动传入对应路径。
- **想换仓库名**：普通仓库如 `academic-homepage` 的网址是 `https://用户名.github.io/academic-homepage/`；只有 `用户名.github.io` 仓库对应根网址。
- **想添加新闻或博客**：新闻开关在 `_data/display.yml`，导航在 `_data/navigation.yml`。`_news/`、`_posts/` 和 `_showcase/` 中仍有模板示例；隐藏导航不会删除已经生成的页面，启用或发布相关内容前请按需修改。

部署方式参考 [GitHub Pages 自定义工作流](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages) 和 [GitHub Pages 与 Jekyll](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/about-github-pages-and-jekyll)。项目使用自定义构建来加载 `jekyll-email-protect` 插件。

---

# Detailed Content Maintenance Reference

This project is a Jekyll-based academic homepage. The main content is controlled by YAML data files and Markdown files, so most updates do not require editing HTML.

## Local preview

Run the site from the project root:

```bash
bundle install
bundle exec jekyll serve
```

Then open the local URL printed by Jekyll, usually:

```text
http://127.0.0.1:4000/
```

If you change `_config.yml`, stop and restart `bundle exec jekyll serve`.

## Main profile

Edit `_data/profile.yml`.

Important fields:

- `primary_name`: your displayed name.
- `navbar_name`: the name shown in the top navigation bar.
- `positions`: affiliation lines shown under your name.
- `email`: contact email shown on the profile card. An empty value hides the email row.
- `gscholar`: Google Scholar ID. Current value is `51hC7YMAAAAJ`.
- `github`: GitHub username. Current value is `XinxinLi-Code`.
- `short_bio`: the biography shown on the homepage.
- `portrait_url`: profile photo. It currently uses the local image `/assets/images/photos/portrait.jpg`. To use a local photo, put the image in `assets/images/photos/`, then set `portrait_url` to something like `/assets/images/photos/portrait.jpg`.

If you want to show education, experience, or awards, uncomment and fill the relevant sections in `_data/profile.yml`, then set `show_experience: true` in `_data/display.yml`.

## Publications

Each publication is one Markdown file under `_publications/<year>/`.

Example:

```yaml
---
title: "Paper Title"
date: 2026-06-11 00:01:00 +0800
selected: true
pub: "Conference or Journal Name"
pub_date: "2026"
pub_last: ' <span class="badge badge-pill badge-publication badge-success">Accepted</span>'
abstract: >-
  One or two sentence summary for the homepage and publications page.
authors:
  - Xinxin Li
  - Collaborator Name
links:
  Paper: https://example.com/paper
  Code: https://github.com/XinxinLi-Code/example
---
```

Notes:

- `selected: true` shows the paper on the homepage.
- `selected: false` keeps it only on the Publications page.
- `date` controls sorting. Use the publication date when available.
- `pub_last` is optional and can show badges such as Accepted, Spotlight, Oral, or Best Paper.
- If the author name appears in `_data/authors.yml`, custom display settings such as bold text or links are applied.

To add a new paper, create a new file such as `_publications/2026/2026-new-paper.md` and follow the same front matter format.

## Authors

Edit `_data/authors.yml`.

The current file makes `Xinxin Li` bold in all publication author lists. You can add collaborator links like this:

```yaml
"Collaborator Name":
  url: https://scholar.google.com/scholar?q=Collaborator+Name
```

## Navigation

Edit `_data/navigation.yml`.

The current navigation only shows:

- Home
- Publications

The template still contains Blog and Showcase pages, but they are hidden from the navbar. Add them back only if you want to maintain those sections.

## Homepage sections

Edit `_data/display.yml`.

Current settings:

- `show_experience: true`
- `show_news: false`
- `show_selected_publications: true`

Set `show_news: true` only after replacing the example files in `_news/` with real news.

## Deployment with GitHub Pages

For a project page repository named `academic-homepage`, keep this in `_config.yml`:

```yaml
baseurl: "/academic-homepage"
```

For a user homepage repository named `XinxinLi-Code.github.io`, change it to:

```yaml
baseurl: ""
```

Then push the repository to GitHub and enable GitHub Pages in repository settings.

Pages settings for the included workflow:

- Source: GitHub Actions
- Push to branch `main`, or run the workflow manually after enabling Pages.
- The workflow builds `_site/` and deploys it; do not upload `_site/` separately.

After GitHub Pages finishes building, visit the Pages URL shown in the repository settings.

## Common changes

Change the homepage bio:

1. Open `_data/profile.yml`.
2. Edit the HTML inside `short_bio`.
3. Preview with `bundle exec jekyll serve`.

Add a paper:

1. Create `_publications/<year>/<year>-paper-slug.md`.
2. Fill title, date, venue, authors, abstract, and links.
3. Add missing collaborators to `_data/authors.yml` if you want links.

Replace the avatar:

1. Put your photo in `assets/images/photos/`.
2. Set `portrait_url: /assets/images/photos/your-photo.jpg`.
3. Update `portrait_caption`.

Show news:

1. Replace all example files in `_news/` with real updates.
2. Set `show_news: true` in `_data/display.yml`.

## Current publications and asset sources

- [EditSR](https://arxiv.org/abs/2606.07915): arXiv preprint, submitted June 6, 2026.
- [ViSymRe](https://www.sciencedirect.com/science/article/pii/S0893608026004776): Neural Networks, volume 202, article 109017 (2026). Sorting uses the April 21, 2026 online publication date recorded in [PubMed](https://pubmed.ncbi.nlm.nih.gov/42035569/); the journal issue is October 2026.
- [LieDiscover](https://arxiv.org/abs/2609.33663): arXiv preprint, submitted September 27, 2026.
- [Weak-PDE-Net](https://arxiv.org/abs/2603.22951): arXiv preprint, submitted March 24, 2026.
- [UniSymNet](https://www.sciencedirect.com/science/article/pii/S0893608026000778): Neural Networks, volume 199, article 108615 (2026). The sorting date uses the July journal issue recorded in [Crossref](https://api.crossref.org/works/10.1016/j.neunet.2026.108615), with day 1 as a placeholder. The displayed citation uses only the year.
- [East China Normal University official identity assets](https://www.ecnu.edu.cn/wzcd/xxgk/xxbs.htm): `assets/images/badges/ecnu_seal.png` is the B variant from the university's PNG download.
- [Donghua University official seal](https://www.dhu.edu.cn/5952/list.htm): `assets/images/badges/dhu_seal.png` is the official full logo image; CSS frames its circular seal in the education card.

The original seven publication entries are preserved in `_template_archive/_publications/`.
Jekyll ignores this underscore-prefixed archive, so those papers do not appear on the site.
The biography summarizes the research in the three papers. Education dates, contact details,
portrait, and awards retain the existing profile values.
