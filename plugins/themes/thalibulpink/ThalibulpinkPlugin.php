<?php

namespace APP\plugins\themes\thalibulpink;

use PKP\plugins\Hook;

class ThalibulpinkPlugin extends \PKP\plugins\ThemePlugin
{
    protected static bool $passwordResetEmail = false;

    public function init()
    {
        $this->addStyle('thalibulpink', 'resources/dist/app.css');
        $this->addScript('thalibulpink', 'resources/dist/app.js');
        $this->addMenuArea(['primary', 'user']);
        Hook::add('Mailable::build', function (string $hookName, ?object $mailable = null): int {
            if (!$mailable instanceof \PKP\mail\mailables\PasswordResetRequested) {
                return Hook::CONTINUE;
            }

            self::$passwordResetEmail = true;

            $context = \APP\core\Application::get()->getRequest()->getContext();
            if ($context) {
                if ($context->getContactEmail()) {
                    $mailable->from($context->getContactEmail(), $context->getContactName() ?: $context->getLocalizedName());
                }
                $mailable->addData([
                    'journalTitle' => htmlspecialchars($context->getLocalizedName()),
                    'journalLogoUrl' => htmlspecialchars(\PKP\config\Config::getVar('general', 'base_url') . '/plugins/themes/thalibulpink/logo_small.png', ENT_QUOTES, 'UTF-8'),
                ]);
            } else {
                $mailable->addData([
                    'journalTitle' => 'Thalibul Ilmi: Journal of Teaching and Learning',
                    'journalLogoUrl' => htmlspecialchars(\PKP\config\Config::getVar('general', 'base_url') . '/plugins/themes/thalibulpink/logo_small.png', ENT_QUOTES, 'UTF-8'),
                ]);
            }

            $mailable->body(<<<'HTML'
<div style="margin:0;background:#fff8fb;padding:32px 16px;font-family:Arial,Helvetica,sans-serif;color:#172033;">
  <div style="margin:0 auto;max-width:600px;overflow:hidden;border:1px solid #f4dce7;background:#ffffff;">
    <div style="padding:22px 32px;background:#ffffff;"><img src="{$journalLogoUrl}" alt="{$journalTitle}" style="display:block;max-width:180px;max-height:42px;width:auto;height:auto;"><div style="margin-top:8px;color:#64748b;font-size:11px;font-weight:700;letter-spacing:1.5px;text-transform:uppercase;">Scholarly journal</div></div>
    <div style="background:#9d3953;padding:28px 32px;color:#ffffff;">
      <div style="font-size:12px;font-weight:700;letter-spacing:2px;text-transform:uppercase;">{$journalTitle}</div>
      <div style="margin-top:22px;font-size:28px;font-weight:700;line-height:1.2;">Reset your password</div>
    </div>
    <div style="padding:32px;">
      <p style="margin:0 0 18px;font-size:16px;line-height:1.6;">Hello {$recipientName},</p>
      <p style="margin:0 0 24px;font-size:15px;line-height:1.7;color:#475569;">We received a request to reset the password for your {$journalTitle} account. Click the button below to choose a new password.</p>
      <p style="margin:0 0 28px;"><a href="{$passwordResetUrl}" style="display:inline-block;background:#9d3953;padding:14px 22px;color:#ffffff;font-size:13px;font-weight:700;letter-spacing:1px;text-decoration:none;text-transform:uppercase;">Reset password</a></p>
      <p style="margin:0 0 12px;font-size:13px;line-height:1.6;color:#64748b;">If the button does not work, copy and paste this link into your browser:</p>
      <p style="margin:0;word-break:break-all;font-size:12px;line-height:1.6;"><a href="{$passwordResetUrl}" style="color:#9d3953;">{$passwordResetUrl}</a></p>
      <div style="margin-top:28px;border-top:1px solid #f4dce7;padding-top:20px;font-size:13px;line-height:1.6;color:#64748b;">If you did not request a password reset, you can safely ignore this email.</div>
    </div>
    <div style="border-top:1px solid #f4dce7;background:#fff8fb;padding:20px 32px;font-size:12px;line-height:1.6;color:#64748b;">{$journalTitle}</div>
  </div>
</div>
HTML);

            return Hook::CONTINUE;
        });
        Hook::add('Email::send::before', function (string $hookName, array $args): int {
            $message = $args['message'] ?? null;
            if (!$message || !method_exists($message, 'getFrom') || !method_exists($message, 'from')) {
                return Hook::CONTINUE;
            }

            $from = $message->getFrom();
            $replyTo = method_exists($message, 'getReplyTo') ? $message->getReplyTo() : [];
            $context = \APP\core\Application::get()->getRequest()->getContext();
            $journalName = $context
                ? htmlspecialchars($context->getLocalizedName(), ENT_QUOTES, 'UTF-8')
                : 'Thalibul Ilmi: Journal of Teaching and Learning';
            if ($from && $journalName) {
                $message->from(new \Symfony\Component\Mime\Address($from[0]->getAddress(), $journalName));
                if ($replyTo && method_exists($message, 'replyTo')) {
                    $message->replyTo(new \Symfony\Component\Mime\Address($replyTo[0]->getAddress(), $journalName));
                }
            }

            if (self::$passwordResetEmail || !method_exists($message, 'getHtmlBody') || !method_exists($message, 'html')) {
                self::$passwordResetEmail = false;
                return Hook::CONTINUE;
            }

            $html = $message->getHtmlBody();
            if (!$html && method_exists($message, 'getTextBody')) {
                $text = $message->getTextBody();
                $html = $text ? nl2br(htmlspecialchars($text, ENT_QUOTES, 'UTF-8')) : '';
            }
            if ($html && !str_contains($html, 'data-thalibul-pink-email')) {
                $logoUrl = htmlspecialchars(\PKP\config\Config::getVar('general', 'base_url') . '/plugins/themes/thalibulpink/logo_small.png', ENT_QUOTES, 'UTF-8');
                $message->html('<div data-thalibul-pink-email="1" style="margin:0;background:#fff8fb;padding:32px 16px;font-family:Arial,Helvetica,sans-serif;color:#172033;"><div style="margin:0 auto;max-width:600px;border:1px solid #f4dce7;background:#ffffff;"><div style="padding:22px 32px;background:#ffffff;"><img src="' . $logoUrl . '" alt="' . $journalName . '" style="display:block;max-width:180px;max-height:42px;width:auto;height:auto;"><div style="margin-top:8px;color:#64748b;font-size:11px;font-weight:700;letter-spacing:1.5px;text-transform:uppercase;">Scholarly journal</div></div><div style="background:#9d3953;padding:24px 32px;color:#ffffff;font-size:13px;font-weight:700;letter-spacing:1.5px;text-transform:uppercase;">' . $journalName . '</div><div style="padding:32px;font-size:15px;line-height:1.7;">' . $html . '</div><div style="border-top:1px solid #f4dce7;background:#fff8fb;padding:20px 32px;font-size:12px;line-height:1.6;color:#64748b;">' . $journalName . '</div></div></div>');
            }
            self::$passwordResetEmail = false;
            return Hook::CONTINUE;
        });
        Hook::add('TemplateManager::display', function (string $hookName, array $args): int {
            $templateManager = $args[0];
            $template = $args[1];
            if (str_ends_with($template, 'frontend/pages/article.tpl')) {
                $article = $templateManager->getTemplateVars('article');
                $stats = [];
                if ($article) {
                    try {
                        $stats = app()->get('publicationStats')->getTotalsByType($article->getId(), $article->getData('contextId'), null, null);
                    } catch (\Throwable) {
                    }
                }
                $templateManager->assign('thalibulPinkArticleStats', $stats);
                return Hook::CONTINUE;
            }
            if (str_ends_with($template, 'frontend/pages/search.tpl')) {
                $results = $templateManager->getTemplateVars('results');
                $searchResults = $results && method_exists($results, 'toArray') ? $results->toArray() : [];
                $stats = [];
                foreach ($searchResults as $result) {
                    $article = $result['publishedSubmission'] ?? null;
                    if (!$article) {
                        continue;
                    }
                    try {
                        $stats[$article->getId()] = app()->get('publicationStats')->getTotalsByType(
                            $article->getId(),
                            $article->getData('contextId'),
                            null,
                            null
                        );
                    } catch (\Throwable) {
                        $stats[$article->getId()] = [];
                    }
                }
                $templateManager->assign('thalibulPinkSearchResults', $searchResults);
                $templateManager->assign('thalibulPinkSearchStats', $stats);
                return Hook::CONTINUE;
            }
            if (str_ends_with($template, 'frontend/pages/issue.tpl')) {
                $stats = [];
                $dois = [];
                $popularArticle = null;
                $popularScore = -1;
                foreach ($templateManager->getTemplateVars('publishedSubmissions') ?? [] as $section) {
                    foreach ($section['articles'] ?? [] as $article) {
                        try {
                            $stats[$article->getId()] = app()->get('publicationStats')->getTotalsByType($article->getId(), $article->getData('contextId'), null, null);
                        } catch (\Throwable) {
                            $stats[$article->getId()] = [];
                        }
                        $doiObject = $article->getCurrentPublication()->getData('doiObject');
                        $dois[$article->getId()] = $doiObject ? $doiObject->getData('resolvingUrl') : '';
                        $score = (int) ($stats[$article->getId()]['abstract'] ?? 0) + (int) ($stats[$article->getId()]['pdf'] ?? 0) + (int) ($stats[$article->getId()]['html'] ?? 0);
                        if ($score > $popularScore) {
                            $popularScore = $score;
                            $popularArticle = $article;
                        }
                    }
                }
                $templateManager->assign('thalibulPinkIssueStats', $stats);
                $templateManager->assign('thalibulPinkIssueDois', $dois);
                $templateManager->assign('thalibulPinkPopularIssueArticle', $popularArticle);
                return Hook::CONTINUE;
            }
            if (!str_ends_with($template, 'frontend/pages/indexJournal.tpl')) {
                return Hook::CONTINUE;
            }

            $stats = [];
            foreach ($templateManager->getTemplateVars('publishedSubmissions') ?? [] as $section) {
                foreach ($section['articles'] ?? [] as $article) {
                    try {
                        $stats[$article->getId()] = app()->get('publicationStats')->getTotalsByType(
                            $article->getId(),
                            $article->getData('contextId'),
                            null,
                            null
                        );
                    } catch (\Throwable) {
                        $stats[$article->getId()] = [];
                    }
                }
            }
            $templateManager->assign('thalibulPinkStats', $stats);
            return Hook::CONTINUE;
        });
    }

    public function getDisplayName()
    {
        return __('plugins.themes.thalibulpink.name');
    }

    public function getDescription()
    {
        return __('plugins.themes.thalibulpink.description');
    }
}
