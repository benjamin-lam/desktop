<?php
declare(strict_types=1);

namespace Blame76\AdminShareLinks\Controller\Adminhtml\Link;

use Blame76\AdminShareLinks\Model\TargetResolver;
use Magento\Backend\App\Action;
use Magento\Backend\App\Action\Context;
use Magento\Framework\App\RequestInterface;
use Magento\Framework\Controller\Result\Redirect;
use Magento\Framework\Controller\Result\RedirectFactory;
use Psr\Log\LoggerInterface;
use Throwable;

class Go extends Action
{
    public const ADMIN_RESOURCE = 'Blame76_AdminShareLinks::redirect';

    public function __construct(
        Context $context,
        private readonly TargetResolver $targetResolver,
        private readonly RedirectFactory $redirectFactory,
        private readonly LoggerInterface $logger
    ) {
        parent::__construct($context);
    }

    public function execute(): Redirect
    {
        $resultRedirect = $this->redirectFactory->create();

        try {
            $type = (string)$this->getRequest()->getParam('type');
            $id = (int)$this->getRequest()->getParam('id');

            $target = $this->targetResolver->resolve($type, $id);

            if (!$this->_authorization->isAllowed($target['acl'])) {
                $this->messageManager->addErrorMessage(
                    __('You are not allowed to open this target.')
                );

                return $resultRedirect->setPath('admin/dashboard/index');
            }

            return $resultRedirect->setPath(
                $target['route'],
                $target['params']
            );
        } catch (Throwable $e) {
            $this->logger->warning(
                'Admin share link failed.',
                [
                    'message' => $e->getMessage(),
                    'request_params' => $this->getSafeRequestParams($this->getRequest())
                ]
            );

            $this->messageManager->addErrorMessage(
                __('The share link is invalid or could not be resolved.')
            );

            return $resultRedirect->setPath('blame76share/index/index');
        }
    }

    /**
     * @return array<string, mixed>
     */
    private function getSafeRequestParams(RequestInterface $request): array
    {
        $params = $request->getParams();

        unset($params['key'], $params['form_key']);

        return $params;
    }
}
