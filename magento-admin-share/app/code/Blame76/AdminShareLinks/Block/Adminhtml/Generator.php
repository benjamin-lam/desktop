<?php
declare(strict_types=1);

namespace Blame76\AdminShareLinks\Block\Adminhtml;

use Blame76\AdminShareLinks\Model\TargetResolver;
use Magento\Backend\Block\Template;
use Magento\Backend\Block\Template\Context;

class Generator extends Template
{
    protected $_template = 'Blame76_AdminShareLinks::generator.phtml';

    public function __construct(
        Context $context,
        private readonly TargetResolver $targetResolver,
        array $data = []
    ) {
        parent::__construct($context, $data);
    }

    /**
     * @return array<string, string>
     */
    public function getSupportedTypes(): array
    {
        return $this->targetResolver->getSupportedTypes();
    }

    public function getShareBaseUrl(): string
    {
        return $this->getUrl('blame76share/link/go', ['_current' => false]);
    }

    public function getExampleUrl(): string
    {
        return $this->getUrl('blame76share/link/go', [
            '_current' => false,
            'type' => 'product',
            'id' => 123
        ]);
    }

    public function escapeJsQuote(string $value): string
    {
        return str_replace("'", "\\'", $value);
    }
}
