<?php
declare(strict_types=1);

namespace Blame76\AdminShareLinks\Controller\Adminhtml\Index;

use Magento\Backend\App\Action;
use Magento\Backend\App\Action\Context;
use Magento\Framework\View\Result\Page;
use Magento\Framework\View\Result\PageFactory;

class Index extends Action
{
    public const ADMIN_RESOURCE = 'Blame76_AdminShareLinks::generator';

    public function __construct(
        Context $context,
        private readonly PageFactory $pageFactory
    ) {
        parent::__construct($context);
    }

    public function execute(): Page
    {
        $page = $this->pageFactory->create();
        $page->setActiveMenu('Blame76_AdminShareLinks::generator');
        $page->getConfig()->getTitle()->prepend(__('Admin Share Links'));

        return $page;
    }
}
