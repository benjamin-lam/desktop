<?php
declare(strict_types=1);

namespace Blame76\AdminShareLinks\Model;

use InvalidArgumentException;

class TargetResolver
{
    /**
     * @return array<string, mixed>
     */
    public function resolve(string $type, int $entityId): array
    {
        $type = strtolower(trim($type));

        if ($entityId <= 0) {
            throw new InvalidArgumentException('Invalid entity ID.');
        }

        $map = [
            'product' => [
                'route' => 'catalog/product/edit',
                'params' => ['id' => $entityId],
                'acl' => 'Magento_Catalog::products',
                'label' => 'Product'
            ],
            'customer' => [
                'route' => 'customer/index/edit',
                'params' => ['id' => $entityId],
                'acl' => 'Magento_Customer::manage',
                'label' => 'Customer'
            ],
            'order' => [
                'route' => 'sales/order/view',
                'params' => ['order_id' => $entityId],
                'acl' => 'Magento_Sales::sales_order',
                'label' => 'Order'
            ],
        ];

        if (!isset($map[$type])) {
            throw new InvalidArgumentException(sprintf('Unsupported target type "%s".', $type));
        }

        return $map[$type];
    }

    /**
     * @return array<string, string>
     */
    public function getSupportedTypes(): array
    {
        return [
            'product' => 'Product',
            'customer' => 'Customer',
            'order' => 'Order',
        ];
    }
}
